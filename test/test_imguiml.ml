open Imguiml
open Ctypes

let null typ = from_voidp typ Ctypes.null

let () =
  Format.printf "Creating context: %s@\n" (Bindings.get_version ());
  assert (
    Bindings.debug_check_version_and_data_layout (Bindings.get_version ())
      (sizeof Types.Io.t) (sizeof Types.Style.t) (sizeof Types.Vec2.t)
      (sizeof Types.Vec4.t) (sizeof Types.DrawVert.t) (sizeof Types.draw_idx_t));
  let _ = Bindings.create_context (null Types.FontAtlas.t) in
  let io = Bindings.get_io_nil () in
  (* No renderer: say textures are taken care of, so that ImGui rasterises
     glyphs as it needs them, as it does for a renderer that handles them. *)
  io |-> Types.Io.backend_flags
  <-@ (!@(io |-> Types.Io.backend_flags)
      lor Int64.to_int Types.BackendFlags.renderer_has_textures);
  for n = 0 to 20 do
    Format.printf "New frame: %d@\n" n;
    let display_size = make Types.Vec2.t in
    setf display_size Types.Vec2.x 1920.;
    setf display_size Types.Vec2.y 1080.;
    io |-> Types.Io.display_size <-@ display_size;
    io |-> Types.Io.delta_time <-@ 1. /. 60.;
    Bindings.new_frame ();
    let _ =
      Bindings.begin_ "Main window" (null bool)
        (Int64.to_int Types.WindowFlags.no_title_bar)
    in
    let f = allocate float 0.0 in
    Bindings.text "Hello World!";
    let _ = Bindings.slider_float "float" f 0. 1. "%.3f" 0 in
    Bindings.text
      (Format.sprintf "Application average %.3f ms/fame (%.1f FPS)"
         (1000. /. !@(io |-> Types.Io.framerate))
         !@(io |-> Types.Io.framerate));
    Bindings.end_ ();
    Bindings.show_demo_window (null bool);
    Bindings.render ()
  done;
  (* Its name, without the version of FreeType. *)
  Format.printf "Font loader: %s@\n"
    (List.hd
       (String.split_on_char ' '
          !@(!@(io |-> Types.Io.fonts) |-> Types.FontAtlas.font_loader_name)));
  Format.printf "FreeType's bold: %Ld@\n" Types.FreeTypeLoaderFlags.bold;
  Format.printf "%u@\n" (Int64.to_int Types.WindowFlags.no_title_bar);
  Format.printf "size: %d@\n" (sizeof Types.WindowFlags.t);
  Format.printf "DestroyContext()@\n";
  Bindings.destroy_context (null Types.Context.t)

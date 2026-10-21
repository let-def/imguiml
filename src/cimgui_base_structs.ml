open Ctypes
open Cimgui_types
module Base (S : Ctypes.TYPE) = struct
  open S
  
    module Vec2 = struct
      type t = vec2_t structure
      let t : t typ = structure "ImVec2_c"
      let x = field t "x" float
      let y = field t "y" float
      let () = seal t
    end
    
    module Vec4 = struct
      type t = vec4_t structure
      let t : t typ = structure "ImVec4_c"
      let x = field t "x" float
      let y = field t "y" float
      let z = field t "z" float
      let w = field t "w" float
      let () = seal t
    end
    
    module TextureRef = struct
      type t = texture_ref_t structure
      let t : t typ = structure "ImTextureRef_c"
      let tex_data = field t "_TexData" (ptr (lift_typ texture_data_t))
      let tex_id = field t "_TexID" (lift_typ texture_id_t)
      let () = seal t
    end
    
    module Vec2i = struct
      type t = vec2i_t structure
      let t : t typ = structure "ImVec2i_c"
      let x = field t "x" int
      let y = field t "y" int
      let () = seal t
    end
    
    module Vec2ih = struct
      type t = vec2ih_t structure
      let t : t typ = structure "ImVec2ih"
      let x = field t "x" short
      let y = field t "y" short
      let () = seal t
    end
    
    module Rect = struct
      type t = rect_t structure
      let t : t typ = structure "ImRect_c"
      let min = field t "Min" (lift_typ vec2_t)
      let max = field t "Max" (lift_typ vec2_t)
      let () = seal t
    end
    
  
end
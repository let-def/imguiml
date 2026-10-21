module Types = struct
  (** This module defines the cimgui types. Every typedef from cimgui have a type that ends with
      [_t] and every structure defined in cimgui have a module with the structure name, stripped
      of the [Im] or [ImGui] prefix.*)

  include Cimgui_bindings.Types
  (** @inline *)
end

module Bindings = struct
  (** This module contains the bindings to cimgui functions and methods. Methods
   are accessible via modules that have the same name as the Dear ImGUI class they
   belong to. *)

  include Cimgui_bindings.Bindings (Cimgui_bindings_generated)
  (** @inline *)
end

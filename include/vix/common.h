#ifndef VIX_COMMON_H
#define VIX_COMMON_H

#include <gdnative_api_struct.gen.h>

const godot_gdnative_core_api_struct *gdnative_api;
const godot_gdnative_ext_nativescript_api_struct *nativescript_api;


// Defines a new GDObject named "name" which extends "extends"
#define DEFINE_OBJECT(name, extends)                                          \
    godot_instance_create_func create_## name = { NULL, NULL, NULL };         \
    create_## name .create_func = &( name ##_constructor);                    \
                                                                              \
    godot_instance_destroy_func destroy_## name = { NULL, NULL, NULL };       \
    destroy.destroy_func = &( name ##_destructor);                            \
                                                                              \
    nativescript_api->godot_nativescript_register_class(                      \
	p_handle,                                                             \
	"name", "extends",                                                    \
        create, destroy                                                       \
    )


// Defines a new method on "owner" with the name "name" and attributes
// "attributes". After using this, you can refer to some newly created
// variables from within the calling function.
//
// The method instance can be referred to matching the format:
//   "instance_{{ owner }}_{{ name }}".
//
// The attributes object can be referenced as:
//   "attributes_{{ owner }}_{{ name }}"

#define DEFINE_METHOD(owner, name, attributes)                                \
    godot_instance_method instance_## owner ##_## name = {NULL, NULL, NULL};  \
    ( instance_## owner ##_## name ).method = &( owner ##_## name );          \
    godot_method_attributes attributes_## owner ##_## name = { attributes };  \
    nativescript_api->godot_nativescript_register_method(                     \
	p_handle,                                                             \
	"owner",                                                              \
	"name",                                                               \
        attributes_## owner ##_## name ,                                      \
	instance_## owner ##_## name                                          \
    )

#endif

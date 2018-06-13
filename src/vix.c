#include "vix/common.h"


void GDN_EXPORT godot_gdnative_init(godot_gdnative_init_options *p_options) {
    gdnative_api = p_options->api_struct;

    // now find our extensions
    for (int i = 0; i < gdnative_api->num_extensions; i++) {
	switch (gdnative_api->extensions[i]->type) {
	    case GDNATIVE_EXT_NATIVESCRIPT:
		nativescript_api = (godot_gdnative_ext_nativescript_api_struct *)gdnative_api->extensions[i];
		break;
	}
    }
}

void GDN_EXPORT godot_gdnative_terminate(godot_gdnative_terminate_options *p_options) {
    gdnative_api = NULL;
    nativescript_api = NULL;
}

void GDN_EXPORT godot_nativescript_init(void *p_handle) {
}

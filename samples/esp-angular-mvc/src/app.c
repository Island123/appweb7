/*
    app.c -- Blog Application Module

    This module is loaded when Appweb starts.
 */
#include "esp.h"

/*
    This base for controllers is called before processing each request
 */
static void base(HttpConn *conn) {
}

ESP_EXPORT int esp_app_blog(HttpRoute *route, MprModule *module) {
    espDefineBase(route, base);
    return 0;
}

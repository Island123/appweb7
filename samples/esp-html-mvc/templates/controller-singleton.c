/*
    ${NAME} Controller
 */
#include "esp.h"

/*
    Create a new resource in the database
 */
static void create${TITLE}() { 
    if (updateRec(createRec("${NAME}", params()))) {
        flash("inform", "New ${NAME} created");
        renderView("${NAME}/${NAME}-list");
    } else {
        renderView("${NAME}/${NAME}-edit");
    }
}

/*
    Prepare an edit template with the resource
 */
static void edit${TITLE}() { 
    readRec("${NAME}", param("id"));
}

/*
    Get a resource
 */
static void get${TITLE}() { 
    readRec("${NAME}", param("id"));
    renderView("${NAME}/${NAME}-edit");
}

/*
    Initialize a new resource for the client to complete
 */
static void init${TITLE}() { 
    createRec("${NAME}", 0);
    renderView("${NAME}/${NAME}-edit");
}

/*
    Remove a resource identified by the "id" parameter
 */
static void remove${TITLE}() { 
    if (removeRec("${NAME}", param("id"))) {
        flash("inform", "${TITLE} removed");
    }
    redirect("list");
}

/*
    Update an existing resource in the database
    If "id" is not defined, this is the same as a create
    Also we tunnel delete here if the user clicked delete
 */
static void update${TITLE}() { 
    if (smatch(param("submit"), "Delete")) {
        removePost();
    } else {
        if (updateFields("${NAME}", params())) {
            flash("inform", "${TITLE} updated successfully.");
            redirect("list");
        } else {
            renderView("${NAME}/${NAME}-edit");
        }
    }
}

static void common(HttpConn *conn) {
}


/*
    Dynamic module initialization
 */
ESP_EXPORT int esp_controller_${APP}_${NAME}(HttpRoute *route, MprModule *module) {
    espDefineBase(route, common);
    espDefineAction(route, "${NAME}-create", create${TITLE});
    espDefineAction(route, "${NAME}-remove", remove${TITLE});
    espDefineAction(route, "${NAME}-edit", edit${TITLE});
    espDefineAction(route, "${NAME}-get", get${TITLE});
    espDefineAction(route, "${NAME}-init", init${TITLE});
    espDefineAction(route, "${NAME}-list", list${TITLE});
    espDefineAction(route, "${NAME}-update", update${TITLE});
${DEFINE_ACTIONS}    
#if SAMPLE_VALIDATIONS
    Edi *edi = espGetRouteDatabase(route);
    ediAddValidation(edi, "present", "${NAME}", "title", 0);
    ediAddValidation(edi, "unique", "${NAME}", "title", 0);
    ediAddValidation(edi, "format", "${NAME}", "message", "(dog|cat)");
#endif
    return 0;
}

pub const ComponentType = enum {
    hana,
    hana_node,
    abap,
    ascs,
    dialog,
    webdisp,
    wd,
    ers,

    pub const json_field_names = .{
        .hana = "HANA",
        .hana_node = "HANA_NODE",
        .abap = "ABAP",
        .ascs = "ASCS",
        .dialog = "DIALOG",
        .webdisp = "WEBDISP",
        .wd = "WD",
        .ers = "ERS",
    };
};

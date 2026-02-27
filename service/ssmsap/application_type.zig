pub const ApplicationType = enum {
    hana,
    sap_abap,

    pub const json_field_names = .{
        .hana = "HANA",
        .sap_abap = "SAP_ABAP",
    };
};

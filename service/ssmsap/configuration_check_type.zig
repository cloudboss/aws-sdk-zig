pub const ConfigurationCheckType = enum {
    sap_check_01,
    sap_check_02,
    sap_check_03,

    pub const json_field_names = .{
        .sap_check_01 = "SAP_CHECK_01",
        .sap_check_02 = "SAP_CHECK_02",
        .sap_check_03 = "SAP_CHECK_03",
    };
};

pub const ProcurementPortalName = enum {
    sap_business_network,
    coupa,

    pub const json_field_names = .{
        .sap_business_network = "SAP_BUSINESS_NETWORK",
        .coupa = "COUPA",
    };
};

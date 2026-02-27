pub const PhysicalConnectorType = enum {
    rj45,
    sfp_plus,
    qsfp,
    rj45_2,
    wifi,

    pub const json_field_names = .{
        .rj45 = "RJ45",
        .sfp_plus = "SFP_PLUS",
        .qsfp = "QSFP",
        .rj45_2 = "RJ45_2",
        .wifi = "WIFI",
    };
};

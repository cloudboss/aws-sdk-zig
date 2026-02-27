pub const DeviceSoftwareSetComplianceStatus = enum {
    none,
    compliant,
    not_compliant,

    pub const json_field_names = .{
        .none = "NONE",
        .compliant = "COMPLIANT",
        .not_compliant = "NOT_COMPLIANT",
    };
};

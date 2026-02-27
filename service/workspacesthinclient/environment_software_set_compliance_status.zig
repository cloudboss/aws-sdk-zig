pub const EnvironmentSoftwareSetComplianceStatus = enum {
    no_registered_devices,
    compliant,
    not_compliant,

    pub const json_field_names = .{
        .no_registered_devices = "NO_REGISTERED_DEVICES",
        .compliant = "COMPLIANT",
        .not_compliant = "NOT_COMPLIANT",
    };
};

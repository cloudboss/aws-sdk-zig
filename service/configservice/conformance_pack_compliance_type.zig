pub const ConformancePackComplianceType = enum {
    compliant,
    non_compliant,
    insufficient_data,

    pub const json_field_names = .{
        .compliant = "COMPLIANT",
        .non_compliant = "NON_COMPLIANT",
        .insufficient_data = "INSUFFICIENT_DATA",
    };
};

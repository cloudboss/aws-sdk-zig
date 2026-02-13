pub const PatchComplianceStatus = enum {
    compliant,
    non_compliant,

    pub const json_field_names = .{
        .compliant = "Compliant",
        .non_compliant = "NonCompliant",
    };
};

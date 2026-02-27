pub const FindingReasonCode = enum {
    memory_over_provisioned,
    memory_under_provisioned,

    pub const json_field_names = .{
        .memory_over_provisioned = "MEMORY_OVER_PROVISIONED",
        .memory_under_provisioned = "MEMORY_UNDER_PROVISIONED",
    };
};

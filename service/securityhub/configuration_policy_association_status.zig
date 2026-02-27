pub const ConfigurationPolicyAssociationStatus = enum {
    pending,
    success,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .success = "SUCCESS",
        .failed = "FAILED",
    };
};

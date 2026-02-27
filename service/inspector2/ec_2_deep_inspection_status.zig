pub const Ec2DeepInspectionStatus = enum {
    activated,
    deactivated,
    pending,
    failed,

    pub const json_field_names = .{
        .activated = "ACTIVATED",
        .deactivated = "DEACTIVATED",
        .pending = "PENDING",
        .failed = "FAILED",
    };
};

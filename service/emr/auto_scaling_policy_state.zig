pub const AutoScalingPolicyState = enum {
    pending,
    attaching,
    attached,
    detaching,
    detached,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .attaching = "ATTACHING",
        .attached = "ATTACHED",
        .detaching = "DETACHING",
        .detached = "DETACHED",
        .failed = "FAILED",
    };
};

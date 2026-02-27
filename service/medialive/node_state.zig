/// Used in DescribeNodeSummary.
pub const NodeState = enum {
    created,
    registering,
    ready_to_activate,
    registration_failed,
    activation_failed,
    active,
    ready,
    in_use,
    deregistering,
    draining,
    deregistration_failed,
    deregistered,

    pub const json_field_names = .{
        .created = "CREATED",
        .registering = "REGISTERING",
        .ready_to_activate = "READY_TO_ACTIVATE",
        .registration_failed = "REGISTRATION_FAILED",
        .activation_failed = "ACTIVATION_FAILED",
        .active = "ACTIVE",
        .ready = "READY",
        .in_use = "IN_USE",
        .deregistering = "DEREGISTERING",
        .draining = "DRAINING",
        .deregistration_failed = "DEREGISTRATION_FAILED",
        .deregistered = "DEREGISTERED",
    };
};

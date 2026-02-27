pub const RoutingCriteriaStepStatus = enum {
    active,
    inactive,
    joined,
    expired,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .joined = "JOINED",
        .expired = "EXPIRED",
    };
};

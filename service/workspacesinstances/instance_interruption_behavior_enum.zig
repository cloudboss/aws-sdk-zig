pub const InstanceInterruptionBehaviorEnum = enum {
    hibernate,
    stop,

    pub const json_field_names = .{
        .hibernate = "HIBERNATE",
        .stop = "STOP",
    };
};

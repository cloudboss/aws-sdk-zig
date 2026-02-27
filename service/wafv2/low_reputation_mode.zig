pub const LowReputationMode = enum {
    active_under_ddos,
    always_on,

    pub const json_field_names = .{
        .active_under_ddos = "ACTIVE_UNDER_DDOS",
        .always_on = "ALWAYS_ON",
    };
};

pub const StageTransitionType = enum {
    inbound,
    outbound,

    pub const json_field_names = .{
        .inbound = "Inbound",
        .outbound = "Outbound",
    };
};

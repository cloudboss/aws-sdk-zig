pub const NetworkDirection = enum {
    inbound,
    outbound,

    pub const json_field_names = .{
        .inbound = "INBOUND",
        .outbound = "OUTBOUND",
    };
};

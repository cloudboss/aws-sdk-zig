pub const AccessDirection = enum {
    inbound,
    outbound,

    pub const json_field_names = .{
        .inbound = "inbound",
        .outbound = "outbound",
    };
};

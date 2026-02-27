pub const AcceptType = enum {
    delivered,
    read,

    pub const json_field_names = .{
        .delivered = "DELIVERED",
        .read = "READ",
    };
};

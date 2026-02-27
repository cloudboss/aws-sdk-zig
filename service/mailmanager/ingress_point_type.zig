pub const IngressPointType = enum {
    open,
    auth,

    pub const json_field_names = .{
        .open = "OPEN",
        .auth = "AUTH",
    };
};

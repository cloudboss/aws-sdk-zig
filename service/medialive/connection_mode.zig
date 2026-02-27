/// Placeholder documentation for ConnectionMode
pub const ConnectionMode = enum {
    caller,
    listener,

    pub const json_field_names = .{
        .caller = "CALLER",
        .listener = "LISTENER",
    };
};

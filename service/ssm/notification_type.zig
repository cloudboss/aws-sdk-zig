pub const NotificationType = enum {
    command,
    invocation,

    pub const json_field_names = .{
        .command = "Command",
        .invocation = "Invocation",
    };
};

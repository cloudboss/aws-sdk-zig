pub const NotificationType = enum {
    task,
    event,

    pub const json_field_names = .{
        .task = "TASK",
        .event = "EVENT",
    };
};

pub const QuickConnectType = enum {
    user,
    queue,
    phone_number,
    flow,

    pub const json_field_names = .{
        .user = "USER",
        .queue = "QUEUE",
        .phone_number = "PHONE_NUMBER",
        .flow = "FLOW",
    };
};

pub const EventResponseType = enum {
    pass,
    fail,
    in_progress,

    pub const json_field_names = .{
        .pass = "Pass",
        .fail = "Fail",
        .in_progress = "InProgress",
    };
};

pub const EventType = enum {
    evaluation,
    custom,

    pub const json_field_names = .{
        .evaluation = "EVALUATION",
        .custom = "CUSTOM",
    };
};

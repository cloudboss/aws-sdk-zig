pub const TargetType = enum {
    recommendation,
    result,
    message,

    pub const json_field_names = .{
        .recommendation = "RECOMMENDATION",
        .result = "RESULT",
        .message = "MESSAGE",
    };
};

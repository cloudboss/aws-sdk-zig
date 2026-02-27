pub const FeedbackValueType = enum {
    valid,
    invalid,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
    };
};

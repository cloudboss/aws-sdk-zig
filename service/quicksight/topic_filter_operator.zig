pub const TopicFilterOperator = enum {
    string_equals,
    string_like,

    pub const json_field_names = .{
        .string_equals = "StringEquals",
        .string_like = "StringLike",
    };
};

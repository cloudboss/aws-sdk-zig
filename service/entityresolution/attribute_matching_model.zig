pub const AttributeMatchingModel = enum {
    one_to_one,
    many_to_many,

    pub const json_field_names = .{
        .one_to_one = "ONE_TO_ONE",
        .many_to_many = "MANY_TO_MANY",
    };
};

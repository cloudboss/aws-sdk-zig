/// Value of a segment annotation. Has one of three value types: Number,
/// Boolean, or String.
pub const AnnotationValue = union(enum) {
    /// Value for a Boolean annotation.
    boolean_value: ?bool,
    /// Value for a Number annotation.
    number_value: ?f64,
    /// Value for a String annotation.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .boolean_value = "BooleanValue",
        .number_value = "NumberValue",
        .string_value = "StringValue",
    };
};

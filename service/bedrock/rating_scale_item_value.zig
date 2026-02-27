/// Defines the value for one rating in a custom metric rating scale.
pub const RatingScaleItemValue = union(enum) {
    /// A floating point number representing the value for a rating in a custom
    /// metric rating scale.
    float_value: ?f32,
    /// A string representing the value for a rating in a custom metric rating
    /// scale.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .float_value = "floatValue",
        .string_value = "stringValue",
    };
};

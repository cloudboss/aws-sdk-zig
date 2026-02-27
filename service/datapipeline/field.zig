/// A key-value pair that describes a property of a pipeline object. The value
/// is specified as either a string value (`StringValue`) or a reference to
/// another object (`RefValue`) but not as both.
pub const Field = struct {
    /// The field identifier.
    key: []const u8,

    /// The field value, expressed as the identifier of another object.
    ref_value: ?[]const u8,

    /// The field value, expressed as a String.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .ref_value = "refValue",
        .string_value = "stringValue",
    };
};

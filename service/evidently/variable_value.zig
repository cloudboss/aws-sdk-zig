/// The value assigned to a feature variation. This structure must contain
/// exactly one field. It can be `boolValue`, `doubleValue`, `longValue`, or
/// `stringValue`.
pub const VariableValue = union(enum) {
    /// If this feature uses the Boolean variation type, this field contains the
    /// Boolean value of this variation.
    bool_value: ?bool,
    /// If this feature uses the double integer variation type, this field contains
    /// the double integer value of this variation.
    double_value: ?f64,
    /// If this feature uses the long variation type, this field contains the long
    /// value of this variation.
    long_value: ?i64,
    /// If this feature uses the string variation type, this field contains the
    /// string value of this variation.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .bool_value = "boolValue",
        .double_value = "doubleValue",
        .long_value = "longValue",
        .string_value = "stringValue",
    };
};

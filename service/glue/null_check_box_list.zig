/// Represents whether certain values are recognized as null values for removal.
pub const NullCheckBoxList = struct {
    /// Specifies that an empty string is considered as a null value.
    is_empty: ?bool,

    /// Specifies that an integer value of -1 is considered as a null value.
    is_neg_one: ?bool,

    /// Specifies that a value spelling out the word 'null' is considered as a null
    /// value.
    is_null_string: ?bool,

    pub const json_field_names = .{
        .is_empty = "IsEmpty",
        .is_neg_one = "IsNegOne",
        .is_null_string = "IsNullString",
    };
};

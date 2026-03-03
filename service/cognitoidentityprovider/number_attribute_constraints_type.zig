/// The minimum and maximum values of an attribute that is of the number type,
/// for example
/// `custom:age`.
pub const NumberAttributeConstraintsType = struct {
    /// The maximum length of a number attribute value. Must be a number less than
    /// or equal to
    /// `2^1023`, represented as a string with a length of 131072 characters or
    /// fewer.
    max_value: ?[]const u8 = null,

    /// The minimum value of an attribute that is of the number data type.
    min_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_value = "MaxValue",
        .min_value = "MinValue",
    };
};

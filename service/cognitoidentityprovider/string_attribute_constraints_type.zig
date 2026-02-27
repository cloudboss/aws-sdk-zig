/// The minimum and maximum length values of an attribute that is of the string
/// type, for
/// example `custom:department`.
pub const StringAttributeConstraintsType = struct {
    /// The maximum length of a string attribute value. Must be a number less than
    /// or equal to
    /// `2^1023`, represented as a string with a length of 131072 characters or
    /// fewer.
    max_length: ?[]const u8,

    /// The minimum length of a string attribute value.
    min_length: ?[]const u8,

    pub const json_field_names = .{
        .max_length = "MaxLength",
        .min_length = "MinLength",
    };
};

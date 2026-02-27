/// Defines enumeration validation for attribute values. Allows specifying a
/// list of permitted values and whether
/// custom values beyond the enumerated list are allowed.
pub const ValidationEnum = struct {
    /// Boolean that defaults to false. When true, only values specified in the enum
    /// list are allowed. When false,
    /// custom values beyond the enumerated list are permitted.
    strict: bool = false,

    /// A list of predefined values that are allowed for this attribute. These
    /// values are always permitted regardless of
    /// the Strict setting.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .strict = "Strict",
        .values = "Values",
    };
};

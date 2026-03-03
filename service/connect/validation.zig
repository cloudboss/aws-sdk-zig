const ValidationEnum = @import("validation_enum.zig").ValidationEnum;

/// Defines validation rules for data table attribute values. Based on JSON
/// Schema Draft 2020-12 with additional
/// Connect-specific validations. Validation rules ensure data integrity and
/// consistency across the data table.
pub const Validation = struct {
    /// Defines enumeration constraints for attribute values. Can specify a list of
    /// allowed values and whether custom
    /// values are permitted beyond the enumerated list.
    @"enum": ?ValidationEnum = null,

    /// The largest exclusive numeric value for NUMBER value type. Can be provided
    /// alongside Maximum where both operate
    /// independently. Must be greater than ExclusiveMinimum and Minimum. Applies to
    /// NUMBER and values within
    /// NUMBER_LIST.
    exclusive_maximum: f64 = 0,

    /// The smallest exclusive numeric value for NUMBER value type. Can be provided
    /// alongside Minimum where both operate
    /// independently. Must be less than ExclusiveMaximum and Maximum. Applies to
    /// NUMBER and values within
    /// NUMBER_LIST.
    exclusive_minimum: f64 = 0,

    /// Boolean that defaults to false. Applies to text lists and text primary
    /// attributes. When true, enforces
    /// case-insensitive uniqueness for primary attributes and allows
    /// case-insensitive lookups.
    ignore_case: bool = false,

    /// The largest inclusive numeric value for NUMBER value type. Can be provided
    /// alongside ExclusiveMaximum where both
    /// operate independently. Must be greater than or equal to Minimum and greater
    /// than ExclusiveMinimum. Applies to NUMBER
    /// and values within NUMBER_LIST.
    maximum: f64 = 0,

    /// The maximum number of characters a text value can contain. Applies to TEXT
    /// value type and values within a
    /// TEXT_LIST. Must be greater than or equal to MinLength.
    max_length: i32 = 0,

    /// The maximum number of values in a list. Must be an integer greater than or
    /// equal to 0 and greater than or equal
    /// to MinValues. Applies to all list types.
    max_values: i32 = 0,

    /// The smallest inclusive numeric value for NUMBER value type. Cannot be
    /// provided when ExclusiveMinimum is also
    /// provided. Must be less than or equal to Maximum and less than
    /// ExclusiveMaximum. Applies to NUMBER and values within
    /// NUMBER_LIST.
    minimum: f64 = 0,

    /// The minimum number of characters a text value can contain. Applies to TEXT
    /// value type and values within a
    /// TEXT_LIST. Must be less than or equal to MaxLength.
    min_length: i32 = 0,

    /// The minimum number of values in a list. Must be an integer greater than or
    /// equal to 0 and less than or equal to
    /// MaxValues. Applies to all list types.
    min_values: i32 = 0,

    /// Specifies that numeric values must be multiples of this number. Must be
    /// greater than 0. The result of dividing a
    /// value by this multiple must result in an integer. Applies to NUMBER and
    /// values within NUMBER_LIST.
    multiple_of: f64 = 0,

    pub const json_field_names = .{
        .@"enum" = "Enum",
        .exclusive_maximum = "ExclusiveMaximum",
        .exclusive_minimum = "ExclusiveMinimum",
        .ignore_case = "IgnoreCase",
        .maximum = "Maximum",
        .max_length = "MaxLength",
        .max_values = "MaxValues",
        .minimum = "Minimum",
        .min_length = "MinLength",
        .min_values = "MinValues",
        .multiple_of = "MultipleOf",
    };
};

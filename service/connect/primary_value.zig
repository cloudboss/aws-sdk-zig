/// Represents a primary key value used to identify a specific record in a data
/// table. Primary values are used in
/// combination to create unique record identifiers when a table has multiple
/// primary attributes.
pub const PrimaryValue = struct {
    /// The name of the primary attribute that this value belongs to.
    attribute_name: []const u8,

    /// The actual value for the primary attribute. Must be provided as a string
    /// regardless of the attribute's value
    /// type. Primary values cannot be expressions and must be explicitly specified.
    value: []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .value = "Value",
    };
};

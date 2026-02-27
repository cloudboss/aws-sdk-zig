/// Defines criteria for selecting resources based on field values.
pub const AdvancedFieldSelector = struct {
    /// Matches if the field value ends with the specified value.
    ends_with: ?[]const []const u8,

    /// Matches if the field value equals the specified value.
    equals: ?[]const []const u8,

    /// The name of the field to use for selection.
    field: []const u8,

    /// Matches if the field value does not end with the specified value.
    not_ends_with: ?[]const []const u8,

    /// Matches if the field value does not equal the specified value.
    not_equals: ?[]const []const u8,

    /// Matches if the field value does not start with the specified value.
    not_starts_with: ?[]const []const u8,

    /// Matches if the field value starts with the specified value.
    starts_with: ?[]const []const u8,

    pub const json_field_names = .{
        .ends_with = "EndsWith",
        .equals = "Equals",
        .field = "Field",
        .not_ends_with = "NotEndsWith",
        .not_equals = "NotEquals",
        .not_starts_with = "NotStartsWith",
        .starts_with = "StartsWith",
    };
};

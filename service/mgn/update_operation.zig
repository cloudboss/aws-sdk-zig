const aws = @import("aws");

/// An operation that updates the properties of a construct.
pub const UpdateOperation = struct {
    /// Whether to exclude this construct from the migration.
    excluded: ?bool = null,

    /// The updated name for the construct.
    name: ?[]const u8 = null,

    /// The properties to update on the construct.
    properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .excluded = "excluded",
        .name = "name",
        .properties = "properties",
    };
};

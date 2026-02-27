const GroupingAttributeDefinition = @import("grouping_attribute_definition.zig").GroupingAttributeDefinition;

/// A structure that contains the complete grouping configuration for an
/// account, including all defined grouping attributes and metadata about when
/// it was last updated.
pub const GroupingConfiguration = struct {
    /// An array of grouping attribute definitions that specify how services should
    /// be grouped based on various attributes and source keys.
    grouping_attribute_definitions: []const GroupingAttributeDefinition,

    /// The timestamp when this grouping configuration was last updated. When used
    /// in a raw HTTP Query API, it is formatted as epoch time in seconds.
    updated_at: i64,

    pub const json_field_names = .{
        .grouping_attribute_definitions = "GroupingAttributeDefinitions",
        .updated_at = "UpdatedAt",
    };
};

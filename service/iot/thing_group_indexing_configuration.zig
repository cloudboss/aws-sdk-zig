const Field = @import("field.zig").Field;
const ThingGroupIndexingMode = @import("thing_group_indexing_mode.zig").ThingGroupIndexingMode;

/// Thing group indexing configuration.
pub const ThingGroupIndexingConfiguration = struct {
    /// A list of thing group fields to index. This list cannot contain any managed
    /// fields. Use
    /// the GetIndexingConfiguration API to get a list of managed fields.
    ///
    /// Contains custom field names and their data type.
    custom_fields: ?[]const Field = null,

    /// Contains fields that are indexed and whose types are already known by the
    /// Fleet Indexing
    /// service. This is an optional field. For more information, see [Managed
    /// fields](https://docs.aws.amazon.com/iot/latest/developerguide/managing-fleet-index.html#managed-field) in the *Amazon Web Services IoT Core Developer Guide*.
    ///
    /// You can't modify managed fields by updating fleet indexing configuration.
    managed_fields: ?[]const Field = null,

    /// Thing group indexing mode.
    thing_group_indexing_mode: ThingGroupIndexingMode,

    pub const json_field_names = .{
        .custom_fields = "customFields",
        .managed_fields = "managedFields",
        .thing_group_indexing_mode = "thingGroupIndexingMode",
    };
};

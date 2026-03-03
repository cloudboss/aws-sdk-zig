const SchemaChangeDetails = @import("schema_change_details.zig").SchemaChangeDetails;

/// Extra details specific to this schema change type notification.
pub const SchemaChangeRequestDetails = struct {
    /// List
    /// of schema changes happening in the scope of this
    /// notification. This
    /// can have up to 100 entries.
    changes: ?[]const SchemaChangeDetails = null,

    /// A
    /// date in the future when the schema change is taking effect.
    schema_change_at: i64,

    pub const json_field_names = .{
        .changes = "Changes",
        .schema_change_at = "SchemaChangeAt",
    };
};

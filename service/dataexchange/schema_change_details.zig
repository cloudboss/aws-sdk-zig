const SchemaChangeType = @import("schema_change_type.zig").SchemaChangeType;

/// Object encompassing information about a schema change to a single,
/// particular field, a
/// notification can have up to 100 of these.
pub const SchemaChangeDetails = struct {
    /// Description
    /// of what's changing about this
    /// field. This value
    /// can be up to 512 characters long.
    description: ?[]const u8,

    /// Name
    /// of the changing
    /// field. This value
    /// can be up to 255 characters long.
    name: []const u8,

    /// Is
    /// the field being added, removed, or modified?
    type: SchemaChangeType,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .type = "Type",
    };
};

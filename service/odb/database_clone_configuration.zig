const CloneType = @import("clone_type.zig").CloneType;

/// The configuration for creating an Autonomous Database as a clone of an
/// existing database.
pub const DatabaseCloneConfiguration = struct {
    /// The type of clone to create, either a full clone, a metadata clone, or a
    /// partial clone.
    clone_type: CloneType,

    /// The unique identifier of the source Autonomous Database to clone.
    source_autonomous_database_id: []const u8,

    pub const json_field_names = .{
        .clone_type = "cloneType",
        .source_autonomous_database_id = "sourceAutonomousDatabaseId",
    };
};

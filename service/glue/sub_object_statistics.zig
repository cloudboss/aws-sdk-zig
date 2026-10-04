const SubObjectSourceType = @import("sub_object_source_type.zig").SubObjectSourceType;

/// Statistics for one sub-object referenced by a materialized view, recorded
/// when the
/// materialized view was created or last fully refreshed. These values describe
/// what that refresh
/// selected from the sub-object, which can be a subset of the table when the
/// materialized view's
/// definition limits the data it reads. The fields present depend on the
/// sub-object's format.
pub const SubObjectStatistics = struct {
    /// The number of sub-object data files selected for that refresh.
    file_count: ?i64 = null,

    /// The Glue version ID of the sub-object that the statistics were captured for.
    glue_version_id: ?[]const u8 = null,

    /// The number of sub-object partitions selected for that refresh. Not present
    /// for
    /// unpartitioned sub-objects.
    partition_count: ?i64 = null,

    /// The source type of the sub-object (for example, its table format), which
    /// identifies the
    /// sub-object.
    source_type: ?SubObjectSourceType = null,

    /// The total size, in bytes, of the data files counted by `FileCount`.
    total_file_bytes: ?i64 = null,

    pub const json_field_names = .{
        .file_count = "FileCount",
        .glue_version_id = "GlueVersionId",
        .partition_count = "PartitionCount",
        .source_type = "SourceType",
        .total_file_bytes = "TotalFileBytes",
    };
};

const SnapshotFilterName = @import("snapshot_filter_name.zig").SnapshotFilterName;

/// A filter used to restrict the results of `DescribeSnapshots` calls. You can
/// use multiple filters to return results that meet all applied filter
/// requirements.
pub const SnapshotFilter = struct {
    /// The name of the filter to use. You can filter by the `file-system-id` or by
    /// `volume-id`.
    name: ?SnapshotFilterName,

    /// The `file-system-id` or `volume-id` that you are filtering
    /// for.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};

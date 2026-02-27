const SnapshotJobResultFileGroup = @import("snapshot_job_result_file_group.zig").SnapshotJobResultFileGroup;

/// A structure that contains the file groups that are requested for the
/// artifact generation in a `StartDashboardSnapshotJob` API call.
pub const AnonymousUserSnapshotJobResult = struct {
    /// A list of `SnapshotJobResultFileGroup` objects that contain information on
    /// the files that are requested during a `StartDashboardSnapshotJob` API call.
    /// If the job succeeds, these objects contain the location where the snapshot
    /// artifacts are stored. If the job fails, the objects contain information
    /// about the error that caused the job to fail.
    file_groups: ?[]const SnapshotJobResultFileGroup,

    pub const json_field_names = .{
        .file_groups = "FileGroups",
    };
};

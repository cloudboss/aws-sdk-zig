const SnapshotFile = @import("snapshot_file.zig").SnapshotFile;
const SnapshotJobS3Result = @import("snapshot_job_s3_result.zig").SnapshotJobS3Result;

/// A structure that contains information on the generated snapshot file groups.
pub const SnapshotJobResultFileGroup = struct {
    /// A list of `SnapshotFile` objects.
    files: ?[]const SnapshotFile,

    /// A list of `SnapshotJobS3Result` objects.
    s3_results: ?[]const SnapshotJobS3Result,

    pub const json_field_names = .{
        .files = "Files",
        .s3_results = "S3Results",
    };
};

/// High level information for an SDK release.
pub const ReleaseSummary = struct {
    /// The release version.
    release_version: ?[]const u8,

    /// The timestamp of the release.
    timestamp: ?i64,

    pub const json_field_names = .{
        .release_version = "ReleaseVersion",
        .timestamp = "Timestamp",
    };
};

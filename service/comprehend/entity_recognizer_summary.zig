const ModelStatus = @import("model_status.zig").ModelStatus;

/// Describes the information about an entity recognizer and its versions.
pub const EntityRecognizerSummary = struct {
    /// The time that the latest entity recognizer version was submitted for
    /// processing.
    latest_version_created_at: ?i64 = null,

    /// The version name you assigned to the latest entity recognizer version.
    latest_version_name: ?[]const u8 = null,

    /// Provides the status of the latest entity recognizer version.
    latest_version_status: ?ModelStatus = null,

    /// The number of versions you created.
    number_of_versions: ?i32 = null,

    /// The name that you assigned the entity recognizer.
    recognizer_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .latest_version_created_at = "LatestVersionCreatedAt",
        .latest_version_name = "LatestVersionName",
        .latest_version_status = "LatestVersionStatus",
        .number_of_versions = "NumberOfVersions",
        .recognizer_name = "RecognizerName",
    };
};

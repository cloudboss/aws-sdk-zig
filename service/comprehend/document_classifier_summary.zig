const ModelStatus = @import("model_status.zig").ModelStatus;

/// Describes information about a document classifier and its versions.
pub const DocumentClassifierSummary = struct {
    /// The name that you assigned the document classifier.
    document_classifier_name: ?[]const u8,

    /// The time that the latest document classifier version was submitted for
    /// processing.
    latest_version_created_at: ?i64,

    /// The version name you assigned to the latest document classifier version.
    latest_version_name: ?[]const u8,

    /// Provides the status of the latest document classifier version.
    latest_version_status: ?ModelStatus,

    /// The number of versions you created.
    number_of_versions: ?i32,

    pub const json_field_names = .{
        .document_classifier_name = "DocumentClassifierName",
        .latest_version_created_at = "LatestVersionCreatedAt",
        .latest_version_name = "LatestVersionName",
        .latest_version_status = "LatestVersionStatus",
        .number_of_versions = "NumberOfVersions",
    };
};

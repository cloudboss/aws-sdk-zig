const VersionStatus = @import("version_status.zig").VersionStatus;

/// Annotation store versions.
pub const AnnotationStoreVersionItem = struct {
    /// The time stamp for when an annotation store version was created.
    creation_time: i64,

    /// The description of an annotation store version.
    description: []const u8,

    /// The annotation store version ID.
    id: []const u8,

    /// A name given to an annotation store version to distinguish it from others.
    name: []const u8,

    /// The status of an annotation store version.
    status: VersionStatus,

    /// The status of an annotation store version.
    status_message: []const u8,

    /// The store ID for an annotation store version.
    store_id: []const u8,

    /// The time stamp for when an annotation store version was updated.
    update_time: i64,

    /// The Arn for an annotation store version.
    version_arn: []const u8,

    /// The name of an annotation store version.
    version_name: []const u8,

    /// The size of an annotation store version in Bytes.
    version_size_bytes: i64,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
        .status_message = "statusMessage",
        .store_id = "storeId",
        .update_time = "updateTime",
        .version_arn = "versionArn",
        .version_name = "versionName",
        .version_size_bytes = "versionSizeBytes",
    };
};

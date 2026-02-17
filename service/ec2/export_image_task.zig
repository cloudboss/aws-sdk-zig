const ExportTaskS3Location = @import("export_task_s3_location.zig").ExportTaskS3Location;
const Tag = @import("tag.zig").Tag;

/// Describes an export image task.
pub const ExportImageTask = struct {
    /// A description of the image being exported.
    description: ?[]const u8,

    /// The ID of the export image task.
    export_image_task_id: ?[]const u8,

    /// The ID of the image.
    image_id: ?[]const u8,

    /// The percent complete of the export image task.
    progress: ?[]const u8,

    /// Information about the destination Amazon S3 bucket.
    s3_export_location: ?ExportTaskS3Location,

    /// The status of the export image task. The possible values are `active`,
    /// `completed`,
    /// `deleting`, and `deleted`.
    status: ?[]const u8,

    /// The status message for the export image task.
    status_message: ?[]const u8,

    /// Any tags assigned to the export image task.
    tags: ?[]const Tag,
};

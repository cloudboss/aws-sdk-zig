const ArtifactStatus = @import("artifact_status.zig").ArtifactStatus;

/// The case-insensitive input to indicate standard MIME type that describes the
/// format of the file
/// that will be uploaded.
pub const AttachmentItem = struct {
    /// A unique identifier for the attachment.
    attachment_id: ?[]const u8 = null,

    /// A case-sensitive name of the attachment being uploaded.
    attachment_name: ?[]const u8 = null,

    /// Describes the MIME file type of the attachment. For a list of supported file
    /// types, see [Feature
    /// specifications](https://docs.aws.amazon.com/connect/latest/adminguide/feature-limits.html) in the *Amazon Connect Administrator Guide*.
    content_type: ?[]const u8 = null,

    /// Status of the attachment.
    status: ?ArtifactStatus = null,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .attachment_name = "AttachmentName",
        .content_type = "ContentType",
        .status = "Status",
    };
};

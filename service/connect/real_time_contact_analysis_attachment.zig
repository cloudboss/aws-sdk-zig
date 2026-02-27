const ArtifactStatus = @import("artifact_status.zig").ArtifactStatus;

/// Object that describes attached file.
pub const RealTimeContactAnalysisAttachment = struct {
    /// A unique identifier for the attachment.
    attachment_id: []const u8,

    /// A case-sensitive name of the attachment being uploaded. Can be redacted.
    attachment_name: []const u8,

    /// Describes the MIME file type of the attachment. For a list of supported file
    /// types, see [Feature
    /// specifications](https://docs.aws.amazon.com/connect/latest/adminguide/feature-limits.html) in the
    /// *Amazon Connect Administrator Guide*.
    content_type: ?[]const u8,

    /// Status of the attachment.
    status: ?ArtifactStatus,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .attachment_name = "AttachmentName",
        .content_type = "ContentType",
        .status = "Status",
    };
};

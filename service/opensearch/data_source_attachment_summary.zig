const DataSourceAttachmentStatus = @import("data_source_attachment_status.zig").DataSourceAttachmentStatus;

/// Summary information about a data source attachment, including its
/// identifier, data source ARN, and current status.
pub const DataSourceAttachmentSummary = struct {
    /// The unique identifier assigned to the data source attachment.
    attachment_id: ?[]const u8 = null,

    data_source_arn: ?[]const u8 = null,

    /// The current status of the data source attachment. Valid values are
    /// `PENDING`, `ATTACHED`, and `FAILED`.
    status: ?DataSourceAttachmentStatus = null,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .data_source_arn = "dataSourceArn",
        .status = "status",
    };
};

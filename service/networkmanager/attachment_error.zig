const AttachmentErrorCode = @import("attachment_error_code.zig").AttachmentErrorCode;

/// Describes the error associated with an attachment request.
pub const AttachmentError = struct {
    /// The error code for the attachment request.
    code: ?AttachmentErrorCode = null,

    /// The message associated with the error `code`.
    message: ?[]const u8 = null,

    /// The ID of the attachment request.
    request_id: ?[]const u8 = null,

    /// The ARN of the requested attachment resource.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .request_id = "RequestId",
        .resource_arn = "ResourceArn",
    };
};

const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;
const AttachmentUploadErrorReason = @import("attachment_upload_error_reason.zig").AttachmentUploadErrorReason;

/// Provides information on the specified registration attachments.
pub const RegistrationAttachmentsInformation = struct {
    /// The status of the registration attachment.
    ///
    /// * `UPLOAD_IN_PROGRESS` The attachment is being uploaded.
    /// * `UPLOAD_COMPLETE` The attachment has been uploaded.
    /// * `UPLOAD_FAILED` The attachment failed to uploaded.
    /// * `DELETED` The attachment has been deleted..
    attachment_status: AttachmentStatus,

    /// A description of why the upload didn't successfully complete.
    attachment_upload_error_reason: ?AttachmentUploadErrorReason = null,

    /// The time when the registration attachment was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The Amazon Resource Name (ARN) for the registration attachment.
    registration_attachment_arn: []const u8,

    /// The unique identifier for the registration attachment.
    registration_attachment_id: []const u8,

    pub const json_field_names = .{
        .attachment_status = "AttachmentStatus",
        .attachment_upload_error_reason = "AttachmentUploadErrorReason",
        .created_timestamp = "CreatedTimestamp",
        .registration_attachment_arn = "RegistrationAttachmentArn",
        .registration_attachment_id = "RegistrationAttachmentId",
    };
};

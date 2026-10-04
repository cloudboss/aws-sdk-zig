const AttachmentDetails = @import("attachment_details.zig").AttachmentDetails;

/// A communication associated with a support case. The communication consists
/// of the case
/// ID, the message body, attachment information, the submitter of the
/// communication, and
/// the date and time of the communication.
pub const Communication = struct {
    /// Information about all attachments on the case communication. This includes
    /// attachments added through `AddAttachmentsToSet` and attachments uploaded
    /// through `GetAttachmentUploadLinks`.
    ///
    /// Use this field to enumerate every attachment on the communication. To
    /// download an attachment listed in this field, use GetAttachmentDownloadLink.
    /// `GetAttachmentDownloadLink` returns a presigned URL that works for
    /// attachments of any size.
    attachments: ?[]const AttachmentDetails = null,

    /// Information about the attachments to the case communication that are 5 MB or
    /// smaller.
    /// This field doesn't include attachments larger than 5 MB. To enumerate every
    /// attachment on
    /// the communication, including attachments larger than 5 MB, use the
    /// `attachments` field instead.
    attachment_set: ?[]const AttachmentDetails = null,

    /// The text of the communication between the customer and Amazon Web Services
    /// Support.
    body: ?[]const u8 = null,

    /// The support case ID requested or returned in the call. The case ID is an
    /// alphanumeric
    /// string formatted as shown in this example:
    /// case-*12345678910-exen-2025-c4c1d2bf33c5cf47*
    case_id: ?[]const u8 = null,

    /// The identity of the account that submitted, or responded to, the support
    /// case.
    /// Customer entries include the IAM role as well as the email address (for
    /// example,
    /// "AdminRole (Role) ). Entries from the Amazon Web Services Support team
    /// display
    /// "Amazon Web Services," and don't show an email address.
    submitted_by: ?[]const u8 = null,

    /// The time the communication was created.
    time_created: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "attachments",
        .attachment_set = "attachmentSet",
        .body = "body",
        .case_id = "caseId",
        .submitted_by = "submittedBy",
        .time_created = "timeCreated",
    };
};

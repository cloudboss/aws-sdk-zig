const AttachmentDetails = @import("attachment_details.zig").AttachmentDetails;

/// A communication associated with a support case. The communication consists
/// of the case
/// ID, the message body, attachment information, the submitter of the
/// communication, and
/// the date and time of the communication.
pub const Communication = struct {
    /// Information about the attachments to the case communication.
    attachment_set: ?[]const AttachmentDetails,

    /// The text of the communication between the customer and Amazon Web Services
    /// Support.
    body: ?[]const u8,

    /// The support case ID requested or returned in the call. The case ID is an
    /// alphanumeric
    /// string formatted as shown in this example:
    /// case-*12345678910-2013-c4c1d2bf33c5cf47*
    case_id: ?[]const u8,

    /// The identity of the account that submitted, or responded to, the support
    /// case.
    /// Customer entries include the IAM role as well as the email address (for
    /// example,
    /// "AdminRole (Role) ). Entries from the Amazon Web Services Support team
    /// display
    /// "Amazon Web Services," and don't show an email address.
    submitted_by: ?[]const u8,

    /// The time the communication was created.
    time_created: ?[]const u8,

    pub const json_field_names = .{
        .attachment_set = "attachmentSet",
        .body = "body",
        .case_id = "caseId",
        .submitted_by = "submittedBy",
        .time_created = "timeCreated",
    };
};

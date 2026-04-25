const AttachmentReference = @import("attachment_reference.zig").AttachmentReference;
const DateReference = @import("date_reference.zig").DateReference;
const EmailReference = @import("email_reference.zig").EmailReference;
const EmailMessageReference = @import("email_message_reference.zig").EmailMessageReference;
const NumberReference = @import("number_reference.zig").NumberReference;
const StringReference = @import("string_reference.zig").StringReference;
const UrlReference = @import("url_reference.zig").UrlReference;

/// Contains summary information about a reference. `ReferenceSummary` contains
/// only one non null field
/// between the URL and attachment based on the reference type.
pub const ReferenceSummary = union(enum) {
    /// Information about the reference when the `referenceType` is `ATTACHMENT`.
    /// Otherwise,
    /// null.
    attachment: ?AttachmentReference,
    /// Information about a reference when the `referenceType` is `DATE`. Otherwise,
    /// null.
    date: ?DateReference,
    /// Information about a reference when the `referenceType` is `EMAIL`.
    /// Otherwise, null.
    email: ?EmailReference,
    /// Information about the reference when the referenceType is `EMAIL_MESSAGE`.
    /// Otherwise, null.
    email_message: ?EmailMessageReference,
    email_message_plain_text: ?EmailMessageReference,
    email_message_plain_text_redacted: ?EmailMessageReference,
    email_message_redacted: ?EmailMessageReference,
    /// Information about a reference when the `referenceType` is `NUMBER`.
    /// Otherwise,
    /// null.
    number: ?NumberReference,
    /// Information about a reference when the `referenceType` is `STRING`.
    /// Otherwise,
    /// null.
    string: ?StringReference,
    /// Information about the reference when the `referenceType` is `URL`.
    /// Otherwise, null.
    url: ?UrlReference,

    pub const json_field_names = .{
        .attachment = "Attachment",
        .date = "Date",
        .email = "Email",
        .email_message = "EmailMessage",
        .email_message_plain_text = "EmailMessagePlainText",
        .email_message_plain_text_redacted = "EmailMessagePlainTextRedacted",
        .email_message_redacted = "EmailMessageRedacted",
        .number = "Number",
        .string = "String",
        .url = "Url",
    };
};

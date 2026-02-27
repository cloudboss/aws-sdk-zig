const ContactLanguage = @import("contact_language.zig").ContactLanguage;
const MailType = @import("mail_type.zig").MailType;
const ReviewDetails = @import("review_details.zig").ReviewDetails;

/// An object that contains information about your account details.
pub const AccountDetails = struct {
    /// Additional email addresses where updates are sent about your account review
    /// process.
    additional_contact_email_addresses: ?[]const []const u8,

    /// The language you would prefer for the case. The contact language can be one
    /// of
    /// `ENGLISH` or `JAPANESE`.
    contact_language: ?ContactLanguage,

    /// The type of email your account is sending. The mail type can be one of the
    /// following:
    ///
    /// * `MARKETING` – Most of your sending traffic is to keep your
    /// customers informed of your latest offering.
    ///
    /// * `TRANSACTIONAL` – Most of your sending traffic is to
    /// communicate during a transaction with a customer.
    mail_type: ?MailType,

    /// Information about the review of the latest details you submitted.
    review_details: ?ReviewDetails,

    /// A description of the types of email that you plan to send.
    use_case_description: ?[]const u8,

    /// The URL of your website. This information helps us better understand the
    /// type of
    /// content that you plan to send.
    website_url: ?[]const u8,

    pub const json_field_names = .{
        .additional_contact_email_addresses = "AdditionalContactEmailAddresses",
        .contact_language = "ContactLanguage",
        .mail_type = "MailType",
        .review_details = "ReviewDetails",
        .use_case_description = "UseCaseDescription",
        .website_url = "WebsiteURL",
    };
};

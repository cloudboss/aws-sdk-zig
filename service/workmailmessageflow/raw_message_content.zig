const S3Reference = @import("s3_reference.zig").S3Reference;

/// Provides the MIME content of the updated email message as an S3 object. All
/// MIME content must meet the following criteria:
///
/// * Each part of a multipart MIME message must be formatted properly.
///
/// * Attachments must be of a content type that Amazon SES supports. For more
///   information, see
/// [Unsupported Attachment
/// Types](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/mime-types-appendix.html).
///
/// * If any of the MIME parts in a message contain content that is outside of
///   the 7-bit ASCII character range, we recommend
/// encoding that content.
///
/// * Per [RFC 5321](https://tools.ietf.org/html/rfc5321#section-4.5.3.1.6), the
///   maximum length of each line of
/// text, including the , must not exceed 1,000 characters.
///
/// * The message must contain all the required header fields. Check the
///   returned error message for more information.
///
/// * The value of immutable headers must remain unchanged. Check the returned
///   error message for more information.
///
/// * Certain unique headers can only appear once. Check the returned error
///   message for more information.
pub const RawMessageContent = struct {
    /// The S3 reference of an email message.
    s_3_reference: S3Reference,

    pub const json_field_names = .{
        .s_3_reference = "s3Reference",
    };
};

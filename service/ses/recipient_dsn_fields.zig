const DsnAction = @import("dsn_action.zig").DsnAction;
const ExtensionField = @import("extension_field.zig").ExtensionField;

/// Recipient-related information to include in the Delivery Status Notification
/// (DSN)
/// when an email that Amazon SES receives on your behalf bounces.
///
/// For information about receiving email through Amazon SES, see the [Amazon
/// SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email.html).
pub const RecipientDsnFields = struct {
    /// The action performed by the reporting mail transfer agent (MTA) as a result
    /// of its
    /// attempt to deliver the message to the recipient address. This is required by
    /// [RFC 3464](https://tools.ietf.org/html/rfc3464).
    action: DsnAction,

    /// An extended explanation of what went wrong; this is usually an SMTP
    /// response. See
    /// [RFC 3463](https://tools.ietf.org/html/rfc3463) for the correct
    /// formatting of this parameter.
    diagnostic_code: ?[]const u8,

    /// Additional X-headers to include in the DSN.
    extension_fields: ?[]const ExtensionField,

    /// The email address that the message was ultimately delivered to. This
    /// corresponds to
    /// the `Final-Recipient` in the DSN. If not specified,
    /// `FinalRecipient` is set to the `Recipient` specified in the
    /// `BouncedRecipientInfo` structure. Either `FinalRecipient` or
    /// the recipient in `BouncedRecipientInfo` must be a recipient of the original
    /// bounced message.
    ///
    /// Do not prepend the `FinalRecipient` email address with `rfc
    /// 822;`, as described in [RFC 3798](https://tools.ietf.org/html/rfc3798).
    final_recipient: ?[]const u8,

    /// The time the final delivery attempt was made, in [RFC
    /// 822](https://www.ietf.org/rfc/rfc0822.txt) date-time format.
    last_attempt_date: ?i64,

    /// The MTA to which the remote MTA attempted to deliver the message, formatted
    /// as
    /// specified in [RFC 3464](https://tools.ietf.org/html/rfc3464)
    /// (`mta-name-type; mta-name`). This parameter typically applies only to
    /// propagating synchronous bounces.
    remote_mta: ?[]const u8,

    /// The status code that indicates what went wrong. This is required by [RFC
    /// 3464](https://tools.ietf.org/html/rfc3464).
    status: []const u8,
};

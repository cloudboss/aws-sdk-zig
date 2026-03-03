const BounceType = @import("bounce_type.zig").BounceType;
const RecipientDsnFields = @import("recipient_dsn_fields.zig").RecipientDsnFields;

/// Recipient-related information to include in the Delivery Status Notification
/// (DSN)
/// when an email that Amazon SES receives on your behalf bounces.
///
/// For information about receiving email through Amazon SES, see the [Amazon
/// SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email.html).
pub const BouncedRecipientInfo = struct {
    /// The reason for the bounce. You must provide either this parameter or
    /// `RecipientDsnFields`.
    bounce_type: ?BounceType = null,

    /// The email address of the recipient of the bounced email.
    recipient: []const u8,

    /// This parameter is used only for sending authorization. It is the ARN of the
    /// identity
    /// that is associated with the sending authorization policy that permits you to
    /// receive
    /// email for the recipient of the bounced email. For more information about
    /// sending
    /// authorization, see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html).
    recipient_arn: ?[]const u8 = null,

    /// Recipient-related DSN fields, most of which would normally be filled in
    /// automatically
    /// when provided with a `BounceType`. You must provide either this parameter or
    /// `BounceType`.
    recipient_dsn_fields: ?RecipientDsnFields = null,
};

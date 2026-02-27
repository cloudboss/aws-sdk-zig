const ExtensionField = @import("extension_field.zig").ExtensionField;

/// Message-related information to include in the Delivery Status Notification
/// (DSN) when
/// an email that Amazon SES receives on your behalf bounces.
///
/// For information about receiving email through Amazon SES, see the [Amazon
/// SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email.html).
pub const MessageDsn = struct {
    /// When the message was received by the reporting mail transfer agent (MTA), in
    /// [RFC 822](https://www.ietf.org/rfc/rfc0822.txt) date-time format.
    arrival_date: ?i64,

    /// Additional X-headers to include in the DSN.
    extension_fields: ?[]const ExtensionField,

    /// The reporting MTA that attempted to deliver the message, formatted as
    /// specified in
    /// [RFC 3464](https://tools.ietf.org/html/rfc3464)
    /// (`mta-name-type; mta-name`). The default value is `dns;
    /// inbound-smtp.[region].amazonaws.com`.
    reporting_mta: []const u8,
};

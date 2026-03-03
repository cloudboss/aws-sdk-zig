const ReceiptAction = @import("receipt_action.zig").ReceiptAction;
const TlsPolicy = @import("tls_policy.zig").TlsPolicy;

/// Receipt rules enable you to specify which actions Amazon SES should take
/// when it receives
/// mail on behalf of one or more email addresses or domains that you own.
///
/// Each receipt rule defines a set of email addresses or domains that it
/// applies to. If
/// the email addresses or domains match at least one recipient address of the
/// message,
/// Amazon SES executes all of the receipt rule's actions on the message.
///
/// For information about setting up receipt rules, see the [Amazon SES
/// Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
pub const ReceiptRule = struct {
    /// An ordered list of actions to perform on messages that match at least one of
    /// the
    /// recipient email addresses or domains specified in the receipt rule.
    actions: ?[]const ReceiptAction = null,

    /// If `true`, the receipt rule is active. The default value is
    /// `false`.
    enabled: bool = false,

    /// The name of the receipt rule. The name must meet the following requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), underscores (_),
    ///   dashes
    /// (-), or periods (.).
    ///
    /// * Start and end with a letter or number.
    ///
    /// * Contain 64 characters or fewer.
    name: []const u8,

    /// The recipient domains and email addresses that the receipt rule applies to.
    /// If this
    /// field is not specified, this rule matches all recipients on all verified
    /// domains.
    recipients: ?[]const []const u8 = null,

    /// If `true`, then messages that this receipt rule applies to are scanned for
    /// spam and viruses. The default value is `false`.
    scan_enabled: bool = false,

    /// Specifies whether Amazon SES should require that incoming email is delivered
    /// over a
    /// connection encrypted with Transport Layer Security (TLS). If this parameter
    /// is set to
    /// `Require`, Amazon SES bounces emails that are not received over TLS. The
    /// default is `Optional`.
    tls_policy: ?TlsPolicy = null,
};

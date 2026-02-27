const ReceiptIpFilter = @import("receipt_ip_filter.zig").ReceiptIpFilter;

/// A receipt IP address filter enables you to specify whether to accept or
/// reject mail
/// originating from an IP address or range of IP addresses.
///
/// For information about setting up IP address filters, see the [Amazon SES
/// Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-ip-filtering-console-walkthrough.html).
pub const ReceiptFilter = struct {
    /// A structure that provides the IP addresses to block or allow, and whether to
    /// block or
    /// allow incoming mail from them.
    ip_filter: ReceiptIpFilter,

    /// The name of the IP address filter. The name must meet the following
    /// requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), underscores (_), or
    /// dashes (-).
    ///
    /// * Start and end with a letter or number.
    ///
    /// * Contain 64 characters or fewer.
    name: []const u8,
};

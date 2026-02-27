/// Additional X-headers to include in the Delivery Status Notification (DSN)
/// when an
/// email that Amazon SES receives on your behalf bounces.
///
/// For information about receiving email through Amazon SES, see the [Amazon
/// SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email.html).
pub const ExtensionField = struct {
    /// The name of the header to add. Must be between 1 and 50 characters,
    /// inclusive, and
    /// consist of alphanumeric (a-z, A-Z, 0-9) characters and dashes only.
    name: []const u8,

    /// The value of the header to add. Must contain 2048 characters or fewer, and
    /// must not
    /// contain newline characters ("\r" or "\n").
    value: []const u8,
};

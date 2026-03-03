/// Information about a receipt rule set.
///
/// A receipt rule set is a collection of rules that specify what Amazon SES
/// should do with
/// mail it receives on behalf of your account's verified domains.
///
/// For information about setting up receipt rule sets, see the [Amazon SES
/// Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-concepts.html#receiving-email-concepts-rules).
pub const ReceiptRuleSetMetadata = struct {
    /// The date and time the receipt rule set was created.
    created_timestamp: ?i64 = null,

    /// The name of the receipt rule set. The name must meet the following
    /// requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), underscores (_), or
    /// dashes (-).
    ///
    /// * Start and end with a letter or number.
    ///
    /// * Contain 64 characters or fewer.
    name: ?[]const u8 = null,
};

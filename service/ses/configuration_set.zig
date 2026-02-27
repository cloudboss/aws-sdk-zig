/// The name of the configuration set.
///
/// Configuration sets let you create groups of rules that you can apply to the
/// emails you
/// send using Amazon SES. For more information about using configuration sets,
/// see [Using Amazon SES
/// Configuration
/// Sets](https://docs.aws.amazon.com/ses/latest/dg/using-configuration-sets.html) in the [Amazon SES Developer Guide](https://docs.aws.amazon.com/ses/latest/dg/).
pub const ConfigurationSet = struct {
    /// The name of the configuration set. The name must meet the following
    /// requirements:
    ///
    /// * Contain only letters (a-z, A-Z), numbers (0-9), underscores (_), or dashes
    /// (-).
    ///
    /// * Contain 64 characters or fewer.
    name: []const u8,
};

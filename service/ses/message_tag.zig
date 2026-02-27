/// Contains the name and value of a tag that you can provide to `SendEmail` or
/// `SendRawEmail` to apply to an email.
///
/// Message tags, which you use with configuration sets, enable you to publish
/// email
/// sending events. For information about using configuration sets, see the
/// [Amazon SES
/// Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
pub const MessageTag = struct {
    /// The name of the tag. The name must meet the following requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), underscores (_), or
    /// dashes (-).
    ///
    /// * Contain 256 characters or fewer.
    name: []const u8,

    /// The value of the tag. The value must meet the following requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), underscores (_), or
    /// dashes (-).
    ///
    /// * Contain 256 characters or fewer.
    value: []const u8,
};

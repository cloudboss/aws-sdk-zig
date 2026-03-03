const CloudWatchDestination = @import("cloud_watch_destination.zig").CloudWatchDestination;
const KinesisFirehoseDestination = @import("kinesis_firehose_destination.zig").KinesisFirehoseDestination;
const EventType = @import("event_type.zig").EventType;
const SNSDestination = @import("sns_destination.zig").SNSDestination;

/// Contains information about an event destination.
///
/// When you create or update an event destination, you must provide one, and
/// only
/// one, destination. The destination can be Amazon CloudWatch, Amazon Kinesis
/// Firehose or Amazon Simple Notification Service (Amazon SNS).
///
/// Event destinations are associated with configuration sets, which enable you
/// to publish
/// email sending events to Amazon CloudWatch, Amazon Kinesis Firehose, or
/// Amazon Simple Notification Service (Amazon SNS). For information about
/// using configuration sets, see the [Amazon SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
pub const EventDestination = struct {
    /// An object that contains the names, default values, and sources of the
    /// dimensions
    /// associated with an Amazon CloudWatch event destination.
    cloud_watch_destination: ?CloudWatchDestination = null,

    /// Sets whether Amazon SES publishes events to this destination when you send
    /// an email with
    /// the associated configuration set. Set to `true` to enable publishing to this
    /// destination; set to `false` to prevent publishing to this destination. The
    /// default value is `false`.
    enabled: bool = false,

    /// An object that contains the delivery stream ARN and the IAM role ARN
    /// associated with
    /// an Amazon Kinesis Firehose event destination.
    kinesis_firehose_destination: ?KinesisFirehoseDestination = null,

    /// The type of email sending events to publish to the event destination.
    ///
    /// * `send` - The call was successful and Amazon SES is attempting to deliver
    /// the email.
    ///
    /// * `reject` - Amazon SES determined that the email contained a virus and
    /// rejected it.
    ///
    /// * `bounce` - The recipient's mail server permanently rejected the
    /// email. This corresponds to a hard bounce.
    ///
    /// * `complaint` - The recipient marked the email as spam.
    ///
    /// * `delivery` - Amazon SES successfully delivered the email to the
    /// recipient's mail server.
    ///
    /// * `open` - The recipient received the email and opened it in their
    /// email client.
    ///
    /// * `click` - The recipient clicked one or more links in the
    /// email.
    ///
    /// * `renderingFailure` - Amazon SES did not send the email because of a
    /// template rendering issue.
    matching_event_types: []const EventType,

    /// The name of the event destination. The name must meet the following
    /// requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), underscores (_), or
    /// dashes (-).
    ///
    /// * Contain 64 characters or fewer.
    name: []const u8,

    /// An object that contains the topic ARN associated with an Amazon Simple
    /// Notification Service (Amazon SNS) event
    /// destination.
    sns_destination: ?SNSDestination = null,
};

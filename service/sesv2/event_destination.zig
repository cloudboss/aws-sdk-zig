const CloudWatchDestination = @import("cloud_watch_destination.zig").CloudWatchDestination;
const EventBridgeDestination = @import("event_bridge_destination.zig").EventBridgeDestination;
const KinesisFirehoseDestination = @import("kinesis_firehose_destination.zig").KinesisFirehoseDestination;
const EventType = @import("event_type.zig").EventType;
const PinpointDestination = @import("pinpoint_destination.zig").PinpointDestination;
const SnsDestination = @import("sns_destination.zig").SnsDestination;

/// In the Amazon SES API v2, *events* include message sends, deliveries, opens,
/// clicks, bounces, complaints and delivery delays. *Event destinations*
/// are places that you can send information about these events to. For example,
/// you can
/// send event data to Amazon SNS to receive notifications when you receive
/// bounces or
/// complaints, or you can use Amazon Kinesis Data Firehose to stream data to
/// Amazon S3 for long-term storage.
pub const EventDestination = struct {
    /// An object that defines an Amazon CloudWatch destination for email events.
    /// You can use Amazon CloudWatch to
    /// monitor and gain insights on your email sending metrics.
    cloud_watch_destination: ?CloudWatchDestination = null,

    /// If `true`, the event destination is enabled. When the event destination is
    /// enabled, the specified event types are sent to the destinations in this
    /// `EventDestinationDefinition`.
    ///
    /// If `false`, the event destination is disabled. When the event destination
    /// is disabled, events aren't sent to the specified destinations.
    enabled: bool = false,

    /// An object that defines an Amazon EventBridge destination for email events.
    /// You can use Amazon EventBridge to
    /// send notifications when certain email events occur.
    event_bridge_destination: ?EventBridgeDestination = null,

    /// An object that defines an Amazon Kinesis Data Firehose destination for email
    /// events. You can use Amazon Kinesis Data Firehose to
    /// stream data to other services, such as Amazon S3 and Amazon Redshift.
    kinesis_firehose_destination: ?KinesisFirehoseDestination = null,

    /// The types of events that Amazon SES sends to the specified event
    /// destinations.
    ///
    /// * `SEND` - The send request was successful and SES will
    /// attempt to deliver the message to the recipient’s mail server. (If
    /// account-level
    /// or global suppression is being used, SES will still count it as a send,
    /// but delivery is suppressed.)
    ///
    /// * `REJECT` - SES accepted the email, but determined that it
    /// contained a virus and didn’t attempt to deliver it to the recipient’s mail
    /// server.
    ///
    /// * `BOUNCE` - (*Hard bounce*) The recipient's
    /// mail server permanently rejected the email. (*Soft bounces*
    /// are only included when SES fails to deliver the email after retrying for
    /// a period of time.)
    ///
    /// * `COMPLAINT` - The email was successfully delivered to the
    /// recipient’s mail server, but the recipient marked it as spam.
    ///
    /// * `DELIVERY` - SES successfully delivered the email to the
    /// recipient's mail server.
    ///
    /// * `OPEN` - The recipient received the message and opened it in their
    /// email client.
    ///
    /// * `CLICK` - The recipient clicked one or more links in the
    /// email.
    ///
    /// * `RENDERING_FAILURE` - The email wasn't sent because of a
    /// template rendering issue. This event type can occur when template data is
    /// missing, or when there is a mismatch between template parameters and data.
    /// (This
    /// event type only occurs when you send email using the [
    /// `SendEmail`
    /// ](https://docs.aws.amazon.com/ses/latest/APIReference-V2/API_SendEmail.html)
    /// or [
    /// `SendBulkEmail`
    /// ](https://docs.aws.amazon.com/ses/latest/APIReference-V2/API_SendBulkEmail.html) API operations.)
    ///
    /// * `DELIVERY_DELAY` - The email couldn't be delivered to the
    /// recipient’s mail server because a temporary issue occurred. Delivery delays
    /// can
    /// occur, for example, when the recipient's inbox is full, or when the
    /// receiving email server experiences a transient issue.
    ///
    /// * `SUBSCRIPTION` - The email was successfully delivered, but the
    /// recipient updated their subscription preferences by clicking on an
    /// *unsubscribe* link as part of your [subscription
    /// management](https://docs.aws.amazon.com/ses/latest/dg/sending-email-subscription-management.html).
    matching_event_types: []const EventType,

    /// A name that identifies the event destination.
    name: []const u8,

    /// An object that defines an Amazon Pinpoint project destination for email
    /// events. You can send
    /// email event data to a Amazon Pinpoint project to view metrics using the
    /// Transactional Messaging
    /// dashboards that are built in to Amazon Pinpoint. For more information, see
    /// [Transactional
    /// Messaging
    /// Charts](https://docs.aws.amazon.com/pinpoint/latest/userguide/analytics-transactional-messages.html) in the *Amazon Pinpoint User Guide*.
    pinpoint_destination: ?PinpointDestination = null,

    /// An object that defines an Amazon SNS destination for email events. You can
    /// use Amazon SNS to
    /// send notifications when certain email events occur.
    sns_destination: ?SnsDestination = null,

    pub const json_field_names = .{
        .cloud_watch_destination = "CloudWatchDestination",
        .enabled = "Enabled",
        .event_bridge_destination = "EventBridgeDestination",
        .kinesis_firehose_destination = "KinesisFirehoseDestination",
        .matching_event_types = "MatchingEventTypes",
        .name = "Name",
        .pinpoint_destination = "PinpointDestination",
        .sns_destination = "SnsDestination",
    };
};

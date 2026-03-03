/// An object that defines an Amazon Pinpoint project destination for email
/// events. You can send
/// email event data to a Amazon Pinpoint project to view metrics using the
/// Transactional Messaging
/// dashboards that are built in to Amazon Pinpoint. For more information, see
/// [Transactional
/// Messaging
/// Charts](https://docs.aws.amazon.com/pinpoint/latest/userguide/analytics-transactional-messages.html) in the *Amazon Pinpoint User Guide*.
pub const PinpointDestination = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Pinpoint project to send email
    /// events to.
    application_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
    };
};

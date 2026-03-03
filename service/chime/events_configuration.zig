/// The configuration that allows a bot to receive outgoing events. Can be
/// either an HTTPS endpoint or a Lambda function ARN.
pub const EventsConfiguration = struct {
    /// The bot ID.
    bot_id: ?[]const u8 = null,

    /// Lambda function ARN that allows a bot to receive outgoing events.
    lambda_function_arn: ?[]const u8 = null,

    /// HTTPS endpoint that allows a bot to receive outgoing events.
    outbound_events_https_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "BotId",
        .lambda_function_arn = "LambdaFunctionArn",
        .outbound_events_https_endpoint = "OutboundEventsHTTPSEndpoint",
    };
};

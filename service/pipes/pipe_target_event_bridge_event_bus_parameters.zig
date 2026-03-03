/// The parameters for using an EventBridge event bus as a target.
pub const PipeTargetEventBridgeEventBusParameters = struct {
    /// A free-form string, with a maximum of 128 characters, used to decide what
    /// fields to
    /// expect in the event detail.
    detail_type: ?[]const u8 = null,

    /// The URL subdomain of the endpoint. For example, if the URL for Endpoint is
    /// https://abcde.veo.endpoints.event.amazonaws.com, then the EndpointId is
    /// `abcde.veo`.
    endpoint_id: ?[]const u8 = null,

    /// Amazon Web Services resources, identified by Amazon Resource Name (ARN),
    /// which the event
    /// primarily concerns. Any number, including zero, may be present.
    resources: ?[]const []const u8 = null,

    /// The source of the event.
    source: ?[]const u8 = null,

    /// The time stamp of the event, per
    /// [RFC3339](https://www.rfc-editor.org/rfc/rfc3339.txt). If no time stamp is
    /// provided, the time stamp of the
    /// [PutEvents](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_PutEvents.html) call is used.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .detail_type = "DetailType",
        .endpoint_id = "EndpointId",
        .resources = "Resources",
        .source = "Source",
        .time = "Time",
    };
};

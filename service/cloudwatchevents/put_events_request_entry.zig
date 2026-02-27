/// Represents an event to be submitted.
pub const PutEventsRequestEntry = struct {
    /// A valid JSON string. There is no other schema imposed. The JSON string may
    /// contain fields
    /// and nested subobjects.
    detail: ?[]const u8,

    /// Free-form string used to decide what fields to expect in the event detail.
    detail_type: ?[]const u8,

    /// The name or ARN of the event bus to receive the event. Only the rules that
    /// are associated
    /// with this event bus are used to match the event. If you omit this, the
    /// default event bus is
    /// used.
    event_bus_name: ?[]const u8,

    /// Amazon Web Services resources, identified by Amazon Resource Name (ARN),
    /// which the event primarily
    /// concerns. Any number, including zero, may be present.
    resources: ?[]const []const u8,

    /// The source of the event.
    source: ?[]const u8,

    /// The time stamp of the event, per
    /// [RFC3339](https://www.rfc-editor.org/rfc/rfc3339.txt). If no time stamp is
    /// provided, the time stamp of the
    /// [PutEvents](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_PutEvents.html) call is used.
    time: ?i64,

    /// An X-Ray trade header, which is an http header (X-Amzn-Trace-Id) that
    /// contains the
    /// trace-id associated with the event.
    ///
    /// To learn more about X-Ray trace headers, see [Tracing
    /// header](https://docs.aws.amazon.com/xray/latest/devguide/xray-concepts.html#xray-concepts-tracingheader) in the X-Ray Developer Guide.
    trace_header: ?[]const u8,

    pub const json_field_names = .{
        .detail = "Detail",
        .detail_type = "DetailType",
        .event_bus_name = "EventBusName",
        .resources = "Resources",
        .source = "Source",
        .time = "Time",
        .trace_header = "TraceHeader",
    };
};

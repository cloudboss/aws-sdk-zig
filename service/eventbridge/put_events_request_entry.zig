/// Represents an event to be submitted.
pub const PutEventsRequestEntry = struct {
    /// A valid JSON object. There is no other schema imposed. The JSON object may
    /// contain fields
    /// and nested sub-objects.
    ///
    /// `Detail`, `DetailType`, and `Source` are required for EventBridge to
    /// successfully send an event to an event bus.
    /// If you include event entries in a request that do not include each of those
    /// properties, EventBridge fails that entry.
    /// If you submit a request in which *none* of the entries have each of these
    /// properties, EventBridge fails the entire request.
    detail: ?[]const u8,

    /// Free-form string, with a maximum of 128 characters, used to decide what
    /// fields to expect
    /// in the event detail.
    ///
    /// `Detail`, `DetailType`, and `Source` are required for EventBridge to
    /// successfully send an event to an event bus.
    /// If you include event entries in a request that do not include each of those
    /// properties, EventBridge fails that entry.
    /// If you submit a request in which *none* of the entries have each of these
    /// properties, EventBridge fails the entire request.
    detail_type: ?[]const u8,

    /// The name or ARN of the event bus to receive the event. Only the rules that
    /// are associated
    /// with this event bus are used to match the event. If you omit this, the
    /// default event bus is
    /// used.
    ///
    /// If you're using a global endpoint with a custom bus, you can enter either
    /// the name or
    /// Amazon Resource Name (ARN) of the event bus in either the primary or
    /// secondary Region here. EventBridge then
    /// determines the corresponding event bus in the other Region based on the
    /// endpoint referenced
    /// by the `EndpointId`. Specifying the event bus ARN is preferred.
    event_bus_name: ?[]const u8,

    /// Amazon Web Services resources, identified by Amazon Resource Name (ARN),
    /// which the event primarily concerns.
    /// Any number, including zero, may be present.
    resources: ?[]const []const u8,

    /// The source of the event.
    ///
    /// `Detail`, `DetailType`, and `Source` are required for EventBridge to
    /// successfully send an event to an event bus.
    /// If you include event entries in a request that do not include each of those
    /// properties, EventBridge fails that entry.
    /// If you submit a request in which *none* of the entries have each of these
    /// properties, EventBridge fails the entire request.
    source: ?[]const u8,

    /// The time stamp of the event, per
    /// [RFC3339](https://www.rfc-editor.org/rfc/rfc3339.txt). If no time stamp is
    /// provided, the time stamp of the
    /// [PutEvents](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_PutEvents.html) call is used.
    time: ?i64,

    /// An X-Ray trace header, which is an http header (X-Amzn-Trace-Id) that
    /// contains the trace-id associated with the event.
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

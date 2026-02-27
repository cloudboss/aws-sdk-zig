/// The templated target type for the EventBridge [
/// `PutEvents`
/// ](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_PutEvents.html) API operation.
pub const EventBridgeParameters = struct {
    /// A free-form string, with a maximum of 128 characters, used to decide what
    /// fields to expect in the event detail.
    detail_type: []const u8,

    /// The source of the event.
    source: []const u8,

    pub const json_field_names = .{
        .detail_type = "DetailType",
        .source = "Source",
    };
};

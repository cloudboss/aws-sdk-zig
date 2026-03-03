const aws = @import("aws");

const EventFilter = @import("event_filter.zig").EventFilter;

/// The event integration.
pub const EventIntegration = struct {
    /// The event integration description.
    description: ?[]const u8 = null,

    /// The Amazon EventBridge bus for the event integration.
    event_bridge_bus: ?[]const u8 = null,

    /// The event integration filter.
    event_filter: ?EventFilter = null,

    /// The Amazon Resource Name (ARN) of the event integration.
    event_integration_arn: ?[]const u8 = null,

    /// The name of the event integration.
    name: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .event_bridge_bus = "EventBridgeBus",
        .event_filter = "EventFilter",
        .event_integration_arn = "EventIntegrationArn",
        .name = "Name",
        .tags = "Tags",
    };
};

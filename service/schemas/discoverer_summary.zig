const aws = @import("aws");

const DiscovererState = @import("discoverer_state.zig").DiscovererState;

pub const DiscovererSummary = struct {
    /// The Status if the discoverer will discover schemas from events sent from
    /// another account.
    cross_account: ?bool = null,

    /// The ARN of the discoverer.
    discoverer_arn: ?[]const u8 = null,

    /// The ID of the discoverer.
    discoverer_id: ?[]const u8 = null,

    /// The ARN of the event bus.
    source_arn: ?[]const u8 = null,

    /// The state of the discoverer.
    state: ?DiscovererState = null,

    /// Tags associated with the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cross_account = "CrossAccount",
        .discoverer_arn = "DiscovererArn",
        .discoverer_id = "DiscovererId",
        .source_arn = "SourceArn",
        .state = "State",
        .tags = "Tags",
    };
};

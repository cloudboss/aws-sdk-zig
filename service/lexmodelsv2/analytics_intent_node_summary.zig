const AnalyticsNodeType = @import("analytics_node_type.zig").AnalyticsNodeType;

/// An object containing information about the requested path.
pub const AnalyticsIntentNodeSummary = struct {
    /// The total number of sessions that follow the given path to the given intent.
    intent_count: ?i32 = null,

    /// The number of intents up to and including the requested path.
    intent_level: ?i32 = null,

    /// The name of the intent at the end of the requested path.
    intent_name: ?[]const u8 = null,

    /// The path.
    intent_path: ?[]const u8 = null,

    /// Specifies whether the node is the end of a path (`Exit`) or not (`Inner`).
    node_type: ?AnalyticsNodeType = null,

    pub const json_field_names = .{
        .intent_count = "intentCount",
        .intent_level = "intentLevel",
        .intent_name = "intentName",
        .intent_path = "intentPath",
        .node_type = "nodeType",
    };
};

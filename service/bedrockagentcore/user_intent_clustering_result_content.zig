const UserIntentCluster = @import("user_intent_cluster.zig").UserIntentCluster;

/// The user intent clustering result containing grouped user intents identified
/// across evaluated sessions.
pub const UserIntentClusteringResultContent = struct {
    /// The list of user intent clusters identified across analyzed sessions.
    user_intents: []const UserIntentCluster,

    pub const json_field_names = .{
        .user_intents = "userIntents",
    };
};

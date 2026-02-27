const BotVersionReplicaSortAttribute = @import("bot_version_replica_sort_attribute.zig").BotVersionReplicaSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The sort category for the version replicated bots.
pub const BotVersionReplicaSortBy = struct {
    /// The attribute of the sort category for the version replicated bots.
    attribute: BotVersionReplicaSortAttribute,

    /// The order of the sort category for the version replicated bots.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};

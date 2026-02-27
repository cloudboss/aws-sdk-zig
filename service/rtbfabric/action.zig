const HeaderTagAction = @import("header_tag_action.zig").HeaderTagAction;
const NoBidAction = @import("no_bid_action.zig").NoBidAction;

/// Describes a bid action.
pub const Action = union(enum) {
    /// Describes the header tag for a bid action.
    header_tag: ?HeaderTagAction,
    /// Describes a no bid action.
    no_bid: ?NoBidAction,

    pub const json_field_names = .{
        .header_tag = "headerTag",
        .no_bid = "noBid",
    };
};

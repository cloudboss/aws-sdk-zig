const SubscriptionStatus = @import("subscription_status.zig").SubscriptionStatus;
const TopicFilter = @import("topic_filter.zig").TopicFilter;

/// A filter that can be applied to a list of contacts.
pub const ListContactsFilter = struct {
    /// The status by which you are filtering: `OPT_IN` or
    /// `OPT_OUT`.
    filtered_status: ?SubscriptionStatus,

    /// Used for filtering by a specific topic preference.
    topic_filter: ?TopicFilter,

    pub const json_field_names = .{
        .filtered_status = "FilteredStatus",
        .topic_filter = "TopicFilter",
    };
};

const InboxPlacementTrackingOption = @import("inbox_placement_tracking_option.zig").InboxPlacementTrackingOption;

/// An object that contains information about the Deliverability dashboard
/// subscription for a
/// verified domain that you use to send email and currently has an active
/// Deliverability dashboard
/// subscription. If a Deliverability dashboard subscription is active for a
/// domain, you gain access
/// to reputation, inbox placement, and other metrics for the domain.
pub const DomainDeliverabilityTrackingOption = struct {
    /// A verified domain that’s associated with your Amazon Web Services account
    /// and currently has an
    /// active Deliverability dashboard subscription.
    domain: ?[]const u8,

    /// An object that contains information about the inbox placement data settings
    /// for the
    /// domain.
    inbox_placement_tracking_option: ?InboxPlacementTrackingOption,

    /// The date when you enabled the Deliverability dashboard for the
    /// domain.
    subscription_start_date: ?i64,

    pub const json_field_names = .{
        .domain = "Domain",
        .inbox_placement_tracking_option = "InboxPlacementTrackingOption",
        .subscription_start_date = "SubscriptionStartDate",
    };
};

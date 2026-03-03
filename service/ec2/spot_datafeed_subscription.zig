const SpotInstanceStateFault = @import("spot_instance_state_fault.zig").SpotInstanceStateFault;
const DatafeedSubscriptionState = @import("datafeed_subscription_state.zig").DatafeedSubscriptionState;

/// Describes the data feed for a Spot Instance.
pub const SpotDatafeedSubscription = struct {
    /// The name of the Amazon S3 bucket where the Spot Instance data feed is
    /// located.
    bucket: ?[]const u8 = null,

    /// The fault codes for the Spot Instance request, if any.
    fault: ?SpotInstanceStateFault = null,

    /// The Amazon Web Services account ID of the account.
    owner_id: ?[]const u8 = null,

    /// The prefix for the data feed files.
    prefix: ?[]const u8 = null,

    /// The state of the Spot Instance data feed subscription.
    state: ?DatafeedSubscriptionState = null,
};

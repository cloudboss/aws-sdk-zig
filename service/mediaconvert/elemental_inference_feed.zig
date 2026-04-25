const ElementalInferenceFeedManagementState = @import("elemental_inference_feed_management_state.zig").ElementalInferenceFeedManagementState;

/// Elemental Inference Feed.
pub const ElementalInferenceFeed = struct {
    /// Feed ARN.
    arn: ?[]const u8 = null,

    /// Elemental Inference Feed management state.
    feed_management_state: ?ElementalInferenceFeedManagementState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .feed_management_state = "FeedManagementState",
    };
};

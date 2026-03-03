const FulfillmentUpdatesSpecification = @import("fulfillment_updates_specification.zig").FulfillmentUpdatesSpecification;
const PostFulfillmentStatusSpecification = @import("post_fulfillment_status_specification.zig").PostFulfillmentStatusSpecification;

/// Determines if a Lambda function should be invoked for a specific
/// intent.
pub const FulfillmentCodeHookSettings = struct {
    /// Determines whether the fulfillment code hook is used. When
    /// `active` is false, the code hook doesn't run.
    active: ?bool = null,

    /// Indicates whether a Lambda function should be invoked to fulfill a
    /// specific intent.
    enabled: bool = false,

    /// Provides settings for update messages sent to the user for
    /// long-running Lambda fulfillment functions. Fulfillment updates can be
    /// used only with streaming conversations.
    fulfillment_updates_specification: ?FulfillmentUpdatesSpecification = null,

    /// Provides settings for messages sent to the user for after the Lambda
    /// fulfillment function completes. Post-fulfillment messages can be sent
    /// for both streaming and non-streaming conversations.
    post_fulfillment_status_specification: ?PostFulfillmentStatusSpecification = null,

    pub const json_field_names = .{
        .active = "active",
        .enabled = "enabled",
        .fulfillment_updates_specification = "fulfillmentUpdatesSpecification",
        .post_fulfillment_status_specification = "postFulfillmentStatusSpecification",
    };
};

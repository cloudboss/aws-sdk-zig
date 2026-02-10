const TransitGatewayMeteringPolicyState = @import("transit_gateway_metering_policy_state.zig").TransitGatewayMeteringPolicyState;
const Tag = @import("tag.zig").Tag;

/// Describes a transit gateway metering policy.
pub const TransitGatewayMeteringPolicy = struct {
    /// The IDs of the middlebox attachments associated with the metering policy.
    middlebox_attachment_ids: ?[]const []const u8,

    /// The state of the transit gateway metering policy.
    state: ?TransitGatewayMeteringPolicyState,

    /// The tags assigned to the transit gateway metering policy.
    tags: ?[]const Tag,

    /// The ID of the transit gateway associated with the metering policy.
    transit_gateway_id: ?[]const u8,

    /// The ID of the transit gateway metering policy.
    transit_gateway_metering_policy_id: ?[]const u8,

    /// The date and time when the metering policy update becomes effective.
    update_effective_at: ?i64,
};

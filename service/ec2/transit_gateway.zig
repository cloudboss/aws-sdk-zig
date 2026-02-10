const TransitGatewayOptions = @import("transit_gateway_options.zig").TransitGatewayOptions;
const TransitGatewayState = @import("transit_gateway_state.zig").TransitGatewayState;
const Tag = @import("tag.zig").Tag;

/// Describes a transit gateway.
pub const TransitGateway = struct {
    /// The creation time.
    creation_time: ?i64,

    /// The description of the transit gateway.
    description: ?[]const u8,

    /// The transit gateway options.
    options: ?TransitGatewayOptions,

    /// The ID of the Amazon Web Services account that owns the transit gateway.
    owner_id: ?[]const u8,

    /// The state of the transit gateway.
    state: ?TransitGatewayState,

    /// The tags for the transit gateway.
    tags: ?[]const Tag,

    /// The Amazon Resource Name (ARN) of the transit gateway.
    transit_gateway_arn: ?[]const u8,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8,
};

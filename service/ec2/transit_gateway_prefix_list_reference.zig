const TransitGatewayPrefixListReferenceState = @import("transit_gateway_prefix_list_reference_state.zig").TransitGatewayPrefixListReferenceState;
const TransitGatewayPrefixListAttachment = @import("transit_gateway_prefix_list_attachment.zig").TransitGatewayPrefixListAttachment;

/// Describes a prefix list reference.
pub const TransitGatewayPrefixListReference = struct {
    /// Indicates whether traffic that matches this route is dropped.
    blackhole: ?bool,

    /// The ID of the prefix list.
    prefix_list_id: ?[]const u8,

    /// The ID of the prefix list owner.
    prefix_list_owner_id: ?[]const u8,

    /// The state of the prefix list reference.
    state: ?TransitGatewayPrefixListReferenceState,

    /// Information about the transit gateway attachment.
    transit_gateway_attachment: ?TransitGatewayPrefixListAttachment,

    /// The ID of the transit gateway route table.
    transit_gateway_route_table_id: ?[]const u8,
};

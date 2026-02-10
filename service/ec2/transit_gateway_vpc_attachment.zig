const TransitGatewayVpcAttachmentOptions = @import("transit_gateway_vpc_attachment_options.zig").TransitGatewayVpcAttachmentOptions;
const TransitGatewayAttachmentState = @import("transit_gateway_attachment_state.zig").TransitGatewayAttachmentState;
const Tag = @import("tag.zig").Tag;

/// Describes a VPC attachment.
pub const TransitGatewayVpcAttachment = struct {
    /// The creation time.
    creation_time: ?i64,

    /// The VPC attachment options.
    options: ?TransitGatewayVpcAttachmentOptions,

    /// The state of the VPC attachment. Note that the `initiating` state has been
    /// deprecated.
    state: ?TransitGatewayAttachmentState,

    /// The IDs of the subnets.
    subnet_ids: ?[]const []const u8,

    /// The tags for the VPC attachment.
    tags: ?[]const Tag,

    /// The ID of the attachment.
    transit_gateway_attachment_id: ?[]const u8,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the VPC.
    vpc_owner_id: ?[]const u8,
};

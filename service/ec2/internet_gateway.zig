const InternetGatewayAttachment = @import("internet_gateway_attachment.zig").InternetGatewayAttachment;
const Tag = @import("tag.zig").Tag;

/// Describes an internet gateway.
pub const InternetGateway = struct {
    /// Any VPCs attached to the internet gateway.
    attachments: ?[]const InternetGatewayAttachment,

    /// The ID of the internet gateway.
    internet_gateway_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the internet gateway.
    owner_id: ?[]const u8,

    /// Any tags assigned to the internet gateway.
    tags: ?[]const Tag,
};

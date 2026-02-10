const InternetGatewayAttachment = @import("internet_gateway_attachment.zig").InternetGatewayAttachment;
const Tag = @import("tag.zig").Tag;

/// Describes an egress-only internet gateway.
pub const EgressOnlyInternetGateway = struct {
    /// Information about the attachment of the egress-only internet gateway.
    attachments: ?[]const InternetGatewayAttachment,

    /// The ID of the egress-only internet gateway.
    egress_only_internet_gateway_id: ?[]const u8,

    /// The tags assigned to the egress-only internet gateway.
    tags: ?[]const Tag,
};

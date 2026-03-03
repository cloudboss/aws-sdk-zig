const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// Describes the attachment of a VPC to an internet gateway or an egress-only
/// internet gateway.
pub const InternetGatewayAttachment = struct {
    /// The current state of the attachment. For an internet gateway, the state is
    /// `available` when attached to a VPC; otherwise, this value is not
    /// returned.
    state: ?AttachmentStatus = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,
};

const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// Describes an attachment between a virtual private gateway and a VPC.
pub const VpcAttachment = struct {
    /// The current state of the attachment.
    state: ?AttachmentStatus,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,
};

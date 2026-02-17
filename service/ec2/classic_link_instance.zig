const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const Tag = @import("tag.zig").Tag;

/// Deprecated.
///
/// Describes a linked EC2-Classic instance.
pub const ClassicLinkInstance = struct {
    /// The security groups.
    groups: ?[]const GroupIdentifier,

    /// The ID of the instance.
    instance_id: ?[]const u8,

    /// Any tags assigned to the instance.
    tags: ?[]const Tag,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,
};

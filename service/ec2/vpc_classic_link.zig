const Tag = @import("tag.zig").Tag;

/// Deprecated.
///
/// Describes whether a VPC is enabled for ClassicLink.
pub const VpcClassicLink = struct {
    /// Indicates whether the VPC is enabled for ClassicLink.
    classic_link_enabled: ?bool = null,

    /// Any tags assigned to the VPC.
    tags: ?[]const Tag = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,
};

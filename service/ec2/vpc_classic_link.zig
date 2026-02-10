const Tag = @import("tag.zig").Tag;

/// **Note:**
///
/// Deprecated.
///
/// Describes whether a VPC is enabled for ClassicLink.
pub const VpcClassicLink = struct {
    /// Indicates whether the VPC is enabled for ClassicLink.
    classic_link_enabled: ?bool,

    /// Any tags assigned to the VPC.
    tags: ?[]const Tag,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,
};

const Bandwidth = @import("bandwidth.zig").Bandwidth;
const LinkState = @import("link_state.zig").LinkState;
const Tag = @import("tag.zig").Tag;

/// Describes a link.
pub const Link = struct {
    /// The bandwidth for the link.
    bandwidth: ?Bandwidth,

    /// The date and time that the link was created.
    created_at: ?i64,

    /// The description of the link.
    description: ?[]const u8,

    /// The ID of the global network.
    global_network_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the link.
    link_arn: ?[]const u8,

    /// The ID of the link.
    link_id: ?[]const u8,

    /// The provider of the link.
    provider: ?[]const u8,

    /// The ID of the site.
    site_id: ?[]const u8,

    /// The state of the link.
    state: ?LinkState,

    /// The tags for the link.
    tags: ?[]const Tag,

    /// The type of the link.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .bandwidth = "Bandwidth",
        .created_at = "CreatedAt",
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .link_arn = "LinkArn",
        .link_id = "LinkId",
        .provider = "Provider",
        .site_id = "SiteId",
        .state = "State",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

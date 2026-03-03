const Location = @import("location.zig").Location;
const SiteState = @import("site_state.zig").SiteState;
const Tag = @import("tag.zig").Tag;

/// Describes a site.
pub const Site = struct {
    /// The date and time that the site was created.
    created_at: ?i64 = null,

    /// The description of the site.
    description: ?[]const u8 = null,

    /// The ID of the global network.
    global_network_id: ?[]const u8 = null,

    /// The location of the site.
    location: ?Location = null,

    /// The Amazon Resource Name (ARN) of the site.
    site_arn: ?[]const u8 = null,

    /// The ID of the site.
    site_id: ?[]const u8 = null,

    /// The state of the site.
    state: ?SiteState = null,

    /// The tags for the site.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .location = "Location",
        .site_arn = "SiteArn",
        .site_id = "SiteId",
        .state = "State",
        .tags = "Tags",
    };
};

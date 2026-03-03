const Bandwidth = @import("bandwidth.zig").Bandwidth;
const Tag = @import("tag.zig").Tag;

pub const CreateLinkRequest = struct {
    /// The upload speed and download speed in Mbps.
    bandwidth: Bandwidth,

    /// A description of the link.
    ///
    /// Constraints: Maximum length of 256 characters.
    description: ?[]const u8 = null,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The provider of the link.
    ///
    /// Constraints: Maximum length of 128 characters. Cannot include the following
    /// characters: | \ ^
    provider: ?[]const u8 = null,

    /// The ID of the site.
    site_id: []const u8,

    /// The tags to apply to the resource during creation.
    tags: ?[]const Tag = null,

    /// The type of the link.
    ///
    /// Constraints: Maximum length of 128 characters. Cannot include the following
    /// characters: | \ ^
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .bandwidth = "Bandwidth",
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .provider = "Provider",
        .site_id = "SiteId",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

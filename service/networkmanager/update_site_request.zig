const Location = @import("location.zig").Location;

pub const UpdateSiteRequest = struct {
    /// A description of your site.
    ///
    /// Constraints: Maximum length of 256 characters.
    description: ?[]const u8,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The site location:
    ///
    /// * `Address`: The physical address of the site.
    ///
    /// * `Latitude`: The latitude of the site.
    ///
    /// * `Longitude`: The longitude of the site.
    location: ?Location,

    /// The ID of your site.
    site_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .location = "Location",
        .site_id = "SiteId",
    };
};

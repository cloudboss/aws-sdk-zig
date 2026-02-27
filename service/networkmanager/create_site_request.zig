const Location = @import("location.zig").Location;
const Tag = @import("tag.zig").Tag;

pub const CreateSiteRequest = struct {
    /// A description of your site.
    ///
    /// Constraints: Maximum length of 256 characters.
    description: ?[]const u8,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The site location. This information is used for visualization in the Network
    /// Manager console. If you specify the address, the latitude and longitude are
    /// automatically calculated.
    ///
    /// * `Address`: The physical address of the site.
    ///
    /// * `Latitude`: The latitude of the site.
    ///
    /// * `Longitude`: The longitude of the site.
    location: ?Location,

    /// The tags to apply to the resource during creation.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .location = "Location",
        .tags = "Tags",
    };
};

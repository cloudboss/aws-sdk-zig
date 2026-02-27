pub const DeleteSiteRequest = struct {
    /// The ID of the global network.
    global_network_id: []const u8,

    /// The ID of the site.
    site_id: []const u8,

    pub const json_field_names = .{
        .global_network_id = "GlobalNetworkId",
        .site_id = "SiteId",
    };
};

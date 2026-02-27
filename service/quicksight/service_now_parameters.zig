/// The parameters for ServiceNow.
pub const ServiceNowParameters = struct {
    /// URL of the base site.
    site_base_url: []const u8,

    pub const json_field_names = .{
        .site_base_url = "SiteBaseUrl",
    };
};

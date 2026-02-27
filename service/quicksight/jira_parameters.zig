/// The parameters for Jira.
pub const JiraParameters = struct {
    /// The base URL of the Jira site.
    site_base_url: []const u8,

    pub const json_field_names = .{
        .site_base_url = "SiteBaseUrl",
    };
};

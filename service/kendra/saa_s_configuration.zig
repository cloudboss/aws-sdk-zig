/// Provides the configuration information to connect to GitHub Enterprise Cloud
/// (SaaS).
pub const SaaSConfiguration = struct {
    /// The GitHub host URL or API endpoint URL. For example,
    /// *https://api.github.com*.
    host_url: []const u8,

    /// The name of the organization of the GitHub Enterprise Cloud (SaaS) account
    /// you want to
    /// connect to. You can find your organization name by logging into GitHub
    /// desktop and
    /// selecting **Your organizations** under your profile picture
    /// dropdown.
    organization_name: []const u8,

    pub const json_field_names = .{
        .host_url = "HostUrl",
        .organization_name = "OrganizationName",
    };
};

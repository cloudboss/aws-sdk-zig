/// Information about the build badge for the build project.
pub const ProjectBadge = struct {
    /// Set this to true to generate a publicly accessible URL for your project's
    /// build
    /// badge.
    badge_enabled: bool = false,

    /// The publicly-accessible URL through which you can access the build badge for
    /// your
    /// project.
    badge_request_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .badge_enabled = "badgeEnabled",
        .badge_request_url = "badgeRequestUrl",
    };
};

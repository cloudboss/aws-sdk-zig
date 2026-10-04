const ApplicationSummary = @import("application_summary.zig").ApplicationSummary;

pub const ListApplicationsResponse = struct {
    /// List of applications
    applications: []const ApplicationSummary,

    /// Next Page Token
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .applications = "applications",
        .next_token = "nextToken",
    };
};

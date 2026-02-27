const ApplicationSummary = @import("application_summary.zig").ApplicationSummary;

pub const ListApplicationsResponse = struct {
    /// This list of applications.
    applications: ?[]const ApplicationSummary,

    /// The token to use to get the next page of results after a previous API call.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .applications = "applications",
        .next_token = "nextToken",
    };
};

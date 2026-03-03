const ApplicationSummary = @import("application_summary.zig").ApplicationSummary;

pub const ListApplicationsResponse = struct {
    /// An array of application summaries.
    applications: ?[]const ApplicationSummary = null,

    /// The token to request the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .applications = "Applications",
        .next_token = "NextToken",
    };
};

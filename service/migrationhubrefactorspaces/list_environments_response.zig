const EnvironmentSummary = @import("environment_summary.zig").EnvironmentSummary;

pub const ListEnvironmentsResponse = struct {
    /// The list of `EnvironmentSummary` objects.
    environment_summary_list: ?[]const EnvironmentSummary,

    /// The token for the next page of results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .environment_summary_list = "EnvironmentSummaryList",
        .next_token = "NextToken",
    };
};

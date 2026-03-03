const FleetSummary = @import("fleet_summary.zig").FleetSummary;

pub const ListFleetsResponse = struct {
    /// A list of information for each fleet.
    fleet_summaries: ?[]const FleetSummary = null,

    /// The token to retrieve the next set of results, or `null` if there are no
    /// more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .fleet_summaries = "fleetSummaries",
        .next_token = "nextToken",
    };
};

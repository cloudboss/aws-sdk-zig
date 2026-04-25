const FilterSource = @import("filter_source.zig").FilterSource;
const BotStatistics = @import("bot_statistics.zig").BotStatistics;

/// Statistics about bot traffic to a specific URI path, including the path,
/// request count, percentage of total traffic, and the top bots accessing that
/// path.
pub const PathStatistics = struct {
    /// The URI path. For example, `/api/` or `/api/v1/users`.
    path: []const u8,

    /// The percentage of total requests that were made to this path.
    percentage: f64 = 0,

    /// The number of requests to this path within the specified time window.
    request_count: i64 = 0,

    /// Information about the bot filter that was applied to generate these
    /// statistics. This field is only populated when you filter by bot category,
    /// organization, or name.
    source: ?FilterSource = null,

    /// The list of top bots accessing this path, ordered by request count. The
    /// number of bots included is determined by the
    /// `NumberOfTopTrafficBotsPerPath` parameter in the request.
    top_bots: ?[]const BotStatistics = null,

    pub const json_field_names = .{
        .path = "Path",
        .percentage = "Percentage",
        .request_count = "RequestCount",
        .source = "Source",
        .top_bots = "TopBots",
    };
};

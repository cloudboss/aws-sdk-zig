/// The payload for DeleteStatistics.
pub const DeleteStatisticsValueMap = struct {
    /// The current status of the statistics.
    active: ?bool = null,

    /// The ID of the statistics generation run that is currently occurring.
    statistics_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active = "active",
        .statistics_id = "statisticsId",
    };
};

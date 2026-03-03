/// Statistics for `REFRESH` mode.
pub const RefreshStatisticsIdMap = struct {
    /// The ID of the statistics generation run that is currently occurring.
    statistics_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .statistics_id = "statisticsId",
    };
};

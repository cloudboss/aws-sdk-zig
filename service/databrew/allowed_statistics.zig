/// Configuration of statistics that are allowed to be run on columns that
/// contain detected entities. When undefined, no statistics will be computed
/// on columns that contain detected entities.
pub const AllowedStatistics = struct {
    /// One or more column statistics to allow for columns that contain detected
    /// entities.
    statistics: []const []const u8,

    pub const json_field_names = .{
        .statistics = "Statistics",
    };
};

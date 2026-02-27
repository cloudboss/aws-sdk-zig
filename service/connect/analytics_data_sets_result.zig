/// Information about datasets that are available to associate with:
/// `DataSetId`,
/// `DataSetName`.
pub const AnalyticsDataSetsResult = struct {
    /// The identifier of the dataset.
    data_set_id: ?[]const u8,

    /// The name of the dataset.
    data_set_name: ?[]const u8,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
        .data_set_name = "DataSetName",
    };
};

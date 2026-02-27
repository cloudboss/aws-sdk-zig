/// The parameters for IoT Analytics.
pub const AwsIotAnalyticsParameters = struct {
    /// Dataset name.
    data_set_name: []const u8,

    pub const json_field_names = .{
        .data_set_name = "DataSetName",
    };
};

/// Information on the usage of a data source package in the behavior graph.
pub const DatasourcePackageUsageInfo = struct {
    /// Total volume of data in bytes per day ingested for a given data source
    /// package.
    volume_usage_in_bytes: ?i64,

    /// The data and time when the member account data volume was last updated. The
    /// value is an
    /// ISO8601 formatted string. For example, `2021-08-18T16:35:56.284Z`.
    volume_usage_update_time: ?i64,

    pub const json_field_names = .{
        .volume_usage_in_bytes = "VolumeUsageInBytes",
        .volume_usage_update_time = "VolumeUsageUpdateTime",
    };
};

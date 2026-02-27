/// A set of filters by which to return Recovery Snapshots.
pub const DescribeRecoverySnapshotsRequestFilters = struct {
    /// The start date in a date range query.
    from_date_time: ?[]const u8,

    /// The end date in a date range query.
    to_date_time: ?[]const u8,

    pub const json_field_names = .{
        .from_date_time = "fromDateTime",
        .to_date_time = "toDateTime",
    };
};

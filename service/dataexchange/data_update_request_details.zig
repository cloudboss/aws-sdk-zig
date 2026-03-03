/// Extra details specific to a data update type notification.
pub const DataUpdateRequestDetails = struct {
    /// A
    /// datetime in the past when the data was updated. This typically means that
    /// the underlying
    /// resource supporting the data set was updated.
    data_updated_at: ?i64 = null,

    pub const json_field_names = .{
        .data_updated_at = "DataUpdatedAt",
    };
};

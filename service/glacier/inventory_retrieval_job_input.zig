/// Provides options for specifying a range inventory retrieval job.
pub const InventoryRetrievalJobInput = struct {
    /// The end of the date range in UTC for vault inventory retrieval that includes
    /// archives
    /// created before this date. This value should be a string in the ISO 8601 date
    /// format, for
    /// example `2013-03-20T17:03:43Z`.
    end_date: ?[]const u8,

    /// Specifies the maximum number of inventory items returned per vault inventory
    /// retrieval request. Valid values are greater than or equal to 1.
    limit: ?[]const u8,

    /// An opaque string that represents where to continue pagination of the vault
    /// inventory
    /// retrieval results. You use the marker in a new **InitiateJob**
    /// request to obtain additional inventory items. If there are no more inventory
    /// items, this
    /// value is `null`.
    marker: ?[]const u8,

    /// The start of the date range in UTC for vault inventory retrieval that
    /// includes
    /// archives created on or after this date. This value should be a string in the
    /// ISO 8601 date
    /// format, for example `2013-03-20T17:03:43Z`.
    start_date: ?[]const u8,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .limit = "Limit",
        .marker = "Marker",
        .start_date = "StartDate",
    };
};

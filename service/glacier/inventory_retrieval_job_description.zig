/// Describes the options for a range inventory retrieval job.
pub const InventoryRetrievalJobDescription = struct {
    /// The end of the date range in UTC for vault inventory retrieval that includes
    /// archives created before this date. This value should be a string in the ISO
    /// 8601 date
    /// format, for example `2013-03-20T17:03:43Z`.
    end_date: ?[]const u8 = null,

    /// The output format for the vault inventory list, which is set by the
    /// **InitiateJob** request when initiating a job to retrieve a vault
    /// inventory. Valid values are `CSV` and `JSON`.
    format: ?[]const u8 = null,

    /// The maximum number of inventory items returned per vault inventory retrieval
    /// request. This limit is set when initiating the job with the a
    /// **InitiateJob** request.
    limit: ?[]const u8 = null,

    /// An opaque string that represents where to continue pagination of the vault
    /// inventory retrieval results. You use the marker in a new **InitiateJob**
    /// request to obtain additional inventory items. If there are
    /// no more inventory items, this value is `null`. For more information, see
    /// [ Range Inventory
    /// Retrieval](https://docs.aws.amazon.com/amazonglacier/latest/dev/api-initiate-job-post.html#api-initiate-job-post-vault-inventory-list-filtering).
    marker: ?[]const u8 = null,

    /// The start of the date range in Universal Coordinated Time (UTC) for vault
    /// inventory
    /// retrieval that includes archives created on or after this date. This value
    /// should be a
    /// string in the ISO 8601 date format, for example
    /// `2013-03-20T17:03:43Z`.
    start_date: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .format = "Format",
        .limit = "Limit",
        .marker = "Marker",
        .start_date = "StartDate",
    };
};

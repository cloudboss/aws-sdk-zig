/// Specifies options related to data preview for viewing a sample of your data.
pub const StreamingDataPreviewOptions = struct {
    /// The polling time in milliseconds.
    polling_time: ?i64,

    /// The limit to the number of records polled.
    record_polling_limit: ?i64,

    pub const json_field_names = .{
        .polling_time = "PollingTime",
        .record_polling_limit = "RecordPollingLimit",
    };
};

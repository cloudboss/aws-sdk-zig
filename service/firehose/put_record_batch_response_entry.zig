/// Contains the result for an individual record from a PutRecordBatch
/// request. If the record is successfully added to your Firehose stream, it
/// receives a record
/// ID. If the record fails to be added to your Firehose stream, the result
/// includes an error
/// code and an error message.
pub const PutRecordBatchResponseEntry = struct {
    /// The error code for an individual record result.
    error_code: ?[]const u8 = null,

    /// The error message for an individual record result.
    error_message: ?[]const u8 = null,

    /// The ID of the record.
    record_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .record_id = "RecordId",
    };
};

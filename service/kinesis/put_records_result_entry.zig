/// Represents the result of an individual record from a `PutRecords` request.
/// A record that is successfully added to a stream includes `SequenceNumber`
/// and
/// `ShardId` in the result. A record that fails to be added to the stream
/// includes `ErrorCode` and `ErrorMessage` in the result.
pub const PutRecordsResultEntry = struct {
    /// The error code for an individual record result. `ErrorCodes` can be either
    /// `ProvisionedThroughputExceededException` or
    /// `InternalFailure`.
    error_code: ?[]const u8,

    /// The error message for an individual record result. An `ErrorCode` value of
    /// `ProvisionedThroughputExceededException` has an error message that
    /// includes the account ID, stream name, and shard ID. An `ErrorCode` value of
    /// `InternalFailure` has the error message `"Internal Service
    /// Failure"`.
    error_message: ?[]const u8,

    /// The sequence number for an individual record result.
    sequence_number: ?[]const u8,

    /// The shard ID for an individual record result.
    shard_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .sequence_number = "SequenceNumber",
        .shard_id = "ShardId",
    };
};

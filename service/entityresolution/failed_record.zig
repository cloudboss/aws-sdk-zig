/// The record that didn't generate a Match ID.
pub const FailedRecord = struct {
    /// The error message for the record that didn't generate a Match ID.
    error_message: []const u8,

    /// The input source ARN of the record that didn't generate a Match ID.
    input_source_arn: []const u8,

    /// The unique ID of the record that didn't generate a Match ID.
    unique_id: []const u8,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .input_source_arn = "inputSourceARN",
        .unique_id = "uniqueId",
    };
};

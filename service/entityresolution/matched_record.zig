/// The matched record.
pub const MatchedRecord = struct {
    /// The input source ARN of the matched record.
    input_source_arn: []const u8,

    /// The record ID of the matched record.
    record_id: []const u8,

    pub const json_field_names = .{
        .input_source_arn = "inputSourceARN",
        .record_id = "recordId",
    };
};

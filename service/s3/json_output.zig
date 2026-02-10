/// Specifies JSON as request's output serialization format.
pub const JSONOutput = struct {
    /// The value used to separate individual records in the output. If no value is
    /// specified, Amazon S3 uses a
    /// newline character ('\n').
    record_delimiter: ?[]const u8,
};

/// Configuration for Amazon S3 destination where scheduled query results are
/// delivered.
pub const S3Configuration = struct {
    /// The Amazon S3 URI where query results are delivered. Must be a valid S3 URI
    /// format.
    destination_identifier: []const u8,

    /// The ARN of the IAM role that grants permissions to write query results to
    /// the specified
    /// Amazon S3 destination.
    role_arn: []const u8,

    pub const json_field_names = .{
        .destination_identifier = "destinationIdentifier",
        .role_arn = "roleArn",
    };
};

/// The output for the product created as the result of a request. For example,
/// the output for
/// a CloudFormation-backed product that creates an S3 bucket would include the
/// S3 bucket URL.
pub const RecordOutput = struct {
    /// The description of the output.
    description: ?[]const u8,

    /// The output key.
    output_key: ?[]const u8,

    /// The output value.
    output_value: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .output_key = "OutputKey",
        .output_value = "OutputValue",
    };
};

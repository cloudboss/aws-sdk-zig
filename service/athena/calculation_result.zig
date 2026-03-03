/// Contains information about an application-specific calculation result.
pub const CalculationResult = struct {
    /// The Amazon S3 location of the folder for the calculation results.
    result_s3_uri: ?[]const u8 = null,

    /// The data format of the calculation result.
    result_type: ?[]const u8 = null,

    /// The Amazon S3 location of the `stderr` error messages file for the
    /// calculation.
    std_error_s3_uri: ?[]const u8 = null,

    /// The Amazon S3 location of the `stdout` file for the calculation.
    std_out_s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .result_s3_uri = "ResultS3Uri",
        .result_type = "ResultType",
        .std_error_s3_uri = "StdErrorS3Uri",
        .std_out_s3_uri = "StdOutS3Uri",
    };
};

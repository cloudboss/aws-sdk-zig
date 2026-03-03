const InferenceInputNameConfiguration = @import("inference_input_name_configuration.zig").InferenceInputNameConfiguration;
const InferenceS3InputConfiguration = @import("inference_s3_input_configuration.zig").InferenceS3InputConfiguration;

/// Specifies configuration information for the input data for the inference,
/// including
/// Amazon S3 location of input data..
pub const InferenceInputConfiguration = struct {
    /// Specifies configuration information for the input data for the inference,
    /// including
    /// timestamp format and delimiter.
    inference_input_name_configuration: ?InferenceInputNameConfiguration = null,

    /// Indicates the difference between your time zone and Coordinated Universal
    /// Time
    /// (UTC).
    input_time_zone_offset: ?[]const u8 = null,

    /// Specifies configuration information for the input data for the inference,
    /// including
    /// Amazon S3 location of input data.
    s3_input_configuration: ?InferenceS3InputConfiguration = null,

    pub const json_field_names = .{
        .inference_input_name_configuration = "InferenceInputNameConfiguration",
        .input_time_zone_offset = "InputTimeZoneOffset",
        .s3_input_configuration = "S3InputConfiguration",
    };
};

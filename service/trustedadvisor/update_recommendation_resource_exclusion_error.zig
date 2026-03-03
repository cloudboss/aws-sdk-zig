/// The error entry for Recommendation Resource exclusion. Each entry is a
/// combination of Recommendation Resource ARN, error code and error message
pub const UpdateRecommendationResourceExclusionError = struct {
    /// The ARN of the Recommendation Resource
    arn: ?[]const u8 = null,

    /// The error code
    error_code: ?[]const u8 = null,

    /// The error message
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};

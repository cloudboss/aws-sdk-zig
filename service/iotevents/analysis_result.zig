const AnalysisResultLevel = @import("analysis_result_level.zig").AnalysisResultLevel;
const AnalysisResultLocation = @import("analysis_result_location.zig").AnalysisResultLocation;

/// Contains the result of the analysis.
pub const AnalysisResult = struct {
    /// The severity level of the analysis result. Based on the severity level,
    /// analysis results
    /// fall into three general categories:
    ///
    /// * `INFO` - An information result tells you about a significant field in your
    /// detector model. This type of result usually doesn't require immediate
    /// action.
    ///
    /// * `WARNING` - A warning result draws special attention to fields that might
    ///   cause issues for your detector model.
    /// We recommend that you review warnings and take necessary actions
    /// before you use your detector model in production environments. Otherwise,
    /// the detector
    /// model might not work as expected.
    ///
    /// * `ERROR` - An error result notifies you about a problem found in your
    /// detector model. You must fix all errors before you can publish your detector
    /// model.
    level: ?AnalysisResultLevel = null,

    /// Contains one or more locations that you can use to locate the fields in your
    /// detector
    /// model that the analysis result references.
    locations: ?[]const AnalysisResultLocation = null,

    /// Contains additional information about the analysis result.
    message: ?[]const u8 = null,

    /// The type of the analysis result. Analyses fall into the following types
    /// based on the
    /// validators used to generate the analysis result:
    ///
    /// * `supported-actions` - You must specify AWS IoT Events supported actions
    ///   that work
    /// with other AWS services in a supported AWS Region.
    ///
    /// * `service-limits` - Resources or API operations can't exceed service
    /// quotas (also known as limits). Update your detector model or request a quota
    /// increase.
    ///
    /// * `structure` - The detector model must follow a structure that AWS IoT
    ///   Events
    /// supports.
    ///
    /// * `expression-syntax` - Your expression must follow the required
    /// syntax.
    ///
    /// * `data-type` - Data types referenced in the detector model must be
    /// compatible.
    ///
    /// * `referenced-data` - You must define the data referenced in your detector
    /// model before you can use the data.
    ///
    /// * `referenced-resource` - Resources that the detector model uses must be
    /// available.
    ///
    /// For more information, see [Running detector model
    /// analyses](https://docs.aws.amazon.com/iotevents/latest/developerguide/iotevents-analyze-api.html) in the *AWS IoT Events Developer Guide*.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .level = "level",
        .locations = "locations",
        .message = "message",
        .@"type" = "type",
    };
};

const ExtractedInformationValue = @import("extracted_information_value.zig").ExtractedInformationValue;
const ExtractedInformationFailureCode = @import("extracted_information_failure_code.zig").ExtractedInformationFailureCode;

/// Segment containing information extracted from the conversation. Each segment
/// represents the results for a single extraction definition.
pub const ExtractedInformation = struct {
    /// The list of values extracted from the conversation for this extraction
    /// definition.
    /// This field is empty when a `FailureCode` is present.
    extracted_values: ?[]const ExtractedInformationValue = null,

    /// The display label of the extraction definition that produced this result.
    extraction_definition_display_label: ?[]const u8 = null,

    /// The identifier of the extraction definition that produced this result.
    extraction_definition_id: []const u8,

    /// The name of the extraction definition that produced this result.
    extraction_definition_name: []const u8,

    /// If the information failed to be extracted, one of the following failure
    /// codes
    /// occurs:
    ///
    /// * `QUOTA_EXCEEDED`: The number of concurrent analytics jobs reached
    /// your service quota.
    ///
    /// * `INSUFFICIENT_CONVERSATION_CONTENT`: Information extraction requires a
    /// conversation with at least one turn from each participant.
    ///
    /// * `FAILED_SAFETY_GUIDELINES`: The extracted information cannot be
    /// provided because it failed to meet system safety guidelines.
    ///
    /// * `INTERNAL_ERROR`: Internal system error.
    ///
    /// * `MAX_PACKAGE_FEATURE_ONLY`: Information extraction is only available
    /// in Amazon Connect Customer instances.
    failure_code: ?ExtractedInformationFailureCode = null,

    pub const json_field_names = .{
        .extracted_values = "ExtractedValues",
        .extraction_definition_display_label = "ExtractionDefinitionDisplayLabel",
        .extraction_definition_id = "ExtractionDefinitionId",
        .extraction_definition_name = "ExtractionDefinitionName",
        .failure_code = "FailureCode",
    };
};

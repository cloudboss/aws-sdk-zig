const ClassificationResult = @import("classification_result.zig").ClassificationResult;

/// Provides details about sensitive data that was detected on a resource.
pub const DataClassificationDetails = struct {
    /// The path to the folder or file that contains the sensitive data.
    detailed_results_location: ?[]const u8,

    /// The details about the sensitive data that was detected on the resource.
    result: ?ClassificationResult,

    pub const json_field_names = .{
        .detailed_results_location = "DetailedResultsLocation",
        .result = "Result",
    };
};

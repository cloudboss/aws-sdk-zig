const OriginType = @import("origin_type.zig").OriginType;
const ClassificationResult = @import("classification_result.zig").ClassificationResult;

/// Provides information about a sensitive data finding and the details of the
/// finding.
pub const ClassificationDetails = struct {
    /// The path to the folder or file in Amazon S3 that contains the corresponding
    /// sensitive data discovery result for the finding. If a finding applies to a
    /// large archive or compressed file, this value is the path to a folder.
    /// Otherwise, this value is the path to a file.
    detailed_results_location: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the classification job that produced the
    /// finding. This value is null if the origin of the finding (originType) is
    /// AUTOMATED_SENSITIVE_DATA_DISCOVERY.
    job_arn: ?[]const u8 = null,

    /// The unique identifier for the classification job that produced the finding.
    /// This value is null if the origin of the finding (originType) is
    /// AUTOMATED_SENSITIVE_DATA_DISCOVERY.
    job_id: ?[]const u8 = null,

    /// Specifies how Amazon Macie found the sensitive data that produced the
    /// finding. Possible values are: SENSITIVE_DATA_DISCOVERY_JOB, for a
    /// classification job; and, AUTOMATED_SENSITIVE_DATA_DISCOVERY, for automated
    /// sensitive data discovery.
    origin_type: ?OriginType = null,

    /// The status and other details of the finding.
    result: ?ClassificationResult = null,

    pub const json_field_names = .{
        .detailed_results_location = "detailedResultsLocation",
        .job_arn = "jobArn",
        .job_id = "jobId",
        .origin_type = "originType",
        .result = "result",
    };
};

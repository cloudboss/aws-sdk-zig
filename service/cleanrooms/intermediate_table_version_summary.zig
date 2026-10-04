const PopulateIntermediateTableAnalysisType = @import("populate_intermediate_table_analysis_type.zig").PopulateIntermediateTableAnalysisType;
const IntermediateTableVersionStatus = @import("intermediate_table_version_status.zig").IntermediateTableVersionStatus;

/// Contains summary information about a version of an intermediate table.
pub const IntermediateTableVersionSummary = struct {
    /// The identifier of the protected query that created this version.
    analysis_id: []const u8,

    /// The type of analysis that created this version.
    analysis_type: PopulateIntermediateTableAnalysisType,

    /// The time the version was created.
    create_time: i64,

    /// The time when this version expires based on the retention period.
    expiration_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt this version's
    /// data.
    kms_key_arn: ?[]const u8 = null,

    /// The status of the version.
    status: IntermediateTableVersionStatus,

    /// The unique identifier of the intermediate table that this version belongs
    /// to.
    table_id: []const u8,

    /// The unique identifier of the version.
    version_id: []const u8,

    pub const json_field_names = .{
        .analysis_id = "analysisId",
        .analysis_type = "analysisType",
        .create_time = "createTime",
        .expiration_time = "expirationTime",
        .kms_key_arn = "kmsKeyArn",
        .status = "status",
        .table_id = "tableId",
        .version_id = "versionId",
    };
};

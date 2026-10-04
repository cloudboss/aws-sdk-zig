const aws = @import("aws");

const PopulateIntermediateTableAnalysisType = @import("populate_intermediate_table_analysis_type.zig").PopulateIntermediateTableAnalysisType;
const IntermediateTableInheritedConstraints = @import("intermediate_table_inherited_constraints.zig").IntermediateTableInheritedConstraints;

/// Contains the details of the currently active version of an intermediate
/// table.
pub const IntermediateTableActiveVersion = struct {
    /// The identifier of the protected query that created this version.
    analysis_id: []const u8,

    /// The type of analysis that created this version.
    analysis_type: PopulateIntermediateTableAnalysisType,

    /// The time when this version expires based on the retention period.
    expiration_time: ?i64 = null,

    /// The privacy constraints inherited from parent tables at the time this
    /// version was populated.
    inherited_constraints: IntermediateTableInheritedConstraints,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt this version's
    /// data.
    kms_key_arn: ?[]const u8 = null,

    /// The runtime parameters that were used when populating this version.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The unique identifier of the active version.
    version_id: []const u8,

    pub const json_field_names = .{
        .analysis_id = "analysisId",
        .analysis_type = "analysisType",
        .expiration_time = "expirationTime",
        .inherited_constraints = "inheritedConstraints",
        .kms_key_arn = "kmsKeyArn",
        .parameters = "parameters",
        .version_id = "versionId",
    };
};

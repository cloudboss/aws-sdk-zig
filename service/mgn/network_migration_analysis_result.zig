const AnalyzerType = @import("analyzer_type.zig").AnalyzerType;
const NetworkMigrationAnalysisResultSource = @import("network_migration_analysis_result_source.zig").NetworkMigrationAnalysisResultSource;
const NetworkMigrationAnalysisResultStatus = @import("network_migration_analysis_result_status.zig").NetworkMigrationAnalysisResultStatus;
const NetworkMigrationAnalysisResultTarget = @import("network_migration_analysis_result_target.zig").NetworkMigrationAnalysisResultTarget;

/// The result of a network migration analysis operation.
pub const NetworkMigrationAnalysisResult = struct {
    /// The detailed analysis findings and recommendations.
    analysis_result: ?[]const u8 = null,

    /// The type of analyzer that generated this result.
    analyzer_type: ?AnalyzerType = null,

    /// The unique identifier of the analysis job that generated this result.
    job_id: ?[]const u8 = null,

    /// The unique identifier of the network migration definition.
    network_migration_definition_id: ?[]const u8 = null,

    /// The unique identifier of the network migration execution.
    network_migration_execution_id: ?[]const u8 = null,

    /// The source resource that was analyzed.
    source: ?NetworkMigrationAnalysisResultSource = null,

    /// The status of the analysis result.
    status: ?NetworkMigrationAnalysisResultStatus = null,

    /// The target resource in the analysis.
    target: ?NetworkMigrationAnalysisResultTarget = null,

    pub const json_field_names = .{
        .analysis_result = "analysisResult",
        .analyzer_type = "analyzerType",
        .job_id = "jobID",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .network_migration_execution_id = "networkMigrationExecutionID",
        .source = "source",
        .status = "status",
        .target = "target",
    };
};

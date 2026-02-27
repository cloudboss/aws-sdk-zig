const aws = @import("aws");

const ActionExecutionResult = @import("action_execution_result.zig").ActionExecutionResult;
const ArtifactDetail = @import("artifact_detail.zig").ArtifactDetail;

/// Output details listed for an action execution, such as the action execution
/// result.
pub const ActionExecutionOutput = struct {
    /// Execution result information listed in the output details for an action
    /// execution.
    execution_result: ?ActionExecutionResult,

    /// Details of output artifacts of the action that correspond to the action
    /// execution.
    output_artifacts: ?[]const ArtifactDetail,

    /// The outputVariables field shows the key-value pairs that were output as part
    /// of that
    /// execution.
    output_variables: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .execution_result = "executionResult",
        .output_artifacts = "outputArtifacts",
        .output_variables = "outputVariables",
    };
};

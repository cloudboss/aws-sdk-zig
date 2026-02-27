const ExecutionBlockConfiguration = @import("execution_block_configuration.zig").ExecutionBlockConfiguration;
const ExecutionBlockType = @import("execution_block_type.zig").ExecutionBlockType;

/// Represents a step in a Region switch plan workflow. Each step performs a
/// specific action during the Region switch process.
pub const Step = struct {
    /// The description of a step in a workflow.
    description: ?[]const u8,

    /// The configuration for an execution block in a workflow.
    execution_block_configuration: ExecutionBlockConfiguration,

    /// The type of an execution block in a workflow.
    execution_block_type: ExecutionBlockType,

    /// The name of a step in a workflow.
    name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .execution_block_configuration = "executionBlockConfiguration",
        .execution_block_type = "executionBlockType",
        .name = "name",
    };
};

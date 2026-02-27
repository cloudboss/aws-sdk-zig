const SourceFlowConfig = @import("source_flow_config.zig").SourceFlowConfig;
const Task = @import("task.zig").Task;
const TriggerConfig = @import("trigger_config.zig").TriggerConfig;

/// The configurations that control how Customer Profiles retrieves data from
/// the source,
/// Amazon AppFlow. Customer Profiles uses this information to create an AppFlow
/// flow on behalf of
/// customers.
pub const FlowDefinition = struct {
    /// A description of the flow you want to create.
    description: ?[]const u8,

    /// The specified name of the flow. Use underscores (_) or hyphens (-) only.
    /// Spaces are not
    /// allowed.
    flow_name: []const u8,

    /// The Amazon Resource Name of the AWS Key Management Service (KMS) key you
    /// provide for encryption.
    kms_arn: []const u8,

    /// The configuration that controls how Customer Profiles retrieves data from
    /// the
    /// source.
    source_flow_config: SourceFlowConfig,

    /// A list of tasks that Customer Profiles performs while transferring the data
    /// in the flow
    /// run.
    tasks: []const Task,

    /// The trigger settings that determine how and when the flow runs.
    trigger_config: TriggerConfig,

    pub const json_field_names = .{
        .description = "Description",
        .flow_name = "FlowName",
        .kms_arn = "KmsArn",
        .source_flow_config = "SourceFlowConfig",
        .tasks = "Tasks",
        .trigger_config = "TriggerConfig",
    };
};

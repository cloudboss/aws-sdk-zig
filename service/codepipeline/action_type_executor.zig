const ExecutorConfiguration = @import("executor_configuration.zig").ExecutorConfiguration;
const ExecutorType = @import("executor_type.zig").ExecutorType;

/// The action engine, or executor, for an action type created for a provider,
/// where the
/// action is to be used by customers of the provider. The action engine is
/// associated with
/// the model used to create and update the action, such as the Lambda
/// integration
/// model.
pub const ActionTypeExecutor = struct {
    /// The action configuration properties for the action type. These properties
    /// are
    /// specified in the action definition when the action type is created.
    configuration: ExecutorConfiguration,

    /// The timeout in seconds for the job. An action execution can have multiple
    /// jobs. This
    /// is the timeout for a single job, not the entire action execution.
    job_timeout: ?i32 = null,

    /// The policy statement that specifies the permissions in the CodePipeline
    /// customer
    /// account that are needed to successfully run an action.
    ///
    /// To grant permission to another account, specify the account ID as the
    /// Principal, a
    /// domain-style identifier defined by the service, for example
    /// `codepipeline.amazonaws.com`.
    ///
    /// The size of the passed JSON policy document cannot exceed 2048 characters.
    policy_statements_template: ?[]const u8 = null,

    /// The integration model used to create and update the action type, `Lambda`
    /// or `JobWorker`.
    @"type": ExecutorType,

    pub const json_field_names = .{
        .configuration = "configuration",
        .job_timeout = "jobTimeout",
        .policy_statements_template = "policyStatementsTemplate",
        .@"type" = "type",
    };
};

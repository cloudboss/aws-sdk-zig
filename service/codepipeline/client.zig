const aws = @import("aws");
const std = @import("std");

const acknowledge_job = @import("acknowledge_job.zig");
const acknowledge_third_party_job = @import("acknowledge_third_party_job.zig");
const create_custom_action_type = @import("create_custom_action_type.zig");
const create_pipeline = @import("create_pipeline.zig");
const delete_custom_action_type = @import("delete_custom_action_type.zig");
const delete_pipeline = @import("delete_pipeline.zig");
const delete_webhook = @import("delete_webhook.zig");
const deregister_webhook_with_third_party = @import("deregister_webhook_with_third_party.zig");
const disable_stage_transition = @import("disable_stage_transition.zig");
const enable_stage_transition = @import("enable_stage_transition.zig");
const get_action_type = @import("get_action_type.zig");
const get_job_details = @import("get_job_details.zig");
const get_pipeline = @import("get_pipeline.zig");
const get_pipeline_execution = @import("get_pipeline_execution.zig");
const get_pipeline_state = @import("get_pipeline_state.zig");
const get_third_party_job_details = @import("get_third_party_job_details.zig");
const list_action_executions = @import("list_action_executions.zig");
const list_action_types = @import("list_action_types.zig");
const list_deploy_action_execution_targets = @import("list_deploy_action_execution_targets.zig");
const list_pipeline_executions = @import("list_pipeline_executions.zig");
const list_pipelines = @import("list_pipelines.zig");
const list_rule_executions = @import("list_rule_executions.zig");
const list_rule_types = @import("list_rule_types.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_webhooks = @import("list_webhooks.zig");
const override_stage_condition = @import("override_stage_condition.zig");
const poll_for_jobs = @import("poll_for_jobs.zig");
const poll_for_third_party_jobs = @import("poll_for_third_party_jobs.zig");
const put_action_revision = @import("put_action_revision.zig");
const put_approval_result = @import("put_approval_result.zig");
const put_job_failure_result = @import("put_job_failure_result.zig");
const put_job_success_result = @import("put_job_success_result.zig");
const put_third_party_job_failure_result = @import("put_third_party_job_failure_result.zig");
const put_third_party_job_success_result = @import("put_third_party_job_success_result.zig");
const put_webhook = @import("put_webhook.zig");
const register_webhook_with_third_party = @import("register_webhook_with_third_party.zig");
const retry_stage_execution = @import("retry_stage_execution.zig");
const rollback_stage = @import("rollback_stage.zig");
const start_pipeline_execution = @import("start_pipeline_execution.zig");
const stop_pipeline_execution = @import("stop_pipeline_execution.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_action_type = @import("update_action_type.zig");
const update_pipeline = @import("update_pipeline.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CodePipeline";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Returns information about a specified job and whether that job has been
    /// received by
    /// the job worker. Used for custom actions only.
    pub fn acknowledgeJob(self: *Self, allocator: std.mem.Allocator, input: acknowledge_job.AcknowledgeJobInput, options: CallOptions) !acknowledge_job.AcknowledgeJobOutput {
        return acknowledge_job.execute(self, allocator, input, options);
    }

    /// Confirms a job worker has received the specified job. Used for partner
    /// actions
    /// only.
    pub fn acknowledgeThirdPartyJob(self: *Self, allocator: std.mem.Allocator, input: acknowledge_third_party_job.AcknowledgeThirdPartyJobInput, options: CallOptions) !acknowledge_third_party_job.AcknowledgeThirdPartyJobOutput {
        return acknowledge_third_party_job.execute(self, allocator, input, options);
    }

    /// Creates a new custom action that can be used in all pipelines associated
    /// with the
    /// Amazon Web Services account. Only used for custom actions.
    pub fn createCustomActionType(self: *Self, allocator: std.mem.Allocator, input: create_custom_action_type.CreateCustomActionTypeInput, options: CallOptions) !create_custom_action_type.CreateCustomActionTypeOutput {
        return create_custom_action_type.execute(self, allocator, input, options);
    }

    /// Creates a pipeline.
    ///
    /// In the pipeline structure, you must include either `artifactStore`
    /// or `artifactStores` in your pipeline, but you cannot use both. If you
    /// create a cross-region action in your pipeline, you must use
    /// `artifactStores`.
    pub fn createPipeline(self: *Self, allocator: std.mem.Allocator, input: create_pipeline.CreatePipelineInput, options: CallOptions) !create_pipeline.CreatePipelineOutput {
        return create_pipeline.execute(self, allocator, input, options);
    }

    /// Marks a custom action as deleted. `PollForJobs` for the custom action
    /// fails after the action is marked for deletion. Used for custom actions only.
    ///
    /// To re-create a custom action after it has been deleted you must use a string
    /// in
    /// the version field that has never been used before. This string can be an
    /// incremented
    /// version number, for example. To restore a deleted custom action, use a JSON
    /// file
    /// that is identical to the deleted action, including the original string in
    /// the
    /// version field.
    pub fn deleteCustomActionType(self: *Self, allocator: std.mem.Allocator, input: delete_custom_action_type.DeleteCustomActionTypeInput, options: CallOptions) !delete_custom_action_type.DeleteCustomActionTypeOutput {
        return delete_custom_action_type.execute(self, allocator, input, options);
    }

    /// Deletes the specified pipeline.
    pub fn deletePipeline(self: *Self, allocator: std.mem.Allocator, input: delete_pipeline.DeletePipelineInput, options: CallOptions) !delete_pipeline.DeletePipelineOutput {
        return delete_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes a previously created webhook by name. Deleting the webhook stops
    /// CodePipeline from starting a pipeline every time an external event occurs.
    /// The API
    /// returns successfully when trying to delete a webhook that is already
    /// deleted. If a
    /// deleted webhook is re-created by calling PutWebhook with the same name, it
    /// will have a
    /// different URL.
    pub fn deleteWebhook(self: *Self, allocator: std.mem.Allocator, input: delete_webhook.DeleteWebhookInput, options: CallOptions) !delete_webhook.DeleteWebhookOutput {
        return delete_webhook.execute(self, allocator, input, options);
    }

    /// Removes the connection between the webhook that was created by CodePipeline
    /// and the external tool with events to be detected. Currently supported only
    /// for webhooks
    /// that target an action type of GitHub.
    pub fn deregisterWebhookWithThirdParty(self: *Self, allocator: std.mem.Allocator, input: deregister_webhook_with_third_party.DeregisterWebhookWithThirdPartyInput, options: CallOptions) !deregister_webhook_with_third_party.DeregisterWebhookWithThirdPartyOutput {
        return deregister_webhook_with_third_party.execute(self, allocator, input, options);
    }

    /// Prevents artifacts in a pipeline from transitioning to the next stage in the
    /// pipeline.
    pub fn disableStageTransition(self: *Self, allocator: std.mem.Allocator, input: disable_stage_transition.DisableStageTransitionInput, options: CallOptions) !disable_stage_transition.DisableStageTransitionOutput {
        return disable_stage_transition.execute(self, allocator, input, options);
    }

    /// Enables artifacts in a pipeline to transition to a stage in a pipeline.
    pub fn enableStageTransition(self: *Self, allocator: std.mem.Allocator, input: enable_stage_transition.EnableStageTransitionInput, options: CallOptions) !enable_stage_transition.EnableStageTransitionOutput {
        return enable_stage_transition.execute(self, allocator, input, options);
    }

    /// Returns information about an action type created for an external provider,
    /// where the
    /// action is to be used by customers of the external provider. The action can
    /// be created
    /// with any supported integration model.
    pub fn getActionType(self: *Self, allocator: std.mem.Allocator, input: get_action_type.GetActionTypeInput, options: CallOptions) !get_action_type.GetActionTypeOutput {
        return get_action_type.execute(self, allocator, input, options);
    }

    /// Returns information about a job. Used for custom actions only.
    ///
    /// When this API is called, CodePipeline returns temporary credentials for
    /// the S3 bucket used to store artifacts for the pipeline, if the action
    /// requires
    /// access to that S3 bucket for input or output artifacts. This API also
    /// returns any
    /// secret values defined for the action.
    pub fn getJobDetails(self: *Self, allocator: std.mem.Allocator, input: get_job_details.GetJobDetailsInput, options: CallOptions) !get_job_details.GetJobDetailsOutput {
        return get_job_details.execute(self, allocator, input, options);
    }

    /// Returns the metadata, structure, stages, and actions of a pipeline. Can be
    /// used to
    /// return the entire structure of a pipeline in JSON format, which can then be
    /// modified and
    /// used to update the pipeline structure with UpdatePipeline.
    pub fn getPipeline(self: *Self, allocator: std.mem.Allocator, input: get_pipeline.GetPipelineInput, options: CallOptions) !get_pipeline.GetPipelineOutput {
        return get_pipeline.execute(self, allocator, input, options);
    }

    /// Returns information about an execution of a pipeline, including details
    /// about
    /// artifacts, the pipeline execution ID, and the name, version, and status of
    /// the
    /// pipeline.
    pub fn getPipelineExecution(self: *Self, allocator: std.mem.Allocator, input: get_pipeline_execution.GetPipelineExecutionInput, options: CallOptions) !get_pipeline_execution.GetPipelineExecutionOutput {
        return get_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Returns information about the state of a pipeline, including the stages and
    /// actions.
    ///
    /// Values returned in the `revisionId` and `revisionUrl`
    /// fields indicate the source revision information, such as the commit ID, for
    /// the
    /// current state.
    pub fn getPipelineState(self: *Self, allocator: std.mem.Allocator, input: get_pipeline_state.GetPipelineStateInput, options: CallOptions) !get_pipeline_state.GetPipelineStateOutput {
        return get_pipeline_state.execute(self, allocator, input, options);
    }

    /// Requests the details of a job for a third party action. Used for partner
    /// actions
    /// only.
    ///
    /// When this API is called, CodePipeline returns temporary credentials for
    /// the S3 bucket used to store artifacts for the pipeline, if the action
    /// requires
    /// access to that S3 bucket for input or output artifacts. This API also
    /// returns any
    /// secret values defined for the action.
    pub fn getThirdPartyJobDetails(self: *Self, allocator: std.mem.Allocator, input: get_third_party_job_details.GetThirdPartyJobDetailsInput, options: CallOptions) !get_third_party_job_details.GetThirdPartyJobDetailsOutput {
        return get_third_party_job_details.execute(self, allocator, input, options);
    }

    /// Lists the action executions that have occurred in a pipeline.
    pub fn listActionExecutions(self: *Self, allocator: std.mem.Allocator, input: list_action_executions.ListActionExecutionsInput, options: CallOptions) !list_action_executions.ListActionExecutionsOutput {
        return list_action_executions.execute(self, allocator, input, options);
    }

    /// Gets a summary of all CodePipeline action types associated with your
    /// account.
    pub fn listActionTypes(self: *Self, allocator: std.mem.Allocator, input: list_action_types.ListActionTypesInput, options: CallOptions) !list_action_types.ListActionTypesOutput {
        return list_action_types.execute(self, allocator, input, options);
    }

    /// Lists the targets for the deploy action.
    pub fn listDeployActionExecutionTargets(self: *Self, allocator: std.mem.Allocator, input: list_deploy_action_execution_targets.ListDeployActionExecutionTargetsInput, options: CallOptions) !list_deploy_action_execution_targets.ListDeployActionExecutionTargetsOutput {
        return list_deploy_action_execution_targets.execute(self, allocator, input, options);
    }

    /// Gets a summary of the most recent executions for a pipeline.
    ///
    /// When applying the filter for pipeline executions that have succeeded in the
    /// stage,
    /// the operation returns all executions in the current pipeline version
    /// beginning on
    /// February 1, 2024.
    pub fn listPipelineExecutions(self: *Self, allocator: std.mem.Allocator, input: list_pipeline_executions.ListPipelineExecutionsInput, options: CallOptions) !list_pipeline_executions.ListPipelineExecutionsOutput {
        return list_pipeline_executions.execute(self, allocator, input, options);
    }

    /// Gets a summary of all of the pipelines associated with your account.
    pub fn listPipelines(self: *Self, allocator: std.mem.Allocator, input: list_pipelines.ListPipelinesInput, options: CallOptions) !list_pipelines.ListPipelinesOutput {
        return list_pipelines.execute(self, allocator, input, options);
    }

    /// Lists the rule executions that have occurred in a pipeline configured for
    /// conditions
    /// with rules.
    pub fn listRuleExecutions(self: *Self, allocator: std.mem.Allocator, input: list_rule_executions.ListRuleExecutionsInput, options: CallOptions) !list_rule_executions.ListRuleExecutionsOutput {
        return list_rule_executions.execute(self, allocator, input, options);
    }

    /// Lists the rules for the condition. For more information about conditions,
    /// see [Stage
    /// conditions](https://docs.aws.amazon.com/codepipeline/latest/userguide/stage-conditions.html) and [How do
    /// stage conditions
    /// work?](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts-how-it-works-conditions.html).For more information about rules, see the [CodePipeline rule reference](https://docs.aws.amazon.com/codepipeline/latest/userguide/rule-reference.html).
    pub fn listRuleTypes(self: *Self, allocator: std.mem.Allocator, input: list_rule_types.ListRuleTypesInput, options: CallOptions) !list_rule_types.ListRuleTypesOutput {
        return list_rule_types.execute(self, allocator, input, options);
    }

    /// Gets the set of key-value pairs (metadata) that are used to manage the
    /// resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Gets a listing of all the webhooks in this Amazon Web Services Region for
    /// this
    /// account. The output lists all webhooks and includes the webhook URL and ARN
    /// and the
    /// configuration for each webhook.
    ///
    /// If a secret token was provided, it will be redacted in the response.
    pub fn listWebhooks(self: *Self, allocator: std.mem.Allocator, input: list_webhooks.ListWebhooksInput, options: CallOptions) !list_webhooks.ListWebhooksOutput {
        return list_webhooks.execute(self, allocator, input, options);
    }

    /// Used to override a stage condition. For more information about conditions,
    /// see [Stage
    /// conditions](https://docs.aws.amazon.com/codepipeline/latest/userguide/stage-conditions.html) and [How do
    /// stage conditions
    /// work?](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts-how-it-works-conditions.html).
    pub fn overrideStageCondition(self: *Self, allocator: std.mem.Allocator, input: override_stage_condition.OverrideStageConditionInput, options: CallOptions) !override_stage_condition.OverrideStageConditionOutput {
        return override_stage_condition.execute(self, allocator, input, options);
    }

    /// Returns information about any jobs for CodePipeline to act on.
    /// `PollForJobs` is valid only for action types with "Custom" in the owner
    /// field. If the action type contains `AWS` or `ThirdParty` in the
    /// owner field, the `PollForJobs` action returns an error.
    ///
    /// When this API is called, CodePipeline returns temporary credentials for
    /// the S3 bucket used to store artifacts for the pipeline, if the action
    /// requires
    /// access to that S3 bucket for input or output artifacts. This API also
    /// returns any
    /// secret values defined for the action.
    pub fn pollForJobs(self: *Self, allocator: std.mem.Allocator, input: poll_for_jobs.PollForJobsInput, options: CallOptions) !poll_for_jobs.PollForJobsOutput {
        return poll_for_jobs.execute(self, allocator, input, options);
    }

    /// Determines whether there are any third party jobs for a job worker to act
    /// on. Used
    /// for partner actions only.
    ///
    /// When this API is called, CodePipeline returns temporary credentials for
    /// the S3 bucket used to store artifacts for the pipeline, if the action
    /// requires
    /// access to that S3 bucket for input or output artifacts.
    pub fn pollForThirdPartyJobs(self: *Self, allocator: std.mem.Allocator, input: poll_for_third_party_jobs.PollForThirdPartyJobsInput, options: CallOptions) !poll_for_third_party_jobs.PollForThirdPartyJobsOutput {
        return poll_for_third_party_jobs.execute(self, allocator, input, options);
    }

    /// Provides information to CodePipeline about new revisions to a
    /// source.
    pub fn putActionRevision(self: *Self, allocator: std.mem.Allocator, input: put_action_revision.PutActionRevisionInput, options: CallOptions) !put_action_revision.PutActionRevisionOutput {
        return put_action_revision.execute(self, allocator, input, options);
    }

    /// Provides the response to a manual approval request to CodePipeline. Valid
    /// responses include Approved and Rejected.
    pub fn putApprovalResult(self: *Self, allocator: std.mem.Allocator, input: put_approval_result.PutApprovalResultInput, options: CallOptions) !put_approval_result.PutApprovalResultOutput {
        return put_approval_result.execute(self, allocator, input, options);
    }

    /// Represents the failure of a job as returned to the pipeline by a job worker.
    /// Used
    /// for custom actions only.
    pub fn putJobFailureResult(self: *Self, allocator: std.mem.Allocator, input: put_job_failure_result.PutJobFailureResultInput, options: CallOptions) !put_job_failure_result.PutJobFailureResultOutput {
        return put_job_failure_result.execute(self, allocator, input, options);
    }

    /// Represents the success of a job as returned to the pipeline by a job worker.
    /// Used
    /// for custom actions only.
    pub fn putJobSuccessResult(self: *Self, allocator: std.mem.Allocator, input: put_job_success_result.PutJobSuccessResultInput, options: CallOptions) !put_job_success_result.PutJobSuccessResultOutput {
        return put_job_success_result.execute(self, allocator, input, options);
    }

    /// Represents the failure of a third party job as returned to the pipeline by a
    /// job
    /// worker. Used for partner actions only.
    pub fn putThirdPartyJobFailureResult(self: *Self, allocator: std.mem.Allocator, input: put_third_party_job_failure_result.PutThirdPartyJobFailureResultInput, options: CallOptions) !put_third_party_job_failure_result.PutThirdPartyJobFailureResultOutput {
        return put_third_party_job_failure_result.execute(self, allocator, input, options);
    }

    /// Represents the success of a third party job as returned to the pipeline by a
    /// job
    /// worker. Used for partner actions only.
    pub fn putThirdPartyJobSuccessResult(self: *Self, allocator: std.mem.Allocator, input: put_third_party_job_success_result.PutThirdPartyJobSuccessResultInput, options: CallOptions) !put_third_party_job_success_result.PutThirdPartyJobSuccessResultOutput {
        return put_third_party_job_success_result.execute(self, allocator, input, options);
    }

    /// Defines a webhook and returns a unique webhook URL generated by
    /// CodePipeline.
    /// This URL can be supplied to third party source hosting providers to call
    /// every time
    /// there's a code change. When CodePipeline receives a POST request on this
    /// URL, the
    /// pipeline defined in the webhook is started as long as the POST request
    /// satisfied the
    /// authentication and filtering requirements supplied when defining the
    /// webhook.
    /// RegisterWebhookWithThirdParty and DeregisterWebhookWithThirdParty APIs can
    /// be used to
    /// automatically configure supported third parties to call the generated
    /// webhook
    /// URL.
    ///
    /// When creating CodePipeline webhooks, do not use your own credentials or
    /// reuse the same secret token across multiple webhooks. For optimal security,
    /// generate
    /// a unique secret token for each webhook you create. The secret token is an
    /// arbitrary
    /// string that you provide, which GitHub uses to compute and sign the webhook
    /// payloads
    /// sent to CodePipeline, for protecting the integrity and authenticity of the
    /// webhook payloads. Using your own credentials or reusing the same token
    /// across
    /// multiple webhooks can lead to security vulnerabilities.
    ///
    /// If a secret token was provided, it will be redacted in the response.
    pub fn putWebhook(self: *Self, allocator: std.mem.Allocator, input: put_webhook.PutWebhookInput, options: CallOptions) !put_webhook.PutWebhookOutput {
        return put_webhook.execute(self, allocator, input, options);
    }

    /// Configures a connection between the webhook that was created and the
    /// external tool
    /// with events to be detected.
    pub fn registerWebhookWithThirdParty(self: *Self, allocator: std.mem.Allocator, input: register_webhook_with_third_party.RegisterWebhookWithThirdPartyInput, options: CallOptions) !register_webhook_with_third_party.RegisterWebhookWithThirdPartyOutput {
        return register_webhook_with_third_party.execute(self, allocator, input, options);
    }

    /// You can retry a stage that has failed without having to run a pipeline again
    /// from
    /// the beginning. You do this by either retrying the failed actions in a stage
    /// or by
    /// retrying all actions in the stage starting from the first action in the
    /// stage. When you
    /// retry the failed actions in a stage, all actions that are still in progress
    /// continue
    /// working, and failed actions are triggered again. When you retry a failed
    /// stage from the
    /// first action in the stage, the stage cannot have any actions in progress.
    /// Before a stage
    /// can be retried, it must either have all actions failed or some actions
    /// failed and some
    /// succeeded.
    pub fn retryStageExecution(self: *Self, allocator: std.mem.Allocator, input: retry_stage_execution.RetryStageExecutionInput, options: CallOptions) !retry_stage_execution.RetryStageExecutionOutput {
        return retry_stage_execution.execute(self, allocator, input, options);
    }

    /// Rolls back a stage execution.
    pub fn rollbackStage(self: *Self, allocator: std.mem.Allocator, input: rollback_stage.RollbackStageInput, options: CallOptions) !rollback_stage.RollbackStageOutput {
        return rollback_stage.execute(self, allocator, input, options);
    }

    /// Starts the specified pipeline. Specifically, it begins processing the latest
    /// commit
    /// to the source location specified as part of the pipeline.
    pub fn startPipelineExecution(self: *Self, allocator: std.mem.Allocator, input: start_pipeline_execution.StartPipelineExecutionInput, options: CallOptions) !start_pipeline_execution.StartPipelineExecutionOutput {
        return start_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Stops the specified pipeline execution. You choose to either stop the
    /// pipeline
    /// execution by completing in-progress actions without starting subsequent
    /// actions, or by
    /// abandoning in-progress actions. While completing or abandoning in-progress
    /// actions, the
    /// pipeline execution is in a `Stopping` state. After all in-progress actions
    /// are completed or abandoned, the pipeline execution is in a `Stopped`
    /// state.
    pub fn stopPipelineExecution(self: *Self, allocator: std.mem.Allocator, input: stop_pipeline_execution.StopPipelineExecutionInput, options: CallOptions) !stop_pipeline_execution.StopPipelineExecutionOutput {
        return stop_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Adds to or modifies the tags of the given resource. Tags are metadata that
    /// can be used
    /// to manage a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from an Amazon Web Services resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an action type that was created with any supported integration
    /// model, where
    /// the action type is to be used by customers of the action type provider. Use
    /// a JSON file
    /// with the action definition and `UpdateActionType` to provide the full
    /// structure.
    pub fn updateActionType(self: *Self, allocator: std.mem.Allocator, input: update_action_type.UpdateActionTypeInput, options: CallOptions) !update_action_type.UpdateActionTypeOutput {
        return update_action_type.execute(self, allocator, input, options);
    }

    /// Updates a specified pipeline with edits or changes to its structure. Use a
    /// JSON
    /// file with the pipeline structure and `UpdatePipeline` to provide the full
    /// structure of the pipeline. Updating the pipeline increases the version
    /// number of the
    /// pipeline by 1.
    pub fn updatePipeline(self: *Self, allocator: std.mem.Allocator, input: update_pipeline.UpdatePipelineInput, options: CallOptions) !update_pipeline.UpdatePipelineOutput {
        return update_pipeline.execute(self, allocator, input, options);
    }

    pub fn listActionExecutionsPaginator(self: *Self, params: list_action_executions.ListActionExecutionsInput) paginator.ListActionExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listActionTypesPaginator(self: *Self, params: list_action_types.ListActionTypesInput) paginator.ListActionTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeployActionExecutionTargetsPaginator(self: *Self, params: list_deploy_action_execution_targets.ListDeployActionExecutionTargetsInput) paginator.ListDeployActionExecutionTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelineExecutionsPaginator(self: *Self, params: list_pipeline_executions.ListPipelineExecutionsInput) paginator.ListPipelineExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelinesPaginator(self: *Self, params: list_pipelines.ListPipelinesInput) paginator.ListPipelinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRuleExecutionsPaginator(self: *Self, params: list_rule_executions.ListRuleExecutionsInput) paginator.ListRuleExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWebhooksPaginator(self: *Self, params: list_webhooks.ListWebhooksInput) paginator.ListWebhooksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

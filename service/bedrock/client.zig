const aws = @import("aws");
const std = @import("std");

const batch_delete_evaluation_job = @import("batch_delete_evaluation_job.zig");
const cancel_automated_reasoning_policy_build_workflow = @import("cancel_automated_reasoning_policy_build_workflow.zig");
const create_automated_reasoning_policy = @import("create_automated_reasoning_policy.zig");
const create_automated_reasoning_policy_test_case = @import("create_automated_reasoning_policy_test_case.zig");
const create_automated_reasoning_policy_version = @import("create_automated_reasoning_policy_version.zig");
const create_custom_model = @import("create_custom_model.zig");
const create_custom_model_deployment = @import("create_custom_model_deployment.zig");
const create_evaluation_job = @import("create_evaluation_job.zig");
const create_foundation_model_agreement = @import("create_foundation_model_agreement.zig");
const create_guardrail = @import("create_guardrail.zig");
const create_guardrail_version = @import("create_guardrail_version.zig");
const create_inference_profile = @import("create_inference_profile.zig");
const create_marketplace_model_endpoint = @import("create_marketplace_model_endpoint.zig");
const create_model_copy_job = @import("create_model_copy_job.zig");
const create_model_customization_job = @import("create_model_customization_job.zig");
const create_model_import_job = @import("create_model_import_job.zig");
const create_model_invocation_job = @import("create_model_invocation_job.zig");
const create_prompt_router = @import("create_prompt_router.zig");
const create_provisioned_model_throughput = @import("create_provisioned_model_throughput.zig");
const delete_automated_reasoning_policy = @import("delete_automated_reasoning_policy.zig");
const delete_automated_reasoning_policy_build_workflow = @import("delete_automated_reasoning_policy_build_workflow.zig");
const delete_automated_reasoning_policy_test_case = @import("delete_automated_reasoning_policy_test_case.zig");
const delete_custom_model = @import("delete_custom_model.zig");
const delete_custom_model_deployment = @import("delete_custom_model_deployment.zig");
const delete_enforced_guardrail_configuration = @import("delete_enforced_guardrail_configuration.zig");
const delete_foundation_model_agreement = @import("delete_foundation_model_agreement.zig");
const delete_guardrail = @import("delete_guardrail.zig");
const delete_imported_model = @import("delete_imported_model.zig");
const delete_inference_profile = @import("delete_inference_profile.zig");
const delete_marketplace_model_endpoint = @import("delete_marketplace_model_endpoint.zig");
const delete_model_invocation_logging_configuration = @import("delete_model_invocation_logging_configuration.zig");
const delete_prompt_router = @import("delete_prompt_router.zig");
const delete_provisioned_model_throughput = @import("delete_provisioned_model_throughput.zig");
const deregister_marketplace_model_endpoint = @import("deregister_marketplace_model_endpoint.zig");
const export_automated_reasoning_policy_version = @import("export_automated_reasoning_policy_version.zig");
const get_automated_reasoning_policy = @import("get_automated_reasoning_policy.zig");
const get_automated_reasoning_policy_annotations = @import("get_automated_reasoning_policy_annotations.zig");
const get_automated_reasoning_policy_build_workflow = @import("get_automated_reasoning_policy_build_workflow.zig");
const get_automated_reasoning_policy_build_workflow_result_assets = @import("get_automated_reasoning_policy_build_workflow_result_assets.zig");
const get_automated_reasoning_policy_next_scenario = @import("get_automated_reasoning_policy_next_scenario.zig");
const get_automated_reasoning_policy_test_case = @import("get_automated_reasoning_policy_test_case.zig");
const get_automated_reasoning_policy_test_result = @import("get_automated_reasoning_policy_test_result.zig");
const get_custom_model = @import("get_custom_model.zig");
const get_custom_model_deployment = @import("get_custom_model_deployment.zig");
const get_evaluation_job = @import("get_evaluation_job.zig");
const get_foundation_model = @import("get_foundation_model.zig");
const get_foundation_model_availability = @import("get_foundation_model_availability.zig");
const get_guardrail = @import("get_guardrail.zig");
const get_imported_model = @import("get_imported_model.zig");
const get_inference_profile = @import("get_inference_profile.zig");
const get_marketplace_model_endpoint = @import("get_marketplace_model_endpoint.zig");
const get_model_copy_job = @import("get_model_copy_job.zig");
const get_model_customization_job = @import("get_model_customization_job.zig");
const get_model_import_job = @import("get_model_import_job.zig");
const get_model_invocation_job = @import("get_model_invocation_job.zig");
const get_model_invocation_logging_configuration = @import("get_model_invocation_logging_configuration.zig");
const get_prompt_router = @import("get_prompt_router.zig");
const get_provisioned_model_throughput = @import("get_provisioned_model_throughput.zig");
const get_use_case_for_model_access = @import("get_use_case_for_model_access.zig");
const list_automated_reasoning_policies = @import("list_automated_reasoning_policies.zig");
const list_automated_reasoning_policy_build_workflows = @import("list_automated_reasoning_policy_build_workflows.zig");
const list_automated_reasoning_policy_test_cases = @import("list_automated_reasoning_policy_test_cases.zig");
const list_automated_reasoning_policy_test_results = @import("list_automated_reasoning_policy_test_results.zig");
const list_custom_model_deployments = @import("list_custom_model_deployments.zig");
const list_custom_models = @import("list_custom_models.zig");
const list_enforced_guardrails_configuration = @import("list_enforced_guardrails_configuration.zig");
const list_evaluation_jobs = @import("list_evaluation_jobs.zig");
const list_foundation_model_agreement_offers = @import("list_foundation_model_agreement_offers.zig");
const list_foundation_models = @import("list_foundation_models.zig");
const list_guardrails = @import("list_guardrails.zig");
const list_imported_models = @import("list_imported_models.zig");
const list_inference_profiles = @import("list_inference_profiles.zig");
const list_marketplace_model_endpoints = @import("list_marketplace_model_endpoints.zig");
const list_model_copy_jobs = @import("list_model_copy_jobs.zig");
const list_model_customization_jobs = @import("list_model_customization_jobs.zig");
const list_model_import_jobs = @import("list_model_import_jobs.zig");
const list_model_invocation_jobs = @import("list_model_invocation_jobs.zig");
const list_prompt_routers = @import("list_prompt_routers.zig");
const list_provisioned_model_throughputs = @import("list_provisioned_model_throughputs.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_enforced_guardrail_configuration = @import("put_enforced_guardrail_configuration.zig");
const put_model_invocation_logging_configuration = @import("put_model_invocation_logging_configuration.zig");
const put_use_case_for_model_access = @import("put_use_case_for_model_access.zig");
const register_marketplace_model_endpoint = @import("register_marketplace_model_endpoint.zig");
const start_automated_reasoning_policy_build_workflow = @import("start_automated_reasoning_policy_build_workflow.zig");
const start_automated_reasoning_policy_test_workflow = @import("start_automated_reasoning_policy_test_workflow.zig");
const stop_evaluation_job = @import("stop_evaluation_job.zig");
const stop_model_customization_job = @import("stop_model_customization_job.zig");
const stop_model_invocation_job = @import("stop_model_invocation_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_automated_reasoning_policy = @import("update_automated_reasoning_policy.zig");
const update_automated_reasoning_policy_annotations = @import("update_automated_reasoning_policy_annotations.zig");
const update_automated_reasoning_policy_test_case = @import("update_automated_reasoning_policy_test_case.zig");
const update_custom_model_deployment = @import("update_custom_model_deployment.zig");
const update_guardrail = @import("update_guardrail.zig");
const update_marketplace_model_endpoint = @import("update_marketplace_model_endpoint.zig");
const update_provisioned_model_throughput = @import("update_provisioned_model_throughput.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Bedrock";

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

    /// Deletes a batch of evaluation jobs. An evaluation job can only be deleted if
    /// it has following status `FAILED`, `COMPLETED`, and `STOPPED`. You can
    /// request up to 25 model evaluation jobs be deleted in a single request.
    pub fn batchDeleteEvaluationJob(self: *Self, allocator: std.mem.Allocator, input: batch_delete_evaluation_job.BatchDeleteEvaluationJobInput, options: CallOptions) !batch_delete_evaluation_job.BatchDeleteEvaluationJobOutput {
        return batch_delete_evaluation_job.execute(self, allocator, input, options);
    }

    /// Cancels a running Automated Reasoning policy build workflow. This stops the
    /// policy generation process and prevents further processing of the source
    /// documents.
    pub fn cancelAutomatedReasoningPolicyBuildWorkflow(self: *Self, allocator: std.mem.Allocator, input: cancel_automated_reasoning_policy_build_workflow.CancelAutomatedReasoningPolicyBuildWorkflowInput, options: CallOptions) !cancel_automated_reasoning_policy_build_workflow.CancelAutomatedReasoningPolicyBuildWorkflowOutput {
        return cancel_automated_reasoning_policy_build_workflow.execute(self, allocator, input, options);
    }

    /// Creates an Automated Reasoning policy for Amazon Bedrock Guardrails.
    /// Automated Reasoning policies use mathematical techniques to detect
    /// hallucinations, suggest corrections, and highlight unstated assumptions in
    /// the responses of your GenAI application.
    ///
    /// To create a policy, you upload a source document that describes the rules
    /// that you're encoding. Automated Reasoning extracts important concepts from
    /// the source document that will become variables in the policy and infers
    /// policy rules.
    pub fn createAutomatedReasoningPolicy(self: *Self, allocator: std.mem.Allocator, input: create_automated_reasoning_policy.CreateAutomatedReasoningPolicyInput, options: CallOptions) !create_automated_reasoning_policy.CreateAutomatedReasoningPolicyOutput {
        return create_automated_reasoning_policy.execute(self, allocator, input, options);
    }

    /// Creates a test for an Automated Reasoning policy. Tests validate that your
    /// policy works as expected by providing sample inputs and expected outcomes.
    /// Use tests to verify policy behavior before deploying to production.
    pub fn createAutomatedReasoningPolicyTestCase(self: *Self, allocator: std.mem.Allocator, input: create_automated_reasoning_policy_test_case.CreateAutomatedReasoningPolicyTestCaseInput, options: CallOptions) !create_automated_reasoning_policy_test_case.CreateAutomatedReasoningPolicyTestCaseOutput {
        return create_automated_reasoning_policy_test_case.execute(self, allocator, input, options);
    }

    /// Creates a new version of an existing Automated Reasoning policy. This allows
    /// you to iterate on your policy rules while maintaining previous versions for
    /// rollback or comparison purposes.
    pub fn createAutomatedReasoningPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: create_automated_reasoning_policy_version.CreateAutomatedReasoningPolicyVersionInput, options: CallOptions) !create_automated_reasoning_policy_version.CreateAutomatedReasoningPolicyVersionOutput {
        return create_automated_reasoning_policy_version.execute(self, allocator, input, options);
    }

    /// Creates a new custom model in Amazon Bedrock. After the model is active, you
    /// can use it for inference.
    ///
    /// To use the model for inference, you must purchase Provisioned Throughput for
    /// it. You can't use On-demand inference with these custom models. For more
    /// information about Provisioned Throughput, see [Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html).
    ///
    /// The model appears in `ListCustomModels` with a `customizationType` of
    /// `imported`. To track the status of the new model, you use the
    /// `GetCustomModel` API operation. The model can be in the following states:
    ///
    /// * `Creating` - Initial state during validation and registration
    /// * `Active` - Model is ready for use in inference
    /// * `Failed` - Creation process encountered an error
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [GetCustomModel](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetCustomModel.html)
    /// *
    ///   [ListCustomModels](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListCustomModels.html)
    /// *
    ///   [DeleteCustomModel](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_DeleteCustomModel.html)
    pub fn createCustomModel(self: *Self, allocator: std.mem.Allocator, input: create_custom_model.CreateCustomModelInput, options: CallOptions) !create_custom_model.CreateCustomModelOutput {
        return create_custom_model.execute(self, allocator, input, options);
    }

    /// Deploys a custom model for on-demand inference in Amazon Bedrock. After you
    /// deploy your custom model, you use the deployment's Amazon Resource Name
    /// (ARN) as the `modelId` parameter when you submit prompts and generate
    /// responses with model inference.
    ///
    /// For more information about setting up on-demand inference for custom models,
    /// see [Set up inference for a custom
    /// model](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-use.html).
    ///
    /// The following actions are related to the `CreateCustomModelDeployment`
    /// operation:
    ///
    /// *
    ///   [GetCustomModelDeployment](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetCustomModelDeployment.html)
    /// *
    ///   [ListCustomModelDeployments](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListCustomModelDeployments.html)
    /// *
    ///   [DeleteCustomModelDeployment](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_DeleteCustomModelDeployment.html)
    pub fn createCustomModelDeployment(self: *Self, allocator: std.mem.Allocator, input: create_custom_model_deployment.CreateCustomModelDeploymentInput, options: CallOptions) !create_custom_model_deployment.CreateCustomModelDeploymentOutput {
        return create_custom_model_deployment.execute(self, allocator, input, options);
    }

    /// Creates an evaluation job.
    pub fn createEvaluationJob(self: *Self, allocator: std.mem.Allocator, input: create_evaluation_job.CreateEvaluationJobInput, options: CallOptions) !create_evaluation_job.CreateEvaluationJobOutput {
        return create_evaluation_job.execute(self, allocator, input, options);
    }

    /// Request a model access agreement for the specified model.
    pub fn createFoundationModelAgreement(self: *Self, allocator: std.mem.Allocator, input: create_foundation_model_agreement.CreateFoundationModelAgreementInput, options: CallOptions) !create_foundation_model_agreement.CreateFoundationModelAgreementOutput {
        return create_foundation_model_agreement.execute(self, allocator, input, options);
    }

    /// Creates a guardrail to block topics and to implement safeguards for your
    /// generative AI applications.
    ///
    /// You can configure the following policies in a guardrail to avoid undesirable
    /// and harmful content, filter out denied topics and words, and remove
    /// sensitive information for privacy protection.
    ///
    /// * **Content filters** - Adjust filter strengths to block input prompts or
    ///   model responses containing harmful content.
    /// * **Denied topics** - Define a set of topics that are undesirable in the
    ///   context of your application. These topics will be blocked if detected in
    ///   user queries or model responses.
    /// * **Word filters** - Configure filters to block undesirable words, phrases,
    ///   and profanity. Such words can include offensive terms, competitor names
    ///   etc.
    /// * **Sensitive information filters** - Block or mask sensitive information
    ///   such as personally identifiable information (PII) or custom regex in user
    ///   inputs and model responses.
    ///
    /// In addition to the above policies, you can also configure the messages to be
    /// returned to the user if a user input or model response is in violation of
    /// the policies defined in the guardrail.
    ///
    /// For more information, see [Amazon Bedrock
    /// Guardrails](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails.html) in the *Amazon Bedrock User Guide*.
    pub fn createGuardrail(self: *Self, allocator: std.mem.Allocator, input: create_guardrail.CreateGuardrailInput, options: CallOptions) !create_guardrail.CreateGuardrailOutput {
        return create_guardrail.execute(self, allocator, input, options);
    }

    /// Creates a version of the guardrail. Use this API to create a snapshot of the
    /// guardrail when you are satisfied with a configuration, or to compare the
    /// configuration with another version.
    pub fn createGuardrailVersion(self: *Self, allocator: std.mem.Allocator, input: create_guardrail_version.CreateGuardrailVersionInput, options: CallOptions) !create_guardrail_version.CreateGuardrailVersionOutput {
        return create_guardrail_version.execute(self, allocator, input, options);
    }

    /// Creates an application inference profile to track metrics and costs when
    /// invoking a model. To create an application inference profile for a
    /// foundation model in one region, specify the ARN of the model in that region.
    /// To create an application inference profile for a foundation model across
    /// multiple regions, specify the ARN of the system-defined inference profile
    /// that contains the regions that you want to route requests to. For more
    /// information, see [Increase throughput and resilience with cross-region
    /// inference in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html). in the Amazon Bedrock User Guide.
    pub fn createInferenceProfile(self: *Self, allocator: std.mem.Allocator, input: create_inference_profile.CreateInferenceProfileInput, options: CallOptions) !create_inference_profile.CreateInferenceProfileOutput {
        return create_inference_profile.execute(self, allocator, input, options);
    }

    /// Creates an endpoint for a model from Amazon Bedrock Marketplace. The
    /// endpoint is hosted by Amazon SageMaker.
    pub fn createMarketplaceModelEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_marketplace_model_endpoint.CreateMarketplaceModelEndpointInput, options: CallOptions) !create_marketplace_model_endpoint.CreateMarketplaceModelEndpointOutput {
        return create_marketplace_model_endpoint.execute(self, allocator, input, options);
    }

    /// Copies a model to another region so that it can be used there. For more
    /// information, see [Copy models to be used in other
    /// regions](https://docs.aws.amazon.com/bedrock/latest/userguide/copy-model.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn createModelCopyJob(self: *Self, allocator: std.mem.Allocator, input: create_model_copy_job.CreateModelCopyJobInput, options: CallOptions) !create_model_copy_job.CreateModelCopyJobOutput {
        return create_model_copy_job.execute(self, allocator, input, options);
    }

    /// Creates a fine-tuning job to customize a base model.
    ///
    /// You specify the base foundation model and the location of the training data.
    /// After the model-customization job completes successfully, your custom model
    /// resource will be ready to use. Amazon Bedrock returns validation loss
    /// metrics and output generations after the job completes.
    ///
    /// For information on the format of training and validation data, see [Prepare
    /// the
    /// datasets](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-prepare.html).
    ///
    /// Model-customization jobs are asynchronous and the completion time depends on
    /// the base model and the training/validation data size. To monitor a job, use
    /// the `GetModelCustomizationJob` operation to retrieve the job status.
    ///
    /// For more information, see [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn createModelCustomizationJob(self: *Self, allocator: std.mem.Allocator, input: create_model_customization_job.CreateModelCustomizationJobInput, options: CallOptions) !create_model_customization_job.CreateModelCustomizationJobOutput {
        return create_model_customization_job.execute(self, allocator, input, options);
    }

    /// Creates a model import job to import model that you have customized in other
    /// environments, such as Amazon SageMaker. For more information, see [Import a
    /// customized
    /// model](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-import-model.html)
    pub fn createModelImportJob(self: *Self, allocator: std.mem.Allocator, input: create_model_import_job.CreateModelImportJobInput, options: CallOptions) !create_model_import_job.CreateModelImportJobOutput {
        return create_model_import_job.execute(self, allocator, input, options);
    }

    /// Creates a batch inference job to invoke a model on multiple prompts. Format
    /// your data according to [Format your inference
    /// data](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-data) and upload it to an Amazon S3 bucket. For more information, see [Process multiple prompts with batch inference](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference.html).
    ///
    /// The response returns a `jobArn` that you can use to stop or get details
    /// about the job.
    pub fn createModelInvocationJob(self: *Self, allocator: std.mem.Allocator, input: create_model_invocation_job.CreateModelInvocationJobInput, options: CallOptions) !create_model_invocation_job.CreateModelInvocationJobOutput {
        return create_model_invocation_job.execute(self, allocator, input, options);
    }

    /// Creates a prompt router that manages the routing of requests between
    /// multiple foundation models based on the routing criteria.
    pub fn createPromptRouter(self: *Self, allocator: std.mem.Allocator, input: create_prompt_router.CreatePromptRouterInput, options: CallOptions) !create_prompt_router.CreatePromptRouterOutput {
        return create_prompt_router.execute(self, allocator, input, options);
    }

    /// Creates dedicated throughput for a base or custom model with the model units
    /// and for the duration that you specify. For pricing details, see [Amazon
    /// Bedrock Pricing](http://aws.amazon.com/bedrock/pricing/). For more
    /// information, see [Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn createProvisionedModelThroughput(self: *Self, allocator: std.mem.Allocator, input: create_provisioned_model_throughput.CreateProvisionedModelThroughputInput, options: CallOptions) !create_provisioned_model_throughput.CreateProvisionedModelThroughputOutput {
        return create_provisioned_model_throughput.execute(self, allocator, input, options);
    }

    /// Deletes an Automated Reasoning policy or policy version. This operation is
    /// idempotent. If you delete a policy more than once, each call succeeds.
    /// Deleting a policy removes it permanently and cannot be undone.
    pub fn deleteAutomatedReasoningPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_automated_reasoning_policy.DeleteAutomatedReasoningPolicyInput, options: CallOptions) !delete_automated_reasoning_policy.DeleteAutomatedReasoningPolicyOutput {
        return delete_automated_reasoning_policy.execute(self, allocator, input, options);
    }

    /// Deletes an Automated Reasoning policy build workflow and its associated
    /// artifacts. This permanently removes the workflow history and any generated
    /// assets.
    pub fn deleteAutomatedReasoningPolicyBuildWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_automated_reasoning_policy_build_workflow.DeleteAutomatedReasoningPolicyBuildWorkflowInput, options: CallOptions) !delete_automated_reasoning_policy_build_workflow.DeleteAutomatedReasoningPolicyBuildWorkflowOutput {
        return delete_automated_reasoning_policy_build_workflow.execute(self, allocator, input, options);
    }

    /// Deletes an Automated Reasoning policy test. This operation is idempotent; if
    /// you delete a test more than once, each call succeeds.
    pub fn deleteAutomatedReasoningPolicyTestCase(self: *Self, allocator: std.mem.Allocator, input: delete_automated_reasoning_policy_test_case.DeleteAutomatedReasoningPolicyTestCaseInput, options: CallOptions) !delete_automated_reasoning_policy_test_case.DeleteAutomatedReasoningPolicyTestCaseOutput {
        return delete_automated_reasoning_policy_test_case.execute(self, allocator, input, options);
    }

    /// Deletes a custom model that you created earlier. For more information, see
    /// [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn deleteCustomModel(self: *Self, allocator: std.mem.Allocator, input: delete_custom_model.DeleteCustomModelInput, options: CallOptions) !delete_custom_model.DeleteCustomModelOutput {
        return delete_custom_model.execute(self, allocator, input, options);
    }

    /// Deletes a custom model deployment. This operation stops the deployment and
    /// removes it from your account. After deletion, the deployment ARN can no
    /// longer be used for inference requests.
    ///
    /// The following actions are related to the `DeleteCustomModelDeployment`
    /// operation:
    ///
    /// *
    ///   [CreateCustomModelDeployment](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_CreateCustomModelDeployment.html)
    /// *
    ///   [GetCustomModelDeployment](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetCustomModelDeployment.html)
    /// *
    ///   [ListCustomModelDeployments](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListCustomModelDeployments.html)
    pub fn deleteCustomModelDeployment(self: *Self, allocator: std.mem.Allocator, input: delete_custom_model_deployment.DeleteCustomModelDeploymentInput, options: CallOptions) !delete_custom_model_deployment.DeleteCustomModelDeploymentOutput {
        return delete_custom_model_deployment.execute(self, allocator, input, options);
    }

    /// Deletes the account-level enforced guardrail configuration.
    pub fn deleteEnforcedGuardrailConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_enforced_guardrail_configuration.DeleteEnforcedGuardrailConfigurationInput, options: CallOptions) !delete_enforced_guardrail_configuration.DeleteEnforcedGuardrailConfigurationOutput {
        return delete_enforced_guardrail_configuration.execute(self, allocator, input, options);
    }

    /// Delete the model access agreement for the specified model.
    pub fn deleteFoundationModelAgreement(self: *Self, allocator: std.mem.Allocator, input: delete_foundation_model_agreement.DeleteFoundationModelAgreementInput, options: CallOptions) !delete_foundation_model_agreement.DeleteFoundationModelAgreementOutput {
        return delete_foundation_model_agreement.execute(self, allocator, input, options);
    }

    /// Deletes a guardrail.
    ///
    /// * To delete a guardrail, only specify the ARN of the guardrail in the
    ///   `guardrailIdentifier` field. If you delete a guardrail, all of its
    ///   versions will be deleted.
    /// * To delete a version of a guardrail, specify the ARN of the guardrail in
    ///   the `guardrailIdentifier` field and the version in the `guardrailVersion`
    ///   field.
    pub fn deleteGuardrail(self: *Self, allocator: std.mem.Allocator, input: delete_guardrail.DeleteGuardrailInput, options: CallOptions) !delete_guardrail.DeleteGuardrailOutput {
        return delete_guardrail.execute(self, allocator, input, options);
    }

    /// Deletes a custom model that you imported earlier. For more information, see
    /// [Import a customized
    /// model](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-import-model.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn deleteImportedModel(self: *Self, allocator: std.mem.Allocator, input: delete_imported_model.DeleteImportedModelInput, options: CallOptions) !delete_imported_model.DeleteImportedModelOutput {
        return delete_imported_model.execute(self, allocator, input, options);
    }

    /// Deletes an application inference profile. For more information, see
    /// [Increase throughput and resilience with cross-region inference in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html). in the Amazon Bedrock User Guide.
    pub fn deleteInferenceProfile(self: *Self, allocator: std.mem.Allocator, input: delete_inference_profile.DeleteInferenceProfileInput, options: CallOptions) !delete_inference_profile.DeleteInferenceProfileOutput {
        return delete_inference_profile.execute(self, allocator, input, options);
    }

    /// Deletes an endpoint for a model from Amazon Bedrock Marketplace.
    pub fn deleteMarketplaceModelEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_marketplace_model_endpoint.DeleteMarketplaceModelEndpointInput, options: CallOptions) !delete_marketplace_model_endpoint.DeleteMarketplaceModelEndpointOutput {
        return delete_marketplace_model_endpoint.execute(self, allocator, input, options);
    }

    /// Delete the invocation logging.
    pub fn deleteModelInvocationLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_model_invocation_logging_configuration.DeleteModelInvocationLoggingConfigurationInput, options: CallOptions) !delete_model_invocation_logging_configuration.DeleteModelInvocationLoggingConfigurationOutput {
        return delete_model_invocation_logging_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a specified prompt router. This action cannot be undone.
    pub fn deletePromptRouter(self: *Self, allocator: std.mem.Allocator, input: delete_prompt_router.DeletePromptRouterInput, options: CallOptions) !delete_prompt_router.DeletePromptRouterOutput {
        return delete_prompt_router.execute(self, allocator, input, options);
    }

    /// Deletes a Provisioned Throughput. You can't delete a Provisioned Throughput
    /// before the commitment term is over. For more information, see [Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn deleteProvisionedModelThroughput(self: *Self, allocator: std.mem.Allocator, input: delete_provisioned_model_throughput.DeleteProvisionedModelThroughputInput, options: CallOptions) !delete_provisioned_model_throughput.DeleteProvisionedModelThroughputOutput {
        return delete_provisioned_model_throughput.execute(self, allocator, input, options);
    }

    /// Deregisters an endpoint for a model from Amazon Bedrock Marketplace. This
    /// operation removes the endpoint's association with Amazon Bedrock but does
    /// not delete the underlying Amazon SageMaker endpoint.
    pub fn deregisterMarketplaceModelEndpoint(self: *Self, allocator: std.mem.Allocator, input: deregister_marketplace_model_endpoint.DeregisterMarketplaceModelEndpointInput, options: CallOptions) !deregister_marketplace_model_endpoint.DeregisterMarketplaceModelEndpointOutput {
        return deregister_marketplace_model_endpoint.execute(self, allocator, input, options);
    }

    /// Exports the policy definition for an Automated Reasoning policy version.
    /// Returns the complete policy definition including rules, variables, and
    /// custom variable types in a structured format.
    pub fn exportAutomatedReasoningPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: export_automated_reasoning_policy_version.ExportAutomatedReasoningPolicyVersionInput, options: CallOptions) !export_automated_reasoning_policy_version.ExportAutomatedReasoningPolicyVersionOutput {
        return export_automated_reasoning_policy_version.execute(self, allocator, input, options);
    }

    /// Retrieves details about an Automated Reasoning policy or policy version.
    /// Returns information including the policy definition, metadata, and
    /// timestamps.
    pub fn getAutomatedReasoningPolicy(self: *Self, allocator: std.mem.Allocator, input: get_automated_reasoning_policy.GetAutomatedReasoningPolicyInput, options: CallOptions) !get_automated_reasoning_policy.GetAutomatedReasoningPolicyOutput {
        return get_automated_reasoning_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the current annotations for an Automated Reasoning policy build
    /// workflow. Annotations contain corrections to the rules, variables and types
    /// to be applied to the policy.
    pub fn getAutomatedReasoningPolicyAnnotations(self: *Self, allocator: std.mem.Allocator, input: get_automated_reasoning_policy_annotations.GetAutomatedReasoningPolicyAnnotationsInput, options: CallOptions) !get_automated_reasoning_policy_annotations.GetAutomatedReasoningPolicyAnnotationsOutput {
        return get_automated_reasoning_policy_annotations.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about an Automated Reasoning policy build
    /// workflow, including its status, configuration, and metadata.
    pub fn getAutomatedReasoningPolicyBuildWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_automated_reasoning_policy_build_workflow.GetAutomatedReasoningPolicyBuildWorkflowInput, options: CallOptions) !get_automated_reasoning_policy_build_workflow.GetAutomatedReasoningPolicyBuildWorkflowOutput {
        return get_automated_reasoning_policy_build_workflow.execute(self, allocator, input, options);
    }

    /// Retrieves the resulting assets from a completed Automated Reasoning policy
    /// build workflow, including build logs, quality reports, and generated policy
    /// artifacts.
    pub fn getAutomatedReasoningPolicyBuildWorkflowResultAssets(self: *Self, allocator: std.mem.Allocator, input: get_automated_reasoning_policy_build_workflow_result_assets.GetAutomatedReasoningPolicyBuildWorkflowResultAssetsInput, options: CallOptions) !get_automated_reasoning_policy_build_workflow_result_assets.GetAutomatedReasoningPolicyBuildWorkflowResultAssetsOutput {
        return get_automated_reasoning_policy_build_workflow_result_assets.execute(self, allocator, input, options);
    }

    /// Retrieves the next test scenario for validating an Automated Reasoning
    /// policy. This is used during the interactive policy refinement process to
    /// test policy behavior.
    pub fn getAutomatedReasoningPolicyNextScenario(self: *Self, allocator: std.mem.Allocator, input: get_automated_reasoning_policy_next_scenario.GetAutomatedReasoningPolicyNextScenarioInput, options: CallOptions) !get_automated_reasoning_policy_next_scenario.GetAutomatedReasoningPolicyNextScenarioOutput {
        return get_automated_reasoning_policy_next_scenario.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific Automated Reasoning policy test.
    pub fn getAutomatedReasoningPolicyTestCase(self: *Self, allocator: std.mem.Allocator, input: get_automated_reasoning_policy_test_case.GetAutomatedReasoningPolicyTestCaseInput, options: CallOptions) !get_automated_reasoning_policy_test_case.GetAutomatedReasoningPolicyTestCaseOutput {
        return get_automated_reasoning_policy_test_case.execute(self, allocator, input, options);
    }

    /// Retrieves the test result for a specific Automated Reasoning policy test.
    /// Returns detailed validation findings and execution status.
    pub fn getAutomatedReasoningPolicyTestResult(self: *Self, allocator: std.mem.Allocator, input: get_automated_reasoning_policy_test_result.GetAutomatedReasoningPolicyTestResultInput, options: CallOptions) !get_automated_reasoning_policy_test_result.GetAutomatedReasoningPolicyTestResultOutput {
        return get_automated_reasoning_policy_test_result.execute(self, allocator, input, options);
    }

    /// Get the properties associated with a Amazon Bedrock custom model that you
    /// have created. For more information, see [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn getCustomModel(self: *Self, allocator: std.mem.Allocator, input: get_custom_model.GetCustomModelInput, options: CallOptions) !get_custom_model.GetCustomModelOutput {
        return get_custom_model.execute(self, allocator, input, options);
    }

    /// Retrieves information about a custom model deployment, including its status,
    /// configuration, and metadata. Use this operation to monitor the deployment
    /// status and retrieve details needed for inference requests.
    ///
    /// The following actions are related to the `GetCustomModelDeployment`
    /// operation:
    ///
    /// *
    ///   [CreateCustomModelDeployment](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_CreateCustomModelDeployment.html)
    /// *
    ///   [ListCustomModelDeployments](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListCustomModelDeployments.html)
    /// *
    ///   [DeleteCustomModelDeployment](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_DeleteCustomModelDeployment.html)
    pub fn getCustomModelDeployment(self: *Self, allocator: std.mem.Allocator, input: get_custom_model_deployment.GetCustomModelDeploymentInput, options: CallOptions) !get_custom_model_deployment.GetCustomModelDeploymentOutput {
        return get_custom_model_deployment.execute(self, allocator, input, options);
    }

    /// Gets information about an evaluation job, such as the status of the job.
    pub fn getEvaluationJob(self: *Self, allocator: std.mem.Allocator, input: get_evaluation_job.GetEvaluationJobInput, options: CallOptions) !get_evaluation_job.GetEvaluationJobOutput {
        return get_evaluation_job.execute(self, allocator, input, options);
    }

    /// Get details about a Amazon Bedrock foundation model.
    pub fn getFoundationModel(self: *Self, allocator: std.mem.Allocator, input: get_foundation_model.GetFoundationModelInput, options: CallOptions) !get_foundation_model.GetFoundationModelOutput {
        return get_foundation_model.execute(self, allocator, input, options);
    }

    /// Get information about the Foundation model availability.
    pub fn getFoundationModelAvailability(self: *Self, allocator: std.mem.Allocator, input: get_foundation_model_availability.GetFoundationModelAvailabilityInput, options: CallOptions) !get_foundation_model_availability.GetFoundationModelAvailabilityOutput {
        return get_foundation_model_availability.execute(self, allocator, input, options);
    }

    /// Gets details about a guardrail. If you don't specify a version, the response
    /// returns details for the `DRAFT` version.
    pub fn getGuardrail(self: *Self, allocator: std.mem.Allocator, input: get_guardrail.GetGuardrailInput, options: CallOptions) !get_guardrail.GetGuardrailOutput {
        return get_guardrail.execute(self, allocator, input, options);
    }

    /// Gets properties associated with a customized model you imported.
    pub fn getImportedModel(self: *Self, allocator: std.mem.Allocator, input: get_imported_model.GetImportedModelInput, options: CallOptions) !get_imported_model.GetImportedModelOutput {
        return get_imported_model.execute(self, allocator, input, options);
    }

    /// Gets information about an inference profile. For more information, see
    /// [Increase throughput and resilience with cross-region inference in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html). in the Amazon Bedrock User Guide.
    pub fn getInferenceProfile(self: *Self, allocator: std.mem.Allocator, input: get_inference_profile.GetInferenceProfileInput, options: CallOptions) !get_inference_profile.GetInferenceProfileOutput {
        return get_inference_profile.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific endpoint for a model from Amazon Bedrock
    /// Marketplace.
    pub fn getMarketplaceModelEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_marketplace_model_endpoint.GetMarketplaceModelEndpointInput, options: CallOptions) !get_marketplace_model_endpoint.GetMarketplaceModelEndpointOutput {
        return get_marketplace_model_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves information about a model copy job. For more information, see
    /// [Copy models to be used in other
    /// regions](https://docs.aws.amazon.com/bedrock/latest/userguide/copy-model.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn getModelCopyJob(self: *Self, allocator: std.mem.Allocator, input: get_model_copy_job.GetModelCopyJobInput, options: CallOptions) !get_model_copy_job.GetModelCopyJobOutput {
        return get_model_copy_job.execute(self, allocator, input, options);
    }

    /// Retrieves the properties associated with a model-customization job,
    /// including the status of the job. For more information, see [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn getModelCustomizationJob(self: *Self, allocator: std.mem.Allocator, input: get_model_customization_job.GetModelCustomizationJobInput, options: CallOptions) !get_model_customization_job.GetModelCustomizationJobOutput {
        return get_model_customization_job.execute(self, allocator, input, options);
    }

    /// Retrieves the properties associated with import model job, including the
    /// status of the job. For more information, see [Import a customized
    /// model](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-import-model.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn getModelImportJob(self: *Self, allocator: std.mem.Allocator, input: get_model_import_job.GetModelImportJobInput, options: CallOptions) !get_model_import_job.GetModelImportJobOutput {
        return get_model_import_job.execute(self, allocator, input, options);
    }

    /// Gets details about a batch inference job. For more information, see [Monitor
    /// batch inference
    /// jobs](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-monitor)
    pub fn getModelInvocationJob(self: *Self, allocator: std.mem.Allocator, input: get_model_invocation_job.GetModelInvocationJobInput, options: CallOptions) !get_model_invocation_job.GetModelInvocationJobOutput {
        return get_model_invocation_job.execute(self, allocator, input, options);
    }

    /// Get the current configuration values for model invocation logging.
    pub fn getModelInvocationLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_model_invocation_logging_configuration.GetModelInvocationLoggingConfigurationInput, options: CallOptions) !get_model_invocation_logging_configuration.GetModelInvocationLoggingConfigurationOutput {
        return get_model_invocation_logging_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves details about a prompt router.
    pub fn getPromptRouter(self: *Self, allocator: std.mem.Allocator, input: get_prompt_router.GetPromptRouterInput, options: CallOptions) !get_prompt_router.GetPromptRouterOutput {
        return get_prompt_router.execute(self, allocator, input, options);
    }

    /// Returns details for a Provisioned Throughput. For more information, see
    /// [Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn getProvisionedModelThroughput(self: *Self, allocator: std.mem.Allocator, input: get_provisioned_model_throughput.GetProvisionedModelThroughputInput, options: CallOptions) !get_provisioned_model_throughput.GetProvisionedModelThroughputOutput {
        return get_provisioned_model_throughput.execute(self, allocator, input, options);
    }

    /// Get usecase for model access.
    pub fn getUseCaseForModelAccess(self: *Self, allocator: std.mem.Allocator, input: get_use_case_for_model_access.GetUseCaseForModelAccessInput, options: CallOptions) !get_use_case_for_model_access.GetUseCaseForModelAccessOutput {
        return get_use_case_for_model_access.execute(self, allocator, input, options);
    }

    /// Lists all Automated Reasoning policies in your account, with optional
    /// filtering by policy ARN. This helps you manage and discover existing
    /// policies.
    pub fn listAutomatedReasoningPolicies(self: *Self, allocator: std.mem.Allocator, input: list_automated_reasoning_policies.ListAutomatedReasoningPoliciesInput, options: CallOptions) !list_automated_reasoning_policies.ListAutomatedReasoningPoliciesOutput {
        return list_automated_reasoning_policies.execute(self, allocator, input, options);
    }

    /// Lists all build workflows for an Automated Reasoning policy, showing the
    /// history of policy creation and modification attempts.
    pub fn listAutomatedReasoningPolicyBuildWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_automated_reasoning_policy_build_workflows.ListAutomatedReasoningPolicyBuildWorkflowsInput, options: CallOptions) !list_automated_reasoning_policy_build_workflows.ListAutomatedReasoningPolicyBuildWorkflowsOutput {
        return list_automated_reasoning_policy_build_workflows.execute(self, allocator, input, options);
    }

    /// Lists tests for an Automated Reasoning policy. We recommend using pagination
    /// to ensure that the operation returns quickly and successfully.
    pub fn listAutomatedReasoningPolicyTestCases(self: *Self, allocator: std.mem.Allocator, input: list_automated_reasoning_policy_test_cases.ListAutomatedReasoningPolicyTestCasesInput, options: CallOptions) !list_automated_reasoning_policy_test_cases.ListAutomatedReasoningPolicyTestCasesOutput {
        return list_automated_reasoning_policy_test_cases.execute(self, allocator, input, options);
    }

    /// Lists test results for an Automated Reasoning policy, showing how the policy
    /// performed against various test scenarios and validation checks.
    pub fn listAutomatedReasoningPolicyTestResults(self: *Self, allocator: std.mem.Allocator, input: list_automated_reasoning_policy_test_results.ListAutomatedReasoningPolicyTestResultsInput, options: CallOptions) !list_automated_reasoning_policy_test_results.ListAutomatedReasoningPolicyTestResultsOutput {
        return list_automated_reasoning_policy_test_results.execute(self, allocator, input, options);
    }

    /// Lists custom model deployments in your account. You can filter the results
    /// by creation time, name, status, and associated model. Use this operation to
    /// manage and monitor your custom model deployments.
    ///
    /// We recommend using pagination to ensure that the operation returns quickly
    /// and successfully.
    ///
    /// The following actions are related to the `ListCustomModelDeployments`
    /// operation:
    ///
    /// *
    ///   [CreateCustomModelDeployment](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_CreateCustomModelDeployment.html)
    /// *
    ///   [GetCustomModelDeployment](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetCustomModelDeployment.html)
    /// *
    ///   [DeleteCustomModelDeployment](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_DeleteCustomModelDeployment.html)
    pub fn listCustomModelDeployments(self: *Self, allocator: std.mem.Allocator, input: list_custom_model_deployments.ListCustomModelDeploymentsInput, options: CallOptions) !list_custom_model_deployments.ListCustomModelDeploymentsOutput {
        return list_custom_model_deployments.execute(self, allocator, input, options);
    }

    /// Returns a list of the custom models that you have created with the
    /// `CreateModelCustomizationJob` operation.
    ///
    /// For more information, see [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn listCustomModels(self: *Self, allocator: std.mem.Allocator, input: list_custom_models.ListCustomModelsInput, options: CallOptions) !list_custom_models.ListCustomModelsOutput {
        return list_custom_models.execute(self, allocator, input, options);
    }

    /// Lists the account-level enforced guardrail configurations.
    pub fn listEnforcedGuardrailsConfiguration(self: *Self, allocator: std.mem.Allocator, input: list_enforced_guardrails_configuration.ListEnforcedGuardrailsConfigurationInput, options: CallOptions) !list_enforced_guardrails_configuration.ListEnforcedGuardrailsConfigurationOutput {
        return list_enforced_guardrails_configuration.execute(self, allocator, input, options);
    }

    /// Lists all existing evaluation jobs.
    pub fn listEvaluationJobs(self: *Self, allocator: std.mem.Allocator, input: list_evaluation_jobs.ListEvaluationJobsInput, options: CallOptions) !list_evaluation_jobs.ListEvaluationJobsOutput {
        return list_evaluation_jobs.execute(self, allocator, input, options);
    }

    /// Get the offers associated with the specified model.
    pub fn listFoundationModelAgreementOffers(self: *Self, allocator: std.mem.Allocator, input: list_foundation_model_agreement_offers.ListFoundationModelAgreementOffersInput, options: CallOptions) !list_foundation_model_agreement_offers.ListFoundationModelAgreementOffersOutput {
        return list_foundation_model_agreement_offers.execute(self, allocator, input, options);
    }

    /// Lists Amazon Bedrock foundation models that you can use. You can filter the
    /// results with the request parameters. For more information, see [Foundation
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/foundation-models.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn listFoundationModels(self: *Self, allocator: std.mem.Allocator, input: list_foundation_models.ListFoundationModelsInput, options: CallOptions) !list_foundation_models.ListFoundationModelsOutput {
        return list_foundation_models.execute(self, allocator, input, options);
    }

    /// Lists details about all the guardrails in an account. To list the `DRAFT`
    /// version of all your guardrails, don't specify the `guardrailIdentifier`
    /// field. To list all versions of a guardrail, specify the ARN of the guardrail
    /// in the `guardrailIdentifier` field.
    ///
    /// You can set the maximum number of results to return in a response in the
    /// `maxResults` field. If there are more results than the number you set, the
    /// response returns a `nextToken` that you can send in another `ListGuardrails`
    /// request to see the next batch of results.
    pub fn listGuardrails(self: *Self, allocator: std.mem.Allocator, input: list_guardrails.ListGuardrailsInput, options: CallOptions) !list_guardrails.ListGuardrailsOutput {
        return list_guardrails.execute(self, allocator, input, options);
    }

    /// Returns a list of models you've imported. You can filter the results to
    /// return based on one or more criteria. For more information, see [Import a
    /// customized
    /// model](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-import-model.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn listImportedModels(self: *Self, allocator: std.mem.Allocator, input: list_imported_models.ListImportedModelsInput, options: CallOptions) !list_imported_models.ListImportedModelsOutput {
        return list_imported_models.execute(self, allocator, input, options);
    }

    /// Returns a list of inference profiles that you can use. For more information,
    /// see [Increase throughput and resilience with cross-region inference in
    /// Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html). in the Amazon Bedrock User Guide.
    pub fn listInferenceProfiles(self: *Self, allocator: std.mem.Allocator, input: list_inference_profiles.ListInferenceProfilesInput, options: CallOptions) !list_inference_profiles.ListInferenceProfilesOutput {
        return list_inference_profiles.execute(self, allocator, input, options);
    }

    /// Lists the endpoints for models from Amazon Bedrock Marketplace in your
    /// Amazon Web Services account.
    pub fn listMarketplaceModelEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_marketplace_model_endpoints.ListMarketplaceModelEndpointsInput, options: CallOptions) !list_marketplace_model_endpoints.ListMarketplaceModelEndpointsOutput {
        return list_marketplace_model_endpoints.execute(self, allocator, input, options);
    }

    /// Returns a list of model copy jobs that you have submitted. You can filter
    /// the jobs to return based on one or more criteria. For more information, see
    /// [Copy models to be used in other
    /// regions](https://docs.aws.amazon.com/bedrock/latest/userguide/copy-model.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn listModelCopyJobs(self: *Self, allocator: std.mem.Allocator, input: list_model_copy_jobs.ListModelCopyJobsInput, options: CallOptions) !list_model_copy_jobs.ListModelCopyJobsOutput {
        return list_model_copy_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of model customization jobs that you have submitted. You can
    /// filter the jobs to return based on one or more criteria.
    ///
    /// For more information, see [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn listModelCustomizationJobs(self: *Self, allocator: std.mem.Allocator, input: list_model_customization_jobs.ListModelCustomizationJobsInput, options: CallOptions) !list_model_customization_jobs.ListModelCustomizationJobsOutput {
        return list_model_customization_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of import jobs you've submitted. You can filter the results
    /// to return based on one or more criteria. For more information, see [Import a
    /// customized
    /// model](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-import-model.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn listModelImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_model_import_jobs.ListModelImportJobsInput, options: CallOptions) !list_model_import_jobs.ListModelImportJobsOutput {
        return list_model_import_jobs.execute(self, allocator, input, options);
    }

    /// Lists all batch inference jobs in the account. For more information, see
    /// [View details about a batch inference
    /// job](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-view.html).
    pub fn listModelInvocationJobs(self: *Self, allocator: std.mem.Allocator, input: list_model_invocation_jobs.ListModelInvocationJobsInput, options: CallOptions) !list_model_invocation_jobs.ListModelInvocationJobsOutput {
        return list_model_invocation_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of prompt routers.
    pub fn listPromptRouters(self: *Self, allocator: std.mem.Allocator, input: list_prompt_routers.ListPromptRoutersInput, options: CallOptions) !list_prompt_routers.ListPromptRoutersOutput {
        return list_prompt_routers.execute(self, allocator, input, options);
    }

    /// Lists the Provisioned Throughputs in the account. For more information, see
    /// [Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn listProvisionedModelThroughputs(self: *Self, allocator: std.mem.Allocator, input: list_provisioned_model_throughputs.ListProvisionedModelThroughputsInput, options: CallOptions) !list_provisioned_model_throughputs.ListProvisionedModelThroughputsOutput {
        return list_provisioned_model_throughputs.execute(self, allocator, input, options);
    }

    /// List the tags associated with the specified resource.
    ///
    /// For more information, see [Tagging
    /// resources](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sets the account-level enforced guardrail configuration.
    pub fn putEnforcedGuardrailConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_enforced_guardrail_configuration.PutEnforcedGuardrailConfigurationInput, options: CallOptions) !put_enforced_guardrail_configuration.PutEnforcedGuardrailConfigurationOutput {
        return put_enforced_guardrail_configuration.execute(self, allocator, input, options);
    }

    /// Set the configuration values for model invocation logging.
    pub fn putModelInvocationLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_model_invocation_logging_configuration.PutModelInvocationLoggingConfigurationInput, options: CallOptions) !put_model_invocation_logging_configuration.PutModelInvocationLoggingConfigurationOutput {
        return put_model_invocation_logging_configuration.execute(self, allocator, input, options);
    }

    /// Put usecase for model access.
    pub fn putUseCaseForModelAccess(self: *Self, allocator: std.mem.Allocator, input: put_use_case_for_model_access.PutUseCaseForModelAccessInput, options: CallOptions) !put_use_case_for_model_access.PutUseCaseForModelAccessOutput {
        return put_use_case_for_model_access.execute(self, allocator, input, options);
    }

    /// Registers an existing Amazon SageMaker endpoint with Amazon Bedrock
    /// Marketplace, allowing it to be used with Amazon Bedrock APIs.
    pub fn registerMarketplaceModelEndpoint(self: *Self, allocator: std.mem.Allocator, input: register_marketplace_model_endpoint.RegisterMarketplaceModelEndpointInput, options: CallOptions) !register_marketplace_model_endpoint.RegisterMarketplaceModelEndpointOutput {
        return register_marketplace_model_endpoint.execute(self, allocator, input, options);
    }

    /// Starts a new build workflow for an Automated Reasoning policy. This
    /// initiates the process of analyzing source documents and generating policy
    /// rules, variables, and types.
    pub fn startAutomatedReasoningPolicyBuildWorkflow(self: *Self, allocator: std.mem.Allocator, input: start_automated_reasoning_policy_build_workflow.StartAutomatedReasoningPolicyBuildWorkflowInput, options: CallOptions) !start_automated_reasoning_policy_build_workflow.StartAutomatedReasoningPolicyBuildWorkflowOutput {
        return start_automated_reasoning_policy_build_workflow.execute(self, allocator, input, options);
    }

    /// Initiates a test workflow to validate Automated Reasoning policy tests. The
    /// workflow executes the specified tests against the policy and generates
    /// validation results.
    pub fn startAutomatedReasoningPolicyTestWorkflow(self: *Self, allocator: std.mem.Allocator, input: start_automated_reasoning_policy_test_workflow.StartAutomatedReasoningPolicyTestWorkflowInput, options: CallOptions) !start_automated_reasoning_policy_test_workflow.StartAutomatedReasoningPolicyTestWorkflowOutput {
        return start_automated_reasoning_policy_test_workflow.execute(self, allocator, input, options);
    }

    /// Stops an evaluation job that is current being created or running.
    pub fn stopEvaluationJob(self: *Self, allocator: std.mem.Allocator, input: stop_evaluation_job.StopEvaluationJobInput, options: CallOptions) !stop_evaluation_job.StopEvaluationJobOutput {
        return stop_evaluation_job.execute(self, allocator, input, options);
    }

    /// Stops an active model customization job. For more information, see [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn stopModelCustomizationJob(self: *Self, allocator: std.mem.Allocator, input: stop_model_customization_job.StopModelCustomizationJobInput, options: CallOptions) !stop_model_customization_job.StopModelCustomizationJobOutput {
        return stop_model_customization_job.execute(self, allocator, input, options);
    }

    /// Stops a batch inference job. You're only charged for tokens that were
    /// already processed. For more information, see [Stop a batch inference
    /// job](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-stop.html).
    pub fn stopModelInvocationJob(self: *Self, allocator: std.mem.Allocator, input: stop_model_invocation_job.StopModelInvocationJobInput, options: CallOptions) !stop_model_invocation_job.StopModelInvocationJobOutput {
        return stop_model_invocation_job.execute(self, allocator, input, options);
    }

    /// Associate tags with a resource. For more information, see [Tagging
    /// resources](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove one or more tags from a resource. For more information, see [Tagging
    /// resources](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Automated Reasoning policy with new rules, variables, or
    /// configuration. This creates a new version of the policy while preserving the
    /// previous version.
    pub fn updateAutomatedReasoningPolicy(self: *Self, allocator: std.mem.Allocator, input: update_automated_reasoning_policy.UpdateAutomatedReasoningPolicyInput, options: CallOptions) !update_automated_reasoning_policy.UpdateAutomatedReasoningPolicyOutput {
        return update_automated_reasoning_policy.execute(self, allocator, input, options);
    }

    /// Updates the annotations for an Automated Reasoning policy build workflow.
    /// This allows you to modify extracted rules, variables, and types before
    /// finalizing the policy.
    pub fn updateAutomatedReasoningPolicyAnnotations(self: *Self, allocator: std.mem.Allocator, input: update_automated_reasoning_policy_annotations.UpdateAutomatedReasoningPolicyAnnotationsInput, options: CallOptions) !update_automated_reasoning_policy_annotations.UpdateAutomatedReasoningPolicyAnnotationsOutput {
        return update_automated_reasoning_policy_annotations.execute(self, allocator, input, options);
    }

    /// Updates an existing Automated Reasoning policy test. You can modify the
    /// content, query, expected result, and confidence threshold.
    pub fn updateAutomatedReasoningPolicyTestCase(self: *Self, allocator: std.mem.Allocator, input: update_automated_reasoning_policy_test_case.UpdateAutomatedReasoningPolicyTestCaseInput, options: CallOptions) !update_automated_reasoning_policy_test_case.UpdateAutomatedReasoningPolicyTestCaseOutput {
        return update_automated_reasoning_policy_test_case.execute(self, allocator, input, options);
    }

    /// Updates a custom model deployment with a new custom model. This allows you
    /// to deploy updated models without creating new deployment endpoints.
    pub fn updateCustomModelDeployment(self: *Self, allocator: std.mem.Allocator, input: update_custom_model_deployment.UpdateCustomModelDeploymentInput, options: CallOptions) !update_custom_model_deployment.UpdateCustomModelDeploymentOutput {
        return update_custom_model_deployment.execute(self, allocator, input, options);
    }

    /// Updates a guardrail with the values you specify.
    ///
    /// * Specify a `name` and optional `description`.
    /// * Specify messages for when the guardrail successfully blocks a prompt or a
    ///   model response in the `blockedInputMessaging` and
    ///   `blockedOutputsMessaging` fields.
    /// * Specify topics for the guardrail to deny in the `topicPolicyConfig`
    ///   object. Each
    ///   [GuardrailTopicConfig](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GuardrailTopicConfig.html) object in the `topicsConfig` list pertains to one topic.
    ///
    /// * Give a `name` and `description` so that the guardrail can properly
    ///   identify the topic.
    /// * Specify `DENY` in the `type` field.
    /// * (Optional) Provide up to five prompts that you would categorize as
    ///   belonging to the topic in the `examples` list.
    ///
    /// * Specify filter strengths for the harmful categories defined in Amazon
    ///   Bedrock in the `contentPolicyConfig` object. Each
    ///   [GuardrailContentFilterConfig](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GuardrailContentFilterConfig.html) object in the `filtersConfig` list pertains to a harmful category. For more information, see [Content filters](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-content-filters). For more information about the fields in a content filter, see [GuardrailContentFilterConfig](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GuardrailContentFilterConfig.html).
    ///
    /// * Specify the category in the `type` field.
    /// * Specify the strength of the filter for prompts in the `inputStrength`
    ///   field and for model responses in the `strength` field of the
    ///   [GuardrailContentFilterConfig](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GuardrailContentFilterConfig.html).
    ///
    /// * (Optional) For security, include the ARN of a KMS key in the `kmsKeyId`
    ///   field.
    pub fn updateGuardrail(self: *Self, allocator: std.mem.Allocator, input: update_guardrail.UpdateGuardrailInput, options: CallOptions) !update_guardrail.UpdateGuardrailOutput {
        return update_guardrail.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing endpoint for a model from Amazon
    /// Bedrock Marketplace.
    pub fn updateMarketplaceModelEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_marketplace_model_endpoint.UpdateMarketplaceModelEndpointInput, options: CallOptions) !update_marketplace_model_endpoint.UpdateMarketplaceModelEndpointOutput {
        return update_marketplace_model_endpoint.execute(self, allocator, input, options);
    }

    /// Updates the name or associated model for a Provisioned Throughput. For more
    /// information, see [Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn updateProvisionedModelThroughput(self: *Self, allocator: std.mem.Allocator, input: update_provisioned_model_throughput.UpdateProvisionedModelThroughputInput, options: CallOptions) !update_provisioned_model_throughput.UpdateProvisionedModelThroughputOutput {
        return update_provisioned_model_throughput.execute(self, allocator, input, options);
    }

    pub fn listAutomatedReasoningPoliciesPaginator(self: *Self, params: list_automated_reasoning_policies.ListAutomatedReasoningPoliciesInput) paginator.ListAutomatedReasoningPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAutomatedReasoningPolicyBuildWorkflowsPaginator(self: *Self, params: list_automated_reasoning_policy_build_workflows.ListAutomatedReasoningPolicyBuildWorkflowsInput) paginator.ListAutomatedReasoningPolicyBuildWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAutomatedReasoningPolicyTestCasesPaginator(self: *Self, params: list_automated_reasoning_policy_test_cases.ListAutomatedReasoningPolicyTestCasesInput) paginator.ListAutomatedReasoningPolicyTestCasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAutomatedReasoningPolicyTestResultsPaginator(self: *Self, params: list_automated_reasoning_policy_test_results.ListAutomatedReasoningPolicyTestResultsInput) paginator.ListAutomatedReasoningPolicyTestResultsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCustomModelDeploymentsPaginator(self: *Self, params: list_custom_model_deployments.ListCustomModelDeploymentsInput) paginator.ListCustomModelDeploymentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCustomModelsPaginator(self: *Self, params: list_custom_models.ListCustomModelsInput) paginator.ListCustomModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnforcedGuardrailsConfigurationPaginator(self: *Self, params: list_enforced_guardrails_configuration.ListEnforcedGuardrailsConfigurationInput) paginator.ListEnforcedGuardrailsConfigurationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEvaluationJobsPaginator(self: *Self, params: list_evaluation_jobs.ListEvaluationJobsInput) paginator.ListEvaluationJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGuardrailsPaginator(self: *Self, params: list_guardrails.ListGuardrailsInput) paginator.ListGuardrailsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImportedModelsPaginator(self: *Self, params: list_imported_models.ListImportedModelsInput) paginator.ListImportedModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listInferenceProfilesPaginator(self: *Self, params: list_inference_profiles.ListInferenceProfilesInput) paginator.ListInferenceProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMarketplaceModelEndpointsPaginator(self: *Self, params: list_marketplace_model_endpoints.ListMarketplaceModelEndpointsInput) paginator.ListMarketplaceModelEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listModelCopyJobsPaginator(self: *Self, params: list_model_copy_jobs.ListModelCopyJobsInput) paginator.ListModelCopyJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listModelCustomizationJobsPaginator(self: *Self, params: list_model_customization_jobs.ListModelCustomizationJobsInput) paginator.ListModelCustomizationJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listModelImportJobsPaginator(self: *Self, params: list_model_import_jobs.ListModelImportJobsInput) paginator.ListModelImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listModelInvocationJobsPaginator(self: *Self, params: list_model_invocation_jobs.ListModelInvocationJobsInput) paginator.ListModelInvocationJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPromptRoutersPaginator(self: *Self, params: list_prompt_routers.ListPromptRoutersInput) paginator.ListPromptRoutersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProvisionedModelThroughputsPaginator(self: *Self, params: list_provisioned_model_throughputs.ListProvisionedModelThroughputsInput) paginator.ListProvisionedModelThroughputsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

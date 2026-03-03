const aws = @import("aws");
const std = @import("std");

const add_layer_version_permission = @import("add_layer_version_permission.zig");
const add_permission = @import("add_permission.zig");
const checkpoint_durable_execution = @import("checkpoint_durable_execution.zig");
const create_alias = @import("create_alias.zig");
const create_capacity_provider = @import("create_capacity_provider.zig");
const create_code_signing_config = @import("create_code_signing_config.zig");
const create_event_source_mapping = @import("create_event_source_mapping.zig");
const create_function = @import("create_function.zig");
const create_function_url_config = @import("create_function_url_config.zig");
const delete_alias = @import("delete_alias.zig");
const delete_capacity_provider = @import("delete_capacity_provider.zig");
const delete_code_signing_config = @import("delete_code_signing_config.zig");
const delete_event_source_mapping = @import("delete_event_source_mapping.zig");
const delete_function = @import("delete_function.zig");
const delete_function_code_signing_config = @import("delete_function_code_signing_config.zig");
const delete_function_concurrency = @import("delete_function_concurrency.zig");
const delete_function_event_invoke_config = @import("delete_function_event_invoke_config.zig");
const delete_function_url_config = @import("delete_function_url_config.zig");
const delete_layer_version = @import("delete_layer_version.zig");
const delete_provisioned_concurrency_config = @import("delete_provisioned_concurrency_config.zig");
const get_account_settings = @import("get_account_settings.zig");
const get_alias = @import("get_alias.zig");
const get_capacity_provider = @import("get_capacity_provider.zig");
const get_code_signing_config = @import("get_code_signing_config.zig");
const get_durable_execution = @import("get_durable_execution.zig");
const get_durable_execution_history = @import("get_durable_execution_history.zig");
const get_durable_execution_state = @import("get_durable_execution_state.zig");
const get_event_source_mapping = @import("get_event_source_mapping.zig");
const get_function = @import("get_function.zig");
const get_function_code_signing_config = @import("get_function_code_signing_config.zig");
const get_function_concurrency = @import("get_function_concurrency.zig");
const get_function_configuration = @import("get_function_configuration.zig");
const get_function_event_invoke_config = @import("get_function_event_invoke_config.zig");
const get_function_recursion_config = @import("get_function_recursion_config.zig");
const get_function_scaling_config = @import("get_function_scaling_config.zig");
const get_function_url_config = @import("get_function_url_config.zig");
const get_layer_version = @import("get_layer_version.zig");
const get_layer_version_by_arn = @import("get_layer_version_by_arn.zig");
const get_layer_version_policy = @import("get_layer_version_policy.zig");
const get_policy = @import("get_policy.zig");
const get_provisioned_concurrency_config = @import("get_provisioned_concurrency_config.zig");
const get_runtime_management_config = @import("get_runtime_management_config.zig");
const invoke_ = @import("invoke.zig");
const invoke_async = @import("invoke_async.zig");
const invoke_with_response_stream = @import("invoke_with_response_stream.zig");
const list_aliases = @import("list_aliases.zig");
const list_capacity_providers = @import("list_capacity_providers.zig");
const list_code_signing_configs = @import("list_code_signing_configs.zig");
const list_durable_executions_by_function = @import("list_durable_executions_by_function.zig");
const list_event_source_mappings = @import("list_event_source_mappings.zig");
const list_function_event_invoke_configs = @import("list_function_event_invoke_configs.zig");
const list_function_url_configs = @import("list_function_url_configs.zig");
const list_function_versions_by_capacity_provider = @import("list_function_versions_by_capacity_provider.zig");
const list_functions = @import("list_functions.zig");
const list_functions_by_code_signing_config = @import("list_functions_by_code_signing_config.zig");
const list_layer_versions = @import("list_layer_versions.zig");
const list_layers = @import("list_layers.zig");
const list_provisioned_concurrency_configs = @import("list_provisioned_concurrency_configs.zig");
const list_tags = @import("list_tags.zig");
const list_versions_by_function = @import("list_versions_by_function.zig");
const publish_layer_version = @import("publish_layer_version.zig");
const publish_version = @import("publish_version.zig");
const put_function_code_signing_config = @import("put_function_code_signing_config.zig");
const put_function_concurrency = @import("put_function_concurrency.zig");
const put_function_event_invoke_config = @import("put_function_event_invoke_config.zig");
const put_function_recursion_config = @import("put_function_recursion_config.zig");
const put_function_scaling_config = @import("put_function_scaling_config.zig");
const put_provisioned_concurrency_config = @import("put_provisioned_concurrency_config.zig");
const put_runtime_management_config = @import("put_runtime_management_config.zig");
const remove_layer_version_permission = @import("remove_layer_version_permission.zig");
const remove_permission = @import("remove_permission.zig");
const send_durable_execution_callback_failure = @import("send_durable_execution_callback_failure.zig");
const send_durable_execution_callback_heartbeat = @import("send_durable_execution_callback_heartbeat.zig");
const send_durable_execution_callback_success = @import("send_durable_execution_callback_success.zig");
const stop_durable_execution = @import("stop_durable_execution.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_alias = @import("update_alias.zig");
const update_capacity_provider = @import("update_capacity_provider.zig");
const update_code_signing_config = @import("update_code_signing_config.zig");
const update_event_source_mapping = @import("update_event_source_mapping.zig");
const update_function_code = @import("update_function_code.zig");
const update_function_configuration = @import("update_function_configuration.zig");
const update_function_event_invoke_config = @import("update_function_event_invoke_config.zig");
const update_function_url_config = @import("update_function_url_config.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Lambda";

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

    /// Adds permissions to the resource-based policy of a version of an [Lambda
    /// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html). Use this action to grant layer usage permission to other accounts. You can grant permission to a single account, all accounts in an organization, or all Amazon Web Services accounts.
    ///
    /// To revoke permission, call RemoveLayerVersionPermission with the statement
    /// ID that you specified when you added it.
    pub fn addLayerVersionPermission(self: *Self, allocator: std.mem.Allocator, input: add_layer_version_permission.AddLayerVersionPermissionInput, options: CallOptions) !add_layer_version_permission.AddLayerVersionPermissionOutput {
        return add_layer_version_permission.execute(self, allocator, input, options);
    }

    /// Grants a
    /// [principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#Principal_specifying) permission to use a function. You can apply the policy at the function level, or specify a qualifier to restrict access to a single version or alias. If you use a qualifier, the invoker must use the full Amazon Resource Name (ARN) of that version or alias to invoke the function. Note: Lambda does not support adding policies to version $LATEST.
    ///
    /// To grant permission to another account, specify the account ID as the
    /// `Principal`. To grant permission to an organization defined in
    /// Organizations, specify the organization ID as the `PrincipalOrgID`. For
    /// Amazon Web Services services, the principal is a domain-style identifier
    /// that the service defines, such as `s3.amazonaws.com` or `sns.amazonaws.com`.
    /// For Amazon Web Services services, you can also specify the ARN of the
    /// associated resource as the `SourceArn`. If you grant permission to a service
    /// principal without specifying the source, other accounts could potentially
    /// configure resources in their account to invoke your Lambda function.
    ///
    /// This operation adds a statement to a resource-based permissions policy for
    /// the function. For more information about function policies, see [Using
    /// resource-based policies for
    /// Lambda](https://docs.aws.amazon.com/lambda/latest/dg/access-control-resource-based.html).
    pub fn addPermission(self: *Self, allocator: std.mem.Allocator, input: add_permission.AddPermissionInput, options: CallOptions) !add_permission.AddPermissionOutput {
        return add_permission.execute(self, allocator, input, options);
    }

    /// Saves the progress of a [durable
    /// function](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html) execution during runtime. This API is used by the Lambda durable functions SDK to checkpoint completed steps and schedule asynchronous operations. You typically don't need to call this API directly as the SDK handles checkpointing automatically.
    ///
    /// Each checkpoint operation consumes the current checkpoint token and returns
    /// a new one for the next checkpoint. This ensures that checkpoints are applied
    /// in the correct order and prevents duplicate or out-of-order state updates.
    pub fn checkpointDurableExecution(self: *Self, allocator: std.mem.Allocator, input: checkpoint_durable_execution.CheckpointDurableExecutionInput, options: CallOptions) !checkpoint_durable_execution.CheckpointDurableExecutionOutput {
        return checkpoint_durable_execution.execute(self, allocator, input, options);
    }

    /// Creates an
    /// [alias](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html) for a Lambda function version. Use aliases to provide clients with a function identifier that you can update to invoke a different version.
    ///
    /// You can also map an alias to split invocation requests between two versions.
    /// Use the `RoutingConfig` parameter to specify a second version and the
    /// percentage of invocation requests that it receives.
    pub fn createAlias(self: *Self, allocator: std.mem.Allocator, input: create_alias.CreateAliasInput, options: CallOptions) !create_alias.CreateAliasOutput {
        return create_alias.execute(self, allocator, input, options);
    }

    /// Creates a capacity provider that manages compute resources for Lambda
    /// functions
    pub fn createCapacityProvider(self: *Self, allocator: std.mem.Allocator, input: create_capacity_provider.CreateCapacityProviderInput, options: CallOptions) !create_capacity_provider.CreateCapacityProviderOutput {
        return create_capacity_provider.execute(self, allocator, input, options);
    }

    /// Creates a code signing configuration. A [code signing
    /// configuration](https://docs.aws.amazon.com/lambda/latest/dg/configuration-codesigning.html) defines a list of allowed signing profiles and defines the code-signing validation policy (action to be taken if deployment validation checks fail).
    pub fn createCodeSigningConfig(self: *Self, allocator: std.mem.Allocator, input: create_code_signing_config.CreateCodeSigningConfigInput, options: CallOptions) !create_code_signing_config.CreateCodeSigningConfigOutput {
        return create_code_signing_config.execute(self, allocator, input, options);
    }

    /// Creates a mapping between an event source and an Lambda function. Lambda
    /// reads items from the event source and invokes the function.
    ///
    /// For details about how to configure different event sources, see the
    /// following topics.
    ///
    /// * [ Amazon DynamoDB
    ///   Streams](https://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html#services-dynamodb-eventsourcemapping)
    /// * [ Amazon
    ///   Kinesis](https://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html#services-kinesis-eventsourcemapping)
    /// * [ Amazon
    ///   SQS](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html#events-sqs-eventsource)
    /// * [ Amazon MQ and
    ///   RabbitMQ](https://docs.aws.amazon.com/lambda/latest/dg/with-mq.html#services-mq-eventsourcemapping)
    /// * [ Amazon MSK](https://docs.aws.amazon.com/lambda/latest/dg/with-msk.html)
    /// * [ Apache
    ///   Kafka](https://docs.aws.amazon.com/lambda/latest/dg/kafka-smaa.html)
    /// * [ Amazon
    ///   DocumentDB](https://docs.aws.amazon.com/lambda/latest/dg/with-documentdb.html)
    ///
    /// The following error handling options are available for stream sources
    /// (DynamoDB, Kinesis, Amazon MSK, and self-managed Apache Kafka):
    ///
    /// * `BisectBatchOnFunctionError` – If the function returns an error, split the
    ///   batch in two and retry.
    /// * `MaximumRecordAgeInSeconds` – Discard records older than the specified
    ///   age. The default value is infinite (-1). When set to infinite (-1), failed
    ///   records are retried until the record expires
    /// * `MaximumRetryAttempts` – Discard records after the specified number of
    ///   retries. The default value is infinite (-1). When set to infinite (-1),
    ///   failed records are retried until the record expires.
    /// * `OnFailure` – Send discarded records to an Amazon SQS queue, Amazon SNS
    ///   topic, Kafka topic, or Amazon S3 bucket. For more information, see [Adding
    ///   a
    ///   destination](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async-retain-records.html#invocation-async-destinations).
    ///
    /// The following option is available only for DynamoDB and Kinesis event
    /// sources:
    ///
    /// * `ParallelizationFactor` – Process multiple batches from each shard
    ///   concurrently.
    ///
    /// For information about which configuration parameters apply to each event
    /// source, see the following topics.
    ///
    /// * [ Amazon DynamoDB
    ///   Streams](https://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html#services-ddb-params)
    /// * [ Amazon
    ///   Kinesis](https://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html#services-kinesis-params)
    /// * [ Amazon
    ///   SQS](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html#services-sqs-params)
    /// * [ Amazon MQ and
    ///   RabbitMQ](https://docs.aws.amazon.com/lambda/latest/dg/with-mq.html#services-mq-params)
    /// * [ Amazon
    ///   MSK](https://docs.aws.amazon.com/lambda/latest/dg/with-msk.html#services-msk-parms)
    /// * [ Apache
    ///   Kafka](https://docs.aws.amazon.com/lambda/latest/dg/with-kafka.html#services-kafka-parms)
    /// * [ Amazon
    ///   DocumentDB](https://docs.aws.amazon.com/lambda/latest/dg/with-documentdb.html#docdb-configuration)
    pub fn createEventSourceMapping(self: *Self, allocator: std.mem.Allocator, input: create_event_source_mapping.CreateEventSourceMappingInput, options: CallOptions) !create_event_source_mapping.CreateEventSourceMappingOutput {
        return create_event_source_mapping.execute(self, allocator, input, options);
    }

    /// Creates a Lambda function. To create a function, you need a [deployment
    /// package](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html) and an [execution role](https://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html#lambda-intro-execution-role). The deployment package is a .zip file archive or container image that contains your function code. The execution role grants the function permission to use Amazon Web Services services, such as Amazon CloudWatch Logs for log streaming and X-Ray for request tracing.
    ///
    /// If the deployment package is a [container
    /// image](https://docs.aws.amazon.com/lambda/latest/dg/lambda-images.html),
    /// then you set the package type to `Image`. For a container image, the code
    /// property must include the URI of a container image in the Amazon ECR
    /// registry. You do not need to specify the handler and runtime properties.
    ///
    /// If the deployment package is a [.zip file
    /// archive](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html#gettingstarted-package-zip), then you set the package type to `Zip`. For a .zip file archive, the code property specifies the location of the .zip file. You must also specify the handler and runtime properties. The code in the deployment package must be compatible with the target instruction set architecture of the function (`x86-64` or `arm64`). If you do not specify the architecture, then the default value is `x86-64`.
    ///
    /// When you create a function, Lambda provisions an instance of the function
    /// and its supporting resources. If your function connects to a VPC, this
    /// process can take a minute or so. During this time, you can't invoke or
    /// modify the function. The `State`, `StateReason`, and `StateReasonCode`
    /// fields in the response from GetFunctionConfiguration indicate when the
    /// function is ready to invoke. For more information, see [Lambda function
    /// states](https://docs.aws.amazon.com/lambda/latest/dg/functions-states.html).
    ///
    /// A function has an unpublished version, and can have published versions and
    /// aliases. The unpublished version changes when you update your function's
    /// code and configuration. A published version is a snapshot of your function
    /// code and configuration that can't be changed. An alias is a named resource
    /// that maps to a version, and can be changed to map to a different version.
    /// Use the `Publish` parameter to create version `1` of your function from its
    /// initial configuration.
    ///
    /// The other parameters let you configure version-specific and function-level
    /// settings. You can modify version-specific settings later with
    /// UpdateFunctionConfiguration. Function-level settings apply to both the
    /// unpublished and published versions of the function, and include tags
    /// (TagResource) and per-function concurrency limits (PutFunctionConcurrency).
    ///
    /// You can use code signing if your deployment package is a .zip file archive.
    /// To enable code signing for this function, specify the ARN of a code-signing
    /// configuration. When a user attempts to deploy a code package with
    /// UpdateFunctionCode, Lambda checks that the code package has a valid
    /// signature from a trusted publisher. The code-signing configuration includes
    /// set of signing profiles, which define the trusted publishers for this
    /// function.
    ///
    /// If another Amazon Web Services account or an Amazon Web Services service
    /// invokes your function, use AddPermission to grant permission by creating a
    /// resource-based Identity and Access Management (IAM) policy. You can grant
    /// permissions at the function level, on a version, or on an alias.
    ///
    /// To invoke your function directly, use Invoke. To invoke your function in
    /// response to events in other Amazon Web Services services, create an event
    /// source mapping (CreateEventSourceMapping), or configure a function trigger
    /// in the other service. For more information, see [Invoking Lambda
    /// functions](https://docs.aws.amazon.com/lambda/latest/dg/lambda-invocation.html).
    pub fn createFunction(self: *Self, allocator: std.mem.Allocator, input: create_function.CreateFunctionInput, options: CallOptions) !create_function.CreateFunctionOutput {
        return create_function.execute(self, allocator, input, options);
    }

    /// Creates a Lambda function URL with the specified configuration parameters. A
    /// function URL is a dedicated HTTP(S) endpoint that you can use to invoke your
    /// function.
    pub fn createFunctionUrlConfig(self: *Self, allocator: std.mem.Allocator, input: create_function_url_config.CreateFunctionUrlConfigInput, options: CallOptions) !create_function_url_config.CreateFunctionUrlConfigOutput {
        return create_function_url_config.execute(self, allocator, input, options);
    }

    /// Deletes a Lambda function
    /// [alias](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html).
    pub fn deleteAlias(self: *Self, allocator: std.mem.Allocator, input: delete_alias.DeleteAliasInput, options: CallOptions) !delete_alias.DeleteAliasOutput {
        return delete_alias.execute(self, allocator, input, options);
    }

    /// Deletes a capacity provider. You cannot delete a capacity provider that is
    /// currently being used by Lambda functions.
    pub fn deleteCapacityProvider(self: *Self, allocator: std.mem.Allocator, input: delete_capacity_provider.DeleteCapacityProviderInput, options: CallOptions) !delete_capacity_provider.DeleteCapacityProviderOutput {
        return delete_capacity_provider.execute(self, allocator, input, options);
    }

    /// Deletes the code signing configuration. You can delete the code signing
    /// configuration only if no function is using it.
    pub fn deleteCodeSigningConfig(self: *Self, allocator: std.mem.Allocator, input: delete_code_signing_config.DeleteCodeSigningConfigInput, options: CallOptions) !delete_code_signing_config.DeleteCodeSigningConfigOutput {
        return delete_code_signing_config.execute(self, allocator, input, options);
    }

    /// Deletes an [event source
    /// mapping](https://docs.aws.amazon.com/lambda/latest/dg/intro-invocation-modes.html). You can get the identifier of a mapping from the output of ListEventSourceMappings.
    ///
    /// When you delete an event source mapping, it enters a `Deleting` state and
    /// might not be completely deleted for several seconds.
    pub fn deleteEventSourceMapping(self: *Self, allocator: std.mem.Allocator, input: delete_event_source_mapping.DeleteEventSourceMappingInput, options: CallOptions) !delete_event_source_mapping.DeleteEventSourceMappingOutput {
        return delete_event_source_mapping.execute(self, allocator, input, options);
    }

    /// Deletes a Lambda function. To delete a specific function version, use the
    /// `Qualifier` parameter. Otherwise, all versions and aliases are deleted. This
    /// doesn't require the user to have explicit permissions for DeleteAlias.
    ///
    /// A deleted Lambda function cannot be recovered. Ensure that you specify the
    /// correct function name and version before deleting.
    ///
    /// To delete Lambda event source mappings that invoke a function, use
    /// DeleteEventSourceMapping. For Amazon Web Services services and resources
    /// that invoke your function directly, delete the trigger in the service where
    /// you originally configured it.
    pub fn deleteFunction(self: *Self, allocator: std.mem.Allocator, input: delete_function.DeleteFunctionInput, options: CallOptions) !delete_function.DeleteFunctionOutput {
        return delete_function.execute(self, allocator, input, options);
    }

    /// Removes the code signing configuration from the function.
    pub fn deleteFunctionCodeSigningConfig(self: *Self, allocator: std.mem.Allocator, input: delete_function_code_signing_config.DeleteFunctionCodeSigningConfigInput, options: CallOptions) !delete_function_code_signing_config.DeleteFunctionCodeSigningConfigOutput {
        return delete_function_code_signing_config.execute(self, allocator, input, options);
    }

    /// Removes a concurrent execution limit from a function.
    pub fn deleteFunctionConcurrency(self: *Self, allocator: std.mem.Allocator, input: delete_function_concurrency.DeleteFunctionConcurrencyInput, options: CallOptions) !delete_function_concurrency.DeleteFunctionConcurrencyOutput {
        return delete_function_concurrency.execute(self, allocator, input, options);
    }

    /// Deletes the configuration for asynchronous invocation for a function,
    /// version, or alias.
    ///
    /// To configure options for asynchronous invocation, use
    /// PutFunctionEventInvokeConfig.
    pub fn deleteFunctionEventInvokeConfig(self: *Self, allocator: std.mem.Allocator, input: delete_function_event_invoke_config.DeleteFunctionEventInvokeConfigInput, options: CallOptions) !delete_function_event_invoke_config.DeleteFunctionEventInvokeConfigOutput {
        return delete_function_event_invoke_config.execute(self, allocator, input, options);
    }

    /// Deletes a Lambda function URL. When you delete a function URL, you can't
    /// recover it. Creating a new function URL results in a different URL address.
    pub fn deleteFunctionUrlConfig(self: *Self, allocator: std.mem.Allocator, input: delete_function_url_config.DeleteFunctionUrlConfigInput, options: CallOptions) !delete_function_url_config.DeleteFunctionUrlConfigOutput {
        return delete_function_url_config.execute(self, allocator, input, options);
    }

    /// Deletes a version of an [Lambda
    /// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html). Deleted versions can no longer be viewed or added to functions. To avoid breaking functions, a copy of the version remains in Lambda until no functions refer to it.
    pub fn deleteLayerVersion(self: *Self, allocator: std.mem.Allocator, input: delete_layer_version.DeleteLayerVersionInput, options: CallOptions) !delete_layer_version.DeleteLayerVersionOutput {
        return delete_layer_version.execute(self, allocator, input, options);
    }

    /// Deletes the provisioned concurrency configuration for a function.
    pub fn deleteProvisionedConcurrencyConfig(self: *Self, allocator: std.mem.Allocator, input: delete_provisioned_concurrency_config.DeleteProvisionedConcurrencyConfigInput, options: CallOptions) !delete_provisioned_concurrency_config.DeleteProvisionedConcurrencyConfigOutput {
        return delete_provisioned_concurrency_config.execute(self, allocator, input, options);
    }

    /// Retrieves details about your account's
    /// [limits](https://docs.aws.amazon.com/lambda/latest/dg/limits.html) and usage
    /// in an Amazon Web Services Region.
    pub fn getAccountSettings(self: *Self, allocator: std.mem.Allocator, input: get_account_settings.GetAccountSettingsInput, options: CallOptions) !get_account_settings.GetAccountSettingsOutput {
        return get_account_settings.execute(self, allocator, input, options);
    }

    /// Returns details about a Lambda function
    /// [alias](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html).
    pub fn getAlias(self: *Self, allocator: std.mem.Allocator, input: get_alias.GetAliasInput, options: CallOptions) !get_alias.GetAliasOutput {
        return get_alias.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific capacity provider, including its
    /// configuration, state, and associated resources.
    pub fn getCapacityProvider(self: *Self, allocator: std.mem.Allocator, input: get_capacity_provider.GetCapacityProviderInput, options: CallOptions) !get_capacity_provider.GetCapacityProviderOutput {
        return get_capacity_provider.execute(self, allocator, input, options);
    }

    /// Returns information about the specified code signing configuration.
    pub fn getCodeSigningConfig(self: *Self, allocator: std.mem.Allocator, input: get_code_signing_config.GetCodeSigningConfigInput, options: CallOptions) !get_code_signing_config.GetCodeSigningConfigOutput {
        return get_code_signing_config.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific [durable
    /// execution](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html), including its current status, input payload, result or error information, and execution metadata such as start time and usage statistics.
    pub fn getDurableExecution(self: *Self, allocator: std.mem.Allocator, input: get_durable_execution.GetDurableExecutionInput, options: CallOptions) !get_durable_execution.GetDurableExecutionOutput {
        return get_durable_execution.execute(self, allocator, input, options);
    }

    /// Retrieves the execution history for a [durable
    /// execution](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html), showing all the steps, callbacks, and events that occurred during the execution. This provides a detailed audit trail of the execution's progress over time.
    ///
    /// The history is available while the execution is running and for a retention
    /// period after it completes (1-90 days, default 30 days). You can control
    /// whether to include execution data such as step results and callback
    /// payloads.
    pub fn getDurableExecutionHistory(self: *Self, allocator: std.mem.Allocator, input: get_durable_execution_history.GetDurableExecutionHistoryInput, options: CallOptions) !get_durable_execution_history.GetDurableExecutionHistoryOutput {
        return get_durable_execution_history.execute(self, allocator, input, options);
    }

    /// Retrieves the current execution state required for the replay process during
    /// [durable
    /// function](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html) execution. This API is used by the Lambda durable functions SDK to get state information needed for replay. You typically don't need to call this API directly as the SDK handles state management automatically.
    ///
    /// The response contains operations ordered by start sequence number in
    /// ascending order. Completed operations with children don't include child
    /// operation details since they don't need to be replayed.
    pub fn getDurableExecutionState(self: *Self, allocator: std.mem.Allocator, input: get_durable_execution_state.GetDurableExecutionStateInput, options: CallOptions) !get_durable_execution_state.GetDurableExecutionStateOutput {
        return get_durable_execution_state.execute(self, allocator, input, options);
    }

    /// Returns details about an event source mapping. You can get the identifier of
    /// a mapping from the output of ListEventSourceMappings.
    pub fn getEventSourceMapping(self: *Self, allocator: std.mem.Allocator, input: get_event_source_mapping.GetEventSourceMappingInput, options: CallOptions) !get_event_source_mapping.GetEventSourceMappingOutput {
        return get_event_source_mapping.execute(self, allocator, input, options);
    }

    /// Returns information about the function or function version, with a link to
    /// download the deployment package that's valid for 10 minutes. If you specify
    /// a function version, only details that are specific to that version are
    /// returned.
    pub fn getFunction(self: *Self, allocator: std.mem.Allocator, input: get_function.GetFunctionInput, options: CallOptions) !get_function.GetFunctionOutput {
        return get_function.execute(self, allocator, input, options);
    }

    /// Returns the code signing configuration for the specified function.
    pub fn getFunctionCodeSigningConfig(self: *Self, allocator: std.mem.Allocator, input: get_function_code_signing_config.GetFunctionCodeSigningConfigInput, options: CallOptions) !get_function_code_signing_config.GetFunctionCodeSigningConfigOutput {
        return get_function_code_signing_config.execute(self, allocator, input, options);
    }

    /// Returns details about the reserved concurrency configuration for a function.
    /// To set a concurrency limit for a function, use PutFunctionConcurrency.
    pub fn getFunctionConcurrency(self: *Self, allocator: std.mem.Allocator, input: get_function_concurrency.GetFunctionConcurrencyInput, options: CallOptions) !get_function_concurrency.GetFunctionConcurrencyOutput {
        return get_function_concurrency.execute(self, allocator, input, options);
    }

    /// Returns the version-specific settings of a Lambda function or version. The
    /// output includes only options that can vary between versions of a function.
    /// To modify these settings, use UpdateFunctionConfiguration.
    ///
    /// To get all of a function's details, including function-level settings, use
    /// GetFunction.
    pub fn getFunctionConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_function_configuration.GetFunctionConfigurationInput, options: CallOptions) !get_function_configuration.GetFunctionConfigurationOutput {
        return get_function_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration for asynchronous invocation for a function,
    /// version, or alias.
    ///
    /// To configure options for asynchronous invocation, use
    /// PutFunctionEventInvokeConfig.
    pub fn getFunctionEventInvokeConfig(self: *Self, allocator: std.mem.Allocator, input: get_function_event_invoke_config.GetFunctionEventInvokeConfigInput, options: CallOptions) !get_function_event_invoke_config.GetFunctionEventInvokeConfigOutput {
        return get_function_event_invoke_config.execute(self, allocator, input, options);
    }

    /// Returns your function's [recursive loop
    /// detection](https://docs.aws.amazon.com/lambda/latest/dg/invocation-recursion.html) configuration.
    pub fn getFunctionRecursionConfig(self: *Self, allocator: std.mem.Allocator, input: get_function_recursion_config.GetFunctionRecursionConfigInput, options: CallOptions) !get_function_recursion_config.GetFunctionRecursionConfigOutput {
        return get_function_recursion_config.execute(self, allocator, input, options);
    }

    /// Retrieves the scaling configuration for a Lambda Managed Instances function.
    pub fn getFunctionScalingConfig(self: *Self, allocator: std.mem.Allocator, input: get_function_scaling_config.GetFunctionScalingConfigInput, options: CallOptions) !get_function_scaling_config.GetFunctionScalingConfigOutput {
        return get_function_scaling_config.execute(self, allocator, input, options);
    }

    /// Returns details about a Lambda function URL.
    pub fn getFunctionUrlConfig(self: *Self, allocator: std.mem.Allocator, input: get_function_url_config.GetFunctionUrlConfigInput, options: CallOptions) !get_function_url_config.GetFunctionUrlConfigOutput {
        return get_function_url_config.execute(self, allocator, input, options);
    }

    /// Returns information about a version of an [Lambda
    /// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html), with a link to download the layer archive that's valid for 10 minutes.
    pub fn getLayerVersion(self: *Self, allocator: std.mem.Allocator, input: get_layer_version.GetLayerVersionInput, options: CallOptions) !get_layer_version.GetLayerVersionOutput {
        return get_layer_version.execute(self, allocator, input, options);
    }

    /// Returns information about a version of an [Lambda
    /// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html), with a link to download the layer archive that's valid for 10 minutes.
    pub fn getLayerVersionByArn(self: *Self, allocator: std.mem.Allocator, input: get_layer_version_by_arn.GetLayerVersionByArnInput, options: CallOptions) !get_layer_version_by_arn.GetLayerVersionByArnOutput {
        return get_layer_version_by_arn.execute(self, allocator, input, options);
    }

    /// Returns the permission policy for a version of an [Lambda
    /// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html). For more information, see AddLayerVersionPermission.
    pub fn getLayerVersionPolicy(self: *Self, allocator: std.mem.Allocator, input: get_layer_version_policy.GetLayerVersionPolicyInput, options: CallOptions) !get_layer_version_policy.GetLayerVersionPolicyOutput {
        return get_layer_version_policy.execute(self, allocator, input, options);
    }

    /// Returns the [resource-based IAM
    /// policy](https://docs.aws.amazon.com/lambda/latest/dg/access-control-resource-based.html) for a function, version, or alias.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: CallOptions) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the provisioned concurrency configuration for a function's alias
    /// or version.
    pub fn getProvisionedConcurrencyConfig(self: *Self, allocator: std.mem.Allocator, input: get_provisioned_concurrency_config.GetProvisionedConcurrencyConfigInput, options: CallOptions) !get_provisioned_concurrency_config.GetProvisionedConcurrencyConfigOutput {
        return get_provisioned_concurrency_config.execute(self, allocator, input, options);
    }

    /// Retrieves the runtime management configuration for a function's version. If
    /// the runtime update mode is **Manual**, this includes the ARN of the runtime
    /// version and the runtime update mode. If the runtime update mode is **Auto**
    /// or **Function update**, this includes the runtime update mode and `null` is
    /// returned for the ARN. For more information, see [Runtime
    /// updates](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-update.html).
    pub fn getRuntimeManagementConfig(self: *Self, allocator: std.mem.Allocator, input: get_runtime_management_config.GetRuntimeManagementConfigInput, options: CallOptions) !get_runtime_management_config.GetRuntimeManagementConfigOutput {
        return get_runtime_management_config.execute(self, allocator, input, options);
    }

    /// Invokes a Lambda function. You can invoke a function synchronously (and wait
    /// for the response), or asynchronously. By default, Lambda invokes your
    /// function synchronously (i.e. the`InvocationType` is `RequestResponse`). To
    /// invoke a function asynchronously, set `InvocationType` to `Event`. Lambda
    /// passes the `ClientContext` object to your function for synchronous
    /// invocations only.
    ///
    /// For synchronous invocations, the maximum payload size is 6 MB. For
    /// asynchronous invocations, the maximum payload size is 1 MB.
    ///
    /// For [synchronous
    /// invocation](https://docs.aws.amazon.com/lambda/latest/dg/invocation-sync.html), details about the function response, including errors, are included in the response body and headers. For either invocation type, you can find more information in the [execution log](https://docs.aws.amazon.com/lambda/latest/dg/monitoring-functions.html) and [trace](https://docs.aws.amazon.com/lambda/latest/dg/lambda-x-ray.html).
    ///
    /// When an error occurs, your function may be invoked multiple times. Retry
    /// behavior varies by error type, client, event source, and invocation type.
    /// For example, if you invoke a function asynchronously and it returns an
    /// error, Lambda executes the function up to two more times. For more
    /// information, see [Error handling and automatic retries in
    /// Lambda](https://docs.aws.amazon.com/lambda/latest/dg/invocation-retries.html).
    ///
    /// For [asynchronous
    /// invocation](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html), Lambda adds events to a queue before sending them to your function. If your function does not have enough capacity to keep up with the queue, events may be lost. Occasionally, your function may receive the same event multiple times, even if no error occurs. To retain events that were not processed, configure your function with a [dead-letter queue](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-dlq).
    ///
    /// The status code in the API response doesn't reflect function errors. Error
    /// codes are reserved for errors that prevent your function from executing,
    /// such as permissions errors,
    /// [quota](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html) errors, or issues with your function's code and configuration. For example, Lambda returns `TooManyRequestsException` if running the function would cause you to exceed a concurrency limit at either the account level (`ConcurrentInvocationLimitExceeded`) or function level (`ReservedFunctionConcurrentInvocationLimitExceeded`).
    ///
    /// For functions with a long timeout, your client might disconnect during
    /// synchronous invocation while it waits for a response. Configure your HTTP
    /// client, SDK, firewall, proxy, or operating system to allow for long
    /// connections with timeout or keep-alive settings.
    ///
    /// This operation requires permission for the
    /// [lambda:InvokeFunction](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awslambda.html) action. For details on how to set up permissions for cross-account invocations, see [Granting function access to other accounts](https://docs.aws.amazon.com/lambda/latest/dg/access-control-resource-based.html#permissions-resource-xaccountinvoke).
    pub fn invoke(self: *Self, allocator: std.mem.Allocator, input: invoke_.InvokeInput, options: CallOptions) !invoke_.InvokeOutput {
        return invoke_.execute(self, allocator, input, options);
    }

    /// For asynchronous function invocation, use Invoke.
    ///
    /// Invokes a function asynchronously.
    ///
    /// The payload limit is 256KB. For larger payloads, for up to 1MB, use Invoke.
    ///
    /// If you do use the InvokeAsync action, note that it doesn't support the use
    /// of X-Ray active tracing. Trace ID is not propagated to the function, even if
    /// X-Ray active tracing is turned on.
    pub fn invokeAsync(self: *Self, allocator: std.mem.Allocator, input: invoke_async.InvokeAsyncInput, options: CallOptions) !invoke_async.InvokeAsyncOutput {
        return invoke_async.execute(self, allocator, input, options);
    }

    /// Configure your Lambda functions to stream response payloads back to clients.
    /// For more information, see [Configuring a Lambda function to stream
    /// responses](https://docs.aws.amazon.com/lambda/latest/dg/configuration-response-streaming.html).
    ///
    /// This operation requires permission for the
    /// [lambda:InvokeFunction](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awslambda.html) action. For details on how to set up permissions for cross-account invocations, see [Granting function access to other accounts](https://docs.aws.amazon.com/lambda/latest/dg/access-control-resource-based.html#permissions-resource-xaccountinvoke).
    pub fn invokeWithResponseStream(self: *Self, allocator: std.mem.Allocator, input: invoke_with_response_stream.InvokeWithResponseStreamInput, options: CallOptions) !invoke_with_response_stream.InvokeWithResponseStreamOutput {
        return invoke_with_response_stream.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [aliases](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html) for a Lambda function.
    pub fn listAliases(self: *Self, allocator: std.mem.Allocator, input: list_aliases.ListAliasesInput, options: CallOptions) !list_aliases.ListAliasesOutput {
        return list_aliases.execute(self, allocator, input, options);
    }

    /// Returns a list of capacity providers in your account.
    pub fn listCapacityProviders(self: *Self, allocator: std.mem.Allocator, input: list_capacity_providers.ListCapacityProvidersInput, options: CallOptions) !list_capacity_providers.ListCapacityProvidersOutput {
        return list_capacity_providers.execute(self, allocator, input, options);
    }

    /// Returns a list of [code signing
    /// configurations](https://docs.aws.amazon.com/lambda/latest/dg/configuring-codesigning.html). A request returns up to 10,000 configurations per call. You can use the `MaxItems` parameter to return fewer configurations per call.
    pub fn listCodeSigningConfigs(self: *Self, allocator: std.mem.Allocator, input: list_code_signing_configs.ListCodeSigningConfigsInput, options: CallOptions) !list_code_signing_configs.ListCodeSigningConfigsOutput {
        return list_code_signing_configs.execute(self, allocator, input, options);
    }

    /// Returns a list of [durable
    /// executions](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html) for a specified Lambda function. You can filter the results by execution name, status, and start time range. This API supports pagination for large result sets.
    pub fn listDurableExecutionsByFunction(self: *Self, allocator: std.mem.Allocator, input: list_durable_executions_by_function.ListDurableExecutionsByFunctionInput, options: CallOptions) !list_durable_executions_by_function.ListDurableExecutionsByFunctionOutput {
        return list_durable_executions_by_function.execute(self, allocator, input, options);
    }

    /// Lists event source mappings. Specify an `EventSourceArn` to show only event
    /// source mappings for a single event source.
    pub fn listEventSourceMappings(self: *Self, allocator: std.mem.Allocator, input: list_event_source_mappings.ListEventSourceMappingsInput, options: CallOptions) !list_event_source_mappings.ListEventSourceMappingsOutput {
        return list_event_source_mappings.execute(self, allocator, input, options);
    }

    /// Retrieves a list of configurations for asynchronous invocation for a
    /// function.
    ///
    /// To configure options for asynchronous invocation, use
    /// PutFunctionEventInvokeConfig.
    pub fn listFunctionEventInvokeConfigs(self: *Self, allocator: std.mem.Allocator, input: list_function_event_invoke_configs.ListFunctionEventInvokeConfigsInput, options: CallOptions) !list_function_event_invoke_configs.ListFunctionEventInvokeConfigsOutput {
        return list_function_event_invoke_configs.execute(self, allocator, input, options);
    }

    /// Returns a list of Lambda function URLs for the specified function.
    pub fn listFunctionUrlConfigs(self: *Self, allocator: std.mem.Allocator, input: list_function_url_configs.ListFunctionUrlConfigsInput, options: CallOptions) !list_function_url_configs.ListFunctionUrlConfigsOutput {
        return list_function_url_configs.execute(self, allocator, input, options);
    }

    /// Returns a list of function versions that are configured to use a specific
    /// capacity provider.
    pub fn listFunctionVersionsByCapacityProvider(self: *Self, allocator: std.mem.Allocator, input: list_function_versions_by_capacity_provider.ListFunctionVersionsByCapacityProviderInput, options: CallOptions) !list_function_versions_by_capacity_provider.ListFunctionVersionsByCapacityProviderOutput {
        return list_function_versions_by_capacity_provider.execute(self, allocator, input, options);
    }

    /// Returns a list of Lambda functions, with the version-specific configuration
    /// of each. Lambda returns up to 50 functions per call.
    ///
    /// Set `FunctionVersion` to `ALL` to include all published versions of each
    /// function in addition to the unpublished version.
    ///
    /// The `ListFunctions` operation returns a subset of the FunctionConfiguration
    /// fields. To get the additional fields (State, StateReasonCode, StateReason,
    /// LastUpdateStatus, LastUpdateStatusReason, LastUpdateStatusReasonCode,
    /// RuntimeVersionConfig) for a function or version, use GetFunction.
    pub fn listFunctions(self: *Self, allocator: std.mem.Allocator, input: list_functions.ListFunctionsInput, options: CallOptions) !list_functions.ListFunctionsOutput {
        return list_functions.execute(self, allocator, input, options);
    }

    /// List the functions that use the specified code signing configuration. You
    /// can use this method prior to deleting a code signing configuration, to
    /// verify that no functions are using it.
    pub fn listFunctionsByCodeSigningConfig(self: *Self, allocator: std.mem.Allocator, input: list_functions_by_code_signing_config.ListFunctionsByCodeSigningConfigInput, options: CallOptions) !list_functions_by_code_signing_config.ListFunctionsByCodeSigningConfigOutput {
        return list_functions_by_code_signing_config.execute(self, allocator, input, options);
    }

    /// Lists the versions of an [Lambda
    /// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html). Versions that have been deleted aren't listed. Specify a [runtime identifier](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html) to list only versions that indicate that they're compatible with that runtime. Specify a compatible architecture to include only layer versions that are compatible with that architecture.
    pub fn listLayerVersions(self: *Self, allocator: std.mem.Allocator, input: list_layer_versions.ListLayerVersionsInput, options: CallOptions) !list_layer_versions.ListLayerVersionsOutput {
        return list_layer_versions.execute(self, allocator, input, options);
    }

    /// Lists [Lambda
    /// layers](https://docs.aws.amazon.com/lambda/latest/dg/invocation-layers.html)
    /// and shows information about the latest version of each. Specify a [runtime
    /// identifier](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html) to list only layers that indicate that they're compatible with that runtime. Specify a compatible architecture to include only layers that are compatible with that [instruction set architecture](https://docs.aws.amazon.com/lambda/latest/dg/foundation-arch.html).
    pub fn listLayers(self: *Self, allocator: std.mem.Allocator, input: list_layers.ListLayersInput, options: CallOptions) !list_layers.ListLayersOutput {
        return list_layers.execute(self, allocator, input, options);
    }

    /// Retrieves a list of provisioned concurrency configurations for a function.
    pub fn listProvisionedConcurrencyConfigs(self: *Self, allocator: std.mem.Allocator, input: list_provisioned_concurrency_configs.ListProvisionedConcurrencyConfigsInput, options: CallOptions) !list_provisioned_concurrency_configs.ListProvisionedConcurrencyConfigsOutput {
        return list_provisioned_concurrency_configs.execute(self, allocator, input, options);
    }

    /// Returns a function, event source mapping, or code signing configuration's
    /// [tags](https://docs.aws.amazon.com/lambda/latest/dg/tagging.html). You can
    /// also view function tags with GetFunction.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: CallOptions) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [versions](https://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html), with the version-specific configuration of each. Lambda returns up to 50 versions per call.
    pub fn listVersionsByFunction(self: *Self, allocator: std.mem.Allocator, input: list_versions_by_function.ListVersionsByFunctionInput, options: CallOptions) !list_versions_by_function.ListVersionsByFunctionOutput {
        return list_versions_by_function.execute(self, allocator, input, options);
    }

    /// Creates an [Lambda
    /// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html) from a ZIP archive. Each time you call `PublishLayerVersion` with the same layer name, a new version is created.
    ///
    /// Add layers to your function with CreateFunction or
    /// UpdateFunctionConfiguration.
    pub fn publishLayerVersion(self: *Self, allocator: std.mem.Allocator, input: publish_layer_version.PublishLayerVersionInput, options: CallOptions) !publish_layer_version.PublishLayerVersionOutput {
        return publish_layer_version.execute(self, allocator, input, options);
    }

    /// Creates a
    /// [version](https://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html) from the current code and configuration of a function. Use versions to create a snapshot of your function code and configuration that doesn't change.
    ///
    /// Lambda doesn't publish a version if the function's configuration and code
    /// haven't changed since the last version. Use UpdateFunctionCode or
    /// UpdateFunctionConfiguration to update the function before publishing a
    /// version.
    ///
    /// Clients can invoke versions directly or with an alias. To create an alias,
    /// use CreateAlias.
    pub fn publishVersion(self: *Self, allocator: std.mem.Allocator, input: publish_version.PublishVersionInput, options: CallOptions) !publish_version.PublishVersionOutput {
        return publish_version.execute(self, allocator, input, options);
    }

    /// Update the code signing configuration for the function. Changes to the code
    /// signing configuration take effect the next time a user tries to deploy a
    /// code package to the function.
    pub fn putFunctionCodeSigningConfig(self: *Self, allocator: std.mem.Allocator, input: put_function_code_signing_config.PutFunctionCodeSigningConfigInput, options: CallOptions) !put_function_code_signing_config.PutFunctionCodeSigningConfigOutput {
        return put_function_code_signing_config.execute(self, allocator, input, options);
    }

    /// Sets the maximum number of simultaneous executions for a function, and
    /// reserves capacity for that concurrency level.
    ///
    /// Concurrency settings apply to the function as a whole, including all
    /// published versions and the unpublished version. Reserving concurrency both
    /// ensures that your function has capacity to process the specified number of
    /// events simultaneously, and prevents it from scaling beyond that level. Use
    /// GetFunction to see the current setting for a function.
    ///
    /// Use GetAccountSettings to see your Regional concurrency limit. You can
    /// reserve concurrency for as many functions as you like, as long as you leave
    /// at least 100 simultaneous executions unreserved for functions that aren't
    /// configured with a per-function limit. For more information, see [Lambda
    /// function
    /// scaling](https://docs.aws.amazon.com/lambda/latest/dg/invocation-scaling.html).
    pub fn putFunctionConcurrency(self: *Self, allocator: std.mem.Allocator, input: put_function_concurrency.PutFunctionConcurrencyInput, options: CallOptions) !put_function_concurrency.PutFunctionConcurrencyOutput {
        return put_function_concurrency.execute(self, allocator, input, options);
    }

    /// Configures options for [asynchronous
    /// invocation](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html) on a function, version, or alias. If a configuration already exists for a function, version, or alias, this operation overwrites it. If you exclude any settings, they are removed. To set one option without affecting existing settings for other options, use UpdateFunctionEventInvokeConfig.
    ///
    /// By default, Lambda retries an asynchronous invocation twice if the function
    /// returns an error. It retains events in a queue for up to six hours. When an
    /// event fails all processing attempts or stays in the asynchronous invocation
    /// queue for too long, Lambda discards it. To retain discarded events,
    /// configure a dead-letter queue with UpdateFunctionConfiguration.
    ///
    /// To send an invocation record to a queue, topic, S3 bucket, function, or
    /// event bus, specify a
    /// [destination](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-async-destinations). You can configure separate destinations for successful invocations (on-success) and events that fail all processing attempts (on-failure). You can configure destinations in addition to or instead of a dead-letter queue.
    ///
    /// S3 buckets are supported only for on-failure destinations. To retain records
    /// of successful invocations, use another destination type.
    pub fn putFunctionEventInvokeConfig(self: *Self, allocator: std.mem.Allocator, input: put_function_event_invoke_config.PutFunctionEventInvokeConfigInput, options: CallOptions) !put_function_event_invoke_config.PutFunctionEventInvokeConfigOutput {
        return put_function_event_invoke_config.execute(self, allocator, input, options);
    }

    /// Sets your function's [recursive loop
    /// detection](https://docs.aws.amazon.com/lambda/latest/dg/invocation-recursion.html) configuration.
    ///
    /// When you configure a Lambda function to output to the same service or
    /// resource that invokes the function, it's possible to create an infinite
    /// recursive loop. For example, a Lambda function might write a message to an
    /// Amazon Simple Queue Service (Amazon SQS) queue, which then invokes the same
    /// function. This invocation causes the function to write another message to
    /// the queue, which in turn invokes the function again.
    ///
    /// Lambda can detect certain types of recursive loops shortly after they occur.
    /// When Lambda detects a recursive loop and your function's recursive loop
    /// detection configuration is set to `Terminate`, it stops your function being
    /// invoked and notifies you.
    pub fn putFunctionRecursionConfig(self: *Self, allocator: std.mem.Allocator, input: put_function_recursion_config.PutFunctionRecursionConfigInput, options: CallOptions) !put_function_recursion_config.PutFunctionRecursionConfigOutput {
        return put_function_recursion_config.execute(self, allocator, input, options);
    }

    /// Sets the scaling configuration for a Lambda Managed Instances function. The
    /// scaling configuration defines the minimum and maximum number of execution
    /// environments that can be provisioned for the function, allowing you to
    /// control scaling behavior and resource allocation.
    pub fn putFunctionScalingConfig(self: *Self, allocator: std.mem.Allocator, input: put_function_scaling_config.PutFunctionScalingConfigInput, options: CallOptions) !put_function_scaling_config.PutFunctionScalingConfigOutput {
        return put_function_scaling_config.execute(self, allocator, input, options);
    }

    /// Adds a provisioned concurrency configuration to a function's alias or
    /// version.
    pub fn putProvisionedConcurrencyConfig(self: *Self, allocator: std.mem.Allocator, input: put_provisioned_concurrency_config.PutProvisionedConcurrencyConfigInput, options: CallOptions) !put_provisioned_concurrency_config.PutProvisionedConcurrencyConfigOutput {
        return put_provisioned_concurrency_config.execute(self, allocator, input, options);
    }

    /// Sets the runtime management configuration for a function's version. For more
    /// information, see [Runtime
    /// updates](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-update.html).
    pub fn putRuntimeManagementConfig(self: *Self, allocator: std.mem.Allocator, input: put_runtime_management_config.PutRuntimeManagementConfigInput, options: CallOptions) !put_runtime_management_config.PutRuntimeManagementConfigOutput {
        return put_runtime_management_config.execute(self, allocator, input, options);
    }

    /// Removes a statement from the permissions policy for a version of an [Lambda
    /// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html). For more information, see AddLayerVersionPermission.
    pub fn removeLayerVersionPermission(self: *Self, allocator: std.mem.Allocator, input: remove_layer_version_permission.RemoveLayerVersionPermissionInput, options: CallOptions) !remove_layer_version_permission.RemoveLayerVersionPermissionOutput {
        return remove_layer_version_permission.execute(self, allocator, input, options);
    }

    /// Revokes function-use permission from an Amazon Web Services service or
    /// another Amazon Web Services account. You can get the ID of the statement
    /// from the output of GetPolicy.
    pub fn removePermission(self: *Self, allocator: std.mem.Allocator, input: remove_permission.RemovePermissionInput, options: CallOptions) !remove_permission.RemovePermissionOutput {
        return remove_permission.execute(self, allocator, input, options);
    }

    /// Sends a failure response for a callback operation in a durable execution.
    /// Use this API when an external system cannot complete a callback operation
    /// successfully.
    pub fn sendDurableExecutionCallbackFailure(self: *Self, allocator: std.mem.Allocator, input: send_durable_execution_callback_failure.SendDurableExecutionCallbackFailureInput, options: CallOptions) !send_durable_execution_callback_failure.SendDurableExecutionCallbackFailureOutput {
        return send_durable_execution_callback_failure.execute(self, allocator, input, options);
    }

    /// Sends a heartbeat signal for a long-running callback operation to prevent
    /// timeout. Use this API to extend the callback timeout period while the
    /// external operation is still in progress.
    pub fn sendDurableExecutionCallbackHeartbeat(self: *Self, allocator: std.mem.Allocator, input: send_durable_execution_callback_heartbeat.SendDurableExecutionCallbackHeartbeatInput, options: CallOptions) !send_durable_execution_callback_heartbeat.SendDurableExecutionCallbackHeartbeatOutput {
        return send_durable_execution_callback_heartbeat.execute(self, allocator, input, options);
    }

    /// Sends a successful completion response for a callback operation in a durable
    /// execution. Use this API when an external system has successfully completed a
    /// callback operation.
    pub fn sendDurableExecutionCallbackSuccess(self: *Self, allocator: std.mem.Allocator, input: send_durable_execution_callback_success.SendDurableExecutionCallbackSuccessInput, options: CallOptions) !send_durable_execution_callback_success.SendDurableExecutionCallbackSuccessOutput {
        return send_durable_execution_callback_success.execute(self, allocator, input, options);
    }

    /// Stops a running [durable
    /// execution](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html). The execution transitions to STOPPED status and cannot be resumed. Any in-progress operations are terminated.
    pub fn stopDurableExecution(self: *Self, allocator: std.mem.Allocator, input: stop_durable_execution.StopDurableExecutionInput, options: CallOptions) !stop_durable_execution.StopDurableExecutionOutput {
        return stop_durable_execution.execute(self, allocator, input, options);
    }

    /// Adds [tags](https://docs.aws.amazon.com/lambda/latest/dg/tagging.html) to a
    /// function, event source mapping, or code signing configuration.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes [tags](https://docs.aws.amazon.com/lambda/latest/dg/tagging.html)
    /// from a function, event source mapping, or code signing configuration.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a Lambda function
    /// [alias](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html).
    pub fn updateAlias(self: *Self, allocator: std.mem.Allocator, input: update_alias.UpdateAliasInput, options: CallOptions) !update_alias.UpdateAliasOutput {
        return update_alias.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing capacity provider.
    pub fn updateCapacityProvider(self: *Self, allocator: std.mem.Allocator, input: update_capacity_provider.UpdateCapacityProviderInput, options: CallOptions) !update_capacity_provider.UpdateCapacityProviderOutput {
        return update_capacity_provider.execute(self, allocator, input, options);
    }

    /// Update the code signing configuration. Changes to the code signing
    /// configuration take effect the next time a user tries to deploy a code
    /// package to the function.
    pub fn updateCodeSigningConfig(self: *Self, allocator: std.mem.Allocator, input: update_code_signing_config.UpdateCodeSigningConfigInput, options: CallOptions) !update_code_signing_config.UpdateCodeSigningConfigOutput {
        return update_code_signing_config.execute(self, allocator, input, options);
    }

    /// Updates an event source mapping. You can change the function that Lambda
    /// invokes, or pause invocation and resume later from the same location.
    ///
    /// For details about how to configure different event sources, see the
    /// following topics.
    ///
    /// * [ Amazon DynamoDB
    ///   Streams](https://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html#services-dynamodb-eventsourcemapping)
    /// * [ Amazon
    ///   Kinesis](https://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html#services-kinesis-eventsourcemapping)
    /// * [ Amazon
    ///   SQS](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html#events-sqs-eventsource)
    /// * [ Amazon MQ and
    ///   RabbitMQ](https://docs.aws.amazon.com/lambda/latest/dg/with-mq.html#services-mq-eventsourcemapping)
    /// * [ Amazon MSK](https://docs.aws.amazon.com/lambda/latest/dg/with-msk.html)
    /// * [ Apache
    ///   Kafka](https://docs.aws.amazon.com/lambda/latest/dg/kafka-smaa.html)
    /// * [ Amazon
    ///   DocumentDB](https://docs.aws.amazon.com/lambda/latest/dg/with-documentdb.html)
    ///
    /// The following error handling options are available for stream sources
    /// (DynamoDB, Kinesis, Amazon MSK, and self-managed Apache Kafka):
    ///
    /// * `BisectBatchOnFunctionError` – If the function returns an error, split the
    ///   batch in two and retry.
    /// * `MaximumRecordAgeInSeconds` – Discard records older than the specified
    ///   age. The default value is infinite (-1). When set to infinite (-1), failed
    ///   records are retried until the record expires
    /// * `MaximumRetryAttempts` – Discard records after the specified number of
    ///   retries. The default value is infinite (-1). When set to infinite (-1),
    ///   failed records are retried until the record expires.
    /// * `OnFailure` – Send discarded records to an Amazon SQS queue, Amazon SNS
    ///   topic, Kafka topic, or Amazon S3 bucket. For more information, see [Adding
    ///   a
    ///   destination](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async-retain-records.html#invocation-async-destinations).
    ///
    /// The following option is available only for DynamoDB and Kinesis event
    /// sources:
    ///
    /// * `ParallelizationFactor` – Process multiple batches from each shard
    ///   concurrently.
    ///
    /// For information about which configuration parameters apply to each event
    /// source, see the following topics.
    ///
    /// * [ Amazon DynamoDB
    ///   Streams](https://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html#services-ddb-params)
    /// * [ Amazon
    ///   Kinesis](https://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html#services-kinesis-params)
    /// * [ Amazon
    ///   SQS](https://docs.aws.amazon.com/lambda/latest/dg/with-sqs.html#services-sqs-params)
    /// * [ Amazon MQ and
    ///   RabbitMQ](https://docs.aws.amazon.com/lambda/latest/dg/with-mq.html#services-mq-params)
    /// * [ Amazon
    ///   MSK](https://docs.aws.amazon.com/lambda/latest/dg/with-msk.html#services-msk-parms)
    /// * [ Apache
    ///   Kafka](https://docs.aws.amazon.com/lambda/latest/dg/with-kafka.html#services-kafka-parms)
    /// * [ Amazon
    ///   DocumentDB](https://docs.aws.amazon.com/lambda/latest/dg/with-documentdb.html#docdb-configuration)
    pub fn updateEventSourceMapping(self: *Self, allocator: std.mem.Allocator, input: update_event_source_mapping.UpdateEventSourceMappingInput, options: CallOptions) !update_event_source_mapping.UpdateEventSourceMappingOutput {
        return update_event_source_mapping.execute(self, allocator, input, options);
    }

    /// Updates a Lambda function's code. If code signing is enabled for the
    /// function, the code package must be signed by a trusted publisher. For more
    /// information, see [Configuring code signing for
    /// Lambda](https://docs.aws.amazon.com/lambda/latest/dg/configuration-codesigning.html).
    ///
    /// If the function's package type is `Image`, then you must specify the code
    /// package in `ImageUri` as the URI of a [container
    /// image](https://docs.aws.amazon.com/lambda/latest/dg/lambda-images.html) in
    /// the Amazon ECR registry.
    ///
    /// If the function's package type is `Zip`, then you must specify the
    /// deployment package as a [.zip file
    /// archive](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html#gettingstarted-package-zip). Enter the Amazon S3 bucket and key of the code .zip file location. You can also provide the function code inline using the `ZipFile` field.
    ///
    /// The code in the deployment package must be compatible with the target
    /// instruction set architecture of the function (`x86-64` or `arm64`).
    ///
    /// The function's code is locked when you publish a version. You can't modify
    /// the code of a published version, only the unpublished version.
    ///
    /// For a function defined as a container image, Lambda resolves the image tag
    /// to an image digest. In Amazon ECR, if you update the image tag to a new
    /// image, Lambda does not automatically update the function.
    pub fn updateFunctionCode(self: *Self, allocator: std.mem.Allocator, input: update_function_code.UpdateFunctionCodeInput, options: CallOptions) !update_function_code.UpdateFunctionCodeOutput {
        return update_function_code.execute(self, allocator, input, options);
    }

    /// Modify the version-specific settings of a Lambda function.
    ///
    /// When you update a function, Lambda provisions an instance of the function
    /// and its supporting resources. If your function connects to a VPC, this
    /// process can take a minute. During this time, you can't modify the function,
    /// but you can still invoke it. The `LastUpdateStatus`,
    /// `LastUpdateStatusReason`, and `LastUpdateStatusReasonCode` fields in the
    /// response from GetFunctionConfiguration indicate when the update is complete
    /// and the function is processing events with the new configuration. For more
    /// information, see [Lambda function
    /// states](https://docs.aws.amazon.com/lambda/latest/dg/functions-states.html).
    ///
    /// These settings can vary between versions of a function and are locked when
    /// you publish a version. You can't modify the configuration of a published
    /// version, only the unpublished version.
    ///
    /// To configure function concurrency, use PutFunctionConcurrency. To grant
    /// invoke permissions to an Amazon Web Services account or Amazon Web Services
    /// service, use AddPermission.
    pub fn updateFunctionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_function_configuration.UpdateFunctionConfigurationInput, options: CallOptions) !update_function_configuration.UpdateFunctionConfigurationOutput {
        return update_function_configuration.execute(self, allocator, input, options);
    }

    /// Updates the configuration for asynchronous invocation for a function,
    /// version, or alias.
    ///
    /// To configure options for asynchronous invocation, use
    /// PutFunctionEventInvokeConfig.
    pub fn updateFunctionEventInvokeConfig(self: *Self, allocator: std.mem.Allocator, input: update_function_event_invoke_config.UpdateFunctionEventInvokeConfigInput, options: CallOptions) !update_function_event_invoke_config.UpdateFunctionEventInvokeConfigOutput {
        return update_function_event_invoke_config.execute(self, allocator, input, options);
    }

    /// Updates the configuration for a Lambda function URL.
    pub fn updateFunctionUrlConfig(self: *Self, allocator: std.mem.Allocator, input: update_function_url_config.UpdateFunctionUrlConfigInput, options: CallOptions) !update_function_url_config.UpdateFunctionUrlConfigOutput {
        return update_function_url_config.execute(self, allocator, input, options);
    }

    pub fn getDurableExecutionHistoryPaginator(self: *Self, params: get_durable_execution_history.GetDurableExecutionHistoryInput) paginator.GetDurableExecutionHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDurableExecutionStatePaginator(self: *Self, params: get_durable_execution_state.GetDurableExecutionStateInput) paginator.GetDurableExecutionStatePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAliasesPaginator(self: *Self, params: list_aliases.ListAliasesInput) paginator.ListAliasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCapacityProvidersPaginator(self: *Self, params: list_capacity_providers.ListCapacityProvidersInput) paginator.ListCapacityProvidersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCodeSigningConfigsPaginator(self: *Self, params: list_code_signing_configs.ListCodeSigningConfigsInput) paginator.ListCodeSigningConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDurableExecutionsByFunctionPaginator(self: *Self, params: list_durable_executions_by_function.ListDurableExecutionsByFunctionInput) paginator.ListDurableExecutionsByFunctionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventSourceMappingsPaginator(self: *Self, params: list_event_source_mappings.ListEventSourceMappingsInput) paginator.ListEventSourceMappingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFunctionEventInvokeConfigsPaginator(self: *Self, params: list_function_event_invoke_configs.ListFunctionEventInvokeConfigsInput) paginator.ListFunctionEventInvokeConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFunctionUrlConfigsPaginator(self: *Self, params: list_function_url_configs.ListFunctionUrlConfigsInput) paginator.ListFunctionUrlConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFunctionVersionsByCapacityProviderPaginator(self: *Self, params: list_function_versions_by_capacity_provider.ListFunctionVersionsByCapacityProviderInput) paginator.ListFunctionVersionsByCapacityProviderPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFunctionsPaginator(self: *Self, params: list_functions.ListFunctionsInput) paginator.ListFunctionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFunctionsByCodeSigningConfigPaginator(self: *Self, params: list_functions_by_code_signing_config.ListFunctionsByCodeSigningConfigInput) paginator.ListFunctionsByCodeSigningConfigPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLayerVersionsPaginator(self: *Self, params: list_layer_versions.ListLayerVersionsInput) paginator.ListLayerVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLayersPaginator(self: *Self, params: list_layers.ListLayersInput) paginator.ListLayersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProvisionedConcurrencyConfigsPaginator(self: *Self, params: list_provisioned_concurrency_configs.ListProvisionedConcurrencyConfigsInput) paginator.ListProvisionedConcurrencyConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVersionsByFunctionPaginator(self: *Self, params: list_versions_by_function.ListVersionsByFunctionInput) paginator.ListVersionsByFunctionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilFunctionActive(self: *Self, params: get_function_configuration.GetFunctionConfigurationInput) aws.waiter.WaiterError!void {
        var w = waiters.FunctionActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFunctionActiveV2(self: *Self, params: get_function.GetFunctionInput) aws.waiter.WaiterError!void {
        var w = waiters.FunctionActiveV2Waiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFunctionExists(self: *Self, params: get_function.GetFunctionInput) aws.waiter.WaiterError!void {
        var w = waiters.FunctionExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFunctionUpdated(self: *Self, params: get_function_configuration.GetFunctionConfigurationInput) aws.waiter.WaiterError!void {
        var w = waiters.FunctionUpdatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFunctionUpdatedV2(self: *Self, params: get_function.GetFunctionInput) aws.waiter.WaiterError!void {
        var w = waiters.FunctionUpdatedV2Waiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPublishedVersionActive(self: *Self, params: get_function_configuration.GetFunctionConfigurationInput) aws.waiter.WaiterError!void {
        var w = waiters.PublishedVersionActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }
};

const aws = @import("aws");
const std = @import("std");

const associate_resource_types = @import("associate_resource_types.zig");
const batch_get_aggregate_resource_config = @import("batch_get_aggregate_resource_config.zig");
const batch_get_resource_config = @import("batch_get_resource_config.zig");
const delete_aggregation_authorization = @import("delete_aggregation_authorization.zig");
const delete_config_rule = @import("delete_config_rule.zig");
const delete_configuration_aggregator = @import("delete_configuration_aggregator.zig");
const delete_configuration_recorder = @import("delete_configuration_recorder.zig");
const delete_conformance_pack = @import("delete_conformance_pack.zig");
const delete_delivery_channel = @import("delete_delivery_channel.zig");
const delete_evaluation_results = @import("delete_evaluation_results.zig");
const delete_organization_config_rule = @import("delete_organization_config_rule.zig");
const delete_organization_conformance_pack = @import("delete_organization_conformance_pack.zig");
const delete_pending_aggregation_request = @import("delete_pending_aggregation_request.zig");
const delete_remediation_configuration = @import("delete_remediation_configuration.zig");
const delete_remediation_exceptions = @import("delete_remediation_exceptions.zig");
const delete_resource_config = @import("delete_resource_config.zig");
const delete_retention_configuration = @import("delete_retention_configuration.zig");
const delete_service_linked_configuration_recorder = @import("delete_service_linked_configuration_recorder.zig");
const delete_stored_query = @import("delete_stored_query.zig");
const deliver_config_snapshot = @import("deliver_config_snapshot.zig");
const describe_aggregate_compliance_by_config_rules = @import("describe_aggregate_compliance_by_config_rules.zig");
const describe_aggregate_compliance_by_conformance_packs = @import("describe_aggregate_compliance_by_conformance_packs.zig");
const describe_aggregation_authorizations = @import("describe_aggregation_authorizations.zig");
const describe_compliance_by_config_rule = @import("describe_compliance_by_config_rule.zig");
const describe_compliance_by_resource = @import("describe_compliance_by_resource.zig");
const describe_config_rule_evaluation_status = @import("describe_config_rule_evaluation_status.zig");
const describe_config_rules = @import("describe_config_rules.zig");
const describe_configuration_aggregator_sources_status = @import("describe_configuration_aggregator_sources_status.zig");
const describe_configuration_aggregators = @import("describe_configuration_aggregators.zig");
const describe_configuration_recorder_status = @import("describe_configuration_recorder_status.zig");
const describe_configuration_recorders = @import("describe_configuration_recorders.zig");
const describe_conformance_pack_compliance = @import("describe_conformance_pack_compliance.zig");
const describe_conformance_pack_status = @import("describe_conformance_pack_status.zig");
const describe_conformance_packs = @import("describe_conformance_packs.zig");
const describe_delivery_channel_status = @import("describe_delivery_channel_status.zig");
const describe_delivery_channels = @import("describe_delivery_channels.zig");
const describe_organization_config_rule_statuses = @import("describe_organization_config_rule_statuses.zig");
const describe_organization_config_rules = @import("describe_organization_config_rules.zig");
const describe_organization_conformance_pack_statuses = @import("describe_organization_conformance_pack_statuses.zig");
const describe_organization_conformance_packs = @import("describe_organization_conformance_packs.zig");
const describe_pending_aggregation_requests = @import("describe_pending_aggregation_requests.zig");
const describe_remediation_configurations = @import("describe_remediation_configurations.zig");
const describe_remediation_exceptions = @import("describe_remediation_exceptions.zig");
const describe_remediation_execution_status = @import("describe_remediation_execution_status.zig");
const describe_retention_configurations = @import("describe_retention_configurations.zig");
const disassociate_resource_types = @import("disassociate_resource_types.zig");
const get_aggregate_compliance_details_by_config_rule = @import("get_aggregate_compliance_details_by_config_rule.zig");
const get_aggregate_config_rule_compliance_summary = @import("get_aggregate_config_rule_compliance_summary.zig");
const get_aggregate_conformance_pack_compliance_summary = @import("get_aggregate_conformance_pack_compliance_summary.zig");
const get_aggregate_discovered_resource_counts = @import("get_aggregate_discovered_resource_counts.zig");
const get_aggregate_resource_config = @import("get_aggregate_resource_config.zig");
const get_compliance_details_by_config_rule = @import("get_compliance_details_by_config_rule.zig");
const get_compliance_details_by_resource = @import("get_compliance_details_by_resource.zig");
const get_compliance_summary_by_config_rule = @import("get_compliance_summary_by_config_rule.zig");
const get_compliance_summary_by_resource_type = @import("get_compliance_summary_by_resource_type.zig");
const get_conformance_pack_compliance_details = @import("get_conformance_pack_compliance_details.zig");
const get_conformance_pack_compliance_summary = @import("get_conformance_pack_compliance_summary.zig");
const get_custom_rule_policy = @import("get_custom_rule_policy.zig");
const get_discovered_resource_counts = @import("get_discovered_resource_counts.zig");
const get_organization_config_rule_detailed_status = @import("get_organization_config_rule_detailed_status.zig");
const get_organization_conformance_pack_detailed_status = @import("get_organization_conformance_pack_detailed_status.zig");
const get_organization_custom_rule_policy = @import("get_organization_custom_rule_policy.zig");
const get_resource_config_history = @import("get_resource_config_history.zig");
const get_resource_evaluation_summary = @import("get_resource_evaluation_summary.zig");
const get_stored_query = @import("get_stored_query.zig");
const list_aggregate_discovered_resources = @import("list_aggregate_discovered_resources.zig");
const list_configuration_recorders = @import("list_configuration_recorders.zig");
const list_conformance_pack_compliance_scores = @import("list_conformance_pack_compliance_scores.zig");
const list_discovered_resources = @import("list_discovered_resources.zig");
const list_resource_evaluations = @import("list_resource_evaluations.zig");
const list_stored_queries = @import("list_stored_queries.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_aggregation_authorization = @import("put_aggregation_authorization.zig");
const put_config_rule = @import("put_config_rule.zig");
const put_configuration_aggregator = @import("put_configuration_aggregator.zig");
const put_configuration_recorder = @import("put_configuration_recorder.zig");
const put_conformance_pack = @import("put_conformance_pack.zig");
const put_delivery_channel = @import("put_delivery_channel.zig");
const put_evaluations = @import("put_evaluations.zig");
const put_external_evaluation = @import("put_external_evaluation.zig");
const put_organization_config_rule = @import("put_organization_config_rule.zig");
const put_organization_conformance_pack = @import("put_organization_conformance_pack.zig");
const put_remediation_configurations = @import("put_remediation_configurations.zig");
const put_remediation_exceptions = @import("put_remediation_exceptions.zig");
const put_resource_config = @import("put_resource_config.zig");
const put_retention_configuration = @import("put_retention_configuration.zig");
const put_service_linked_configuration_recorder = @import("put_service_linked_configuration_recorder.zig");
const put_stored_query = @import("put_stored_query.zig");
const select_aggregate_resource_config = @import("select_aggregate_resource_config.zig");
const select_resource_config = @import("select_resource_config.zig");
const start_config_rules_evaluation = @import("start_config_rules_evaluation.zig");
const start_configuration_recorder = @import("start_configuration_recorder.zig");
const start_remediation_execution = @import("start_remediation_execution.zig");
const start_resource_evaluation = @import("start_resource_evaluation.zig");
const stop_configuration_recorder = @import("stop_configuration_recorder.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Config Service";

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

    /// Adds all resource types specified in the `ResourceTypes` list to the
    /// [RecordingGroup](https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html) of specified configuration recorder and includes those resource types when recording.
    ///
    /// For this operation, the specified configuration recorder must use a
    /// [RecordingStrategy](https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html) that is either `INCLUSION_BY_RESOURCE_TYPES` or `EXCLUSION_BY_RESOURCE_TYPES`.
    pub fn associateResourceTypes(self: *Self, allocator: std.mem.Allocator, input: associate_resource_types.AssociateResourceTypesInput, options: associate_resource_types.Options) !associate_resource_types.AssociateResourceTypesOutput {
        return associate_resource_types.execute(self, allocator, input, options);
    }

    /// Returns the current configuration items for resources that are present in
    /// your Config aggregator. The operation also returns a list of resources that
    /// are not processed in the current request.
    /// If there are no unprocessed resources, the operation returns an empty
    /// `unprocessedResourceIdentifiers` list.
    ///
    /// * The API does not return results for deleted resources.
    ///
    /// * The API does not return tags and relationships.
    pub fn batchGetAggregateResourceConfig(self: *Self, allocator: std.mem.Allocator, input: batch_get_aggregate_resource_config.BatchGetAggregateResourceConfigInput, options: batch_get_aggregate_resource_config.Options) !batch_get_aggregate_resource_config.BatchGetAggregateResourceConfigOutput {
        return batch_get_aggregate_resource_config.execute(self, allocator, input, options);
    }

    /// Returns the `BaseConfigurationItem` for one or more requested resources.
    /// The operation also returns a list of resources that are
    /// not processed in the current request. If there are no unprocessed
    /// resources, the operation returns an empty unprocessedResourceKeys
    /// list.
    ///
    /// * The API does not return results for deleted
    /// resources.
    ///
    /// * The API does not return any tags for the requested
    /// resources. This information is filtered out of the
    /// supplementaryConfiguration section of the API
    /// response.
    pub fn batchGetResourceConfig(self: *Self, allocator: std.mem.Allocator, input: batch_get_resource_config.BatchGetResourceConfigInput, options: batch_get_resource_config.Options) !batch_get_resource_config.BatchGetResourceConfigOutput {
        return batch_get_resource_config.execute(self, allocator, input, options);
    }

    /// Deletes the authorization granted to the specified
    /// configuration aggregator account in a specified region.
    pub fn deleteAggregationAuthorization(self: *Self, allocator: std.mem.Allocator, input: delete_aggregation_authorization.DeleteAggregationAuthorizationInput, options: delete_aggregation_authorization.Options) !delete_aggregation_authorization.DeleteAggregationAuthorizationOutput {
        return delete_aggregation_authorization.execute(self, allocator, input, options);
    }

    /// Deletes the specified Config rule and all of its evaluation
    /// results.
    ///
    /// Config sets the state of a rule to `DELETING`
    /// until the deletion is complete. You cannot update a rule while it is
    /// in this state. If you make a `PutConfigRule` or
    /// `DeleteConfigRule` request for the rule, you will
    /// receive a `ResourceInUseException`.
    ///
    /// You can check the state of a rule by using the
    /// `DescribeConfigRules` request.
    ///
    /// **Recommendation: Consider excluding the `AWS::Config::ResourceCompliance`
    /// resource type from recording before deleting rules**
    ///
    /// Deleting rules creates configuration items (CIs) for
    /// `AWS::Config::ResourceCompliance`
    /// that can affect your costs for the configuration recorder. If you are
    /// deleting rules which evaluate a large number of resource types,
    /// this can lead to a spike in the number of CIs recorded.
    ///
    /// To avoid the associated costs, you can opt to disable recording
    /// for the `AWS::Config::ResourceCompliance` resource type before deleting
    /// rules, and re-enable recording after the rules have been deleted.
    ///
    /// However, since deleting rules is an asynchronous process, it might take an
    /// hour or more to complete. During the time
    /// when recording is disabled for `AWS::Config::ResourceCompliance`, rule
    /// evaluations will not be recorded in the associated resource’s history.
    pub fn deleteConfigRule(self: *Self, allocator: std.mem.Allocator, input: delete_config_rule.DeleteConfigRuleInput, options: delete_config_rule.Options) !delete_config_rule.DeleteConfigRuleOutput {
        return delete_config_rule.execute(self, allocator, input, options);
    }

    /// Deletes the specified configuration aggregator and the
    /// aggregated data associated with the aggregator.
    pub fn deleteConfigurationAggregator(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_aggregator.DeleteConfigurationAggregatorInput, options: delete_configuration_aggregator.Options) !delete_configuration_aggregator.DeleteConfigurationAggregatorOutput {
        return delete_configuration_aggregator.execute(self, allocator, input, options);
    }

    /// Deletes the customer managed configuration recorder.
    ///
    /// This operation does not delete the configuration information that
    /// was previously recorded. You will be able to access the previously
    /// recorded information by using the
    /// [GetResourceConfigHistory](https://docs.aws.amazon.com/config/latest/APIReference/API_GetResourceConfigHistory.html) operation, but you will not
    /// be able to access this information in the Config console until
    /// you have created a new customer managed configuration recorder.
    pub fn deleteConfigurationRecorder(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_recorder.DeleteConfigurationRecorderInput, options: delete_configuration_recorder.Options) !delete_configuration_recorder.DeleteConfigurationRecorderOutput {
        return delete_configuration_recorder.execute(self, allocator, input, options);
    }

    /// Deletes the specified conformance pack and all the Config rules, remediation
    /// actions, and all evaluation results within that
    /// conformance pack.
    ///
    /// Config sets the conformance pack to `DELETE_IN_PROGRESS` until the deletion
    /// is complete.
    /// You cannot update a conformance pack while it is in this state.
    ///
    /// **Recommendation: Consider excluding the `AWS::Config::ResourceCompliance`
    /// resource type from recording before deleting rules**
    ///
    /// Deleting rules creates configuration items (CIs) for
    /// `AWS::Config::ResourceCompliance`
    /// that can affect your costs for the configuration recorder. If you are
    /// deleting rules which evaluate a large number of resource types,
    /// this can lead to a spike in the number of CIs recorded.
    ///
    /// To avoid the associated costs, you can opt to disable recording
    /// for the `AWS::Config::ResourceCompliance` resource type before deleting
    /// rules, and re-enable recording after the rules have been deleted.
    ///
    /// However, since deleting rules is an asynchronous process, it might take an
    /// hour or more to complete. During the time
    /// when recording is disabled for `AWS::Config::ResourceCompliance`, rule
    /// evaluations will not be recorded in the associated resource’s history.
    pub fn deleteConformancePack(self: *Self, allocator: std.mem.Allocator, input: delete_conformance_pack.DeleteConformancePackInput, options: delete_conformance_pack.Options) !delete_conformance_pack.DeleteConformancePackOutput {
        return delete_conformance_pack.execute(self, allocator, input, options);
    }

    /// Deletes the delivery channel.
    ///
    /// Before you can delete the delivery channel, you must stop the customer
    /// managed configuration recorder. You can use the StopConfigurationRecorder
    /// operation to stop the customer managed configuration recorder.
    pub fn deleteDeliveryChannel(self: *Self, allocator: std.mem.Allocator, input: delete_delivery_channel.DeleteDeliveryChannelInput, options: delete_delivery_channel.Options) !delete_delivery_channel.DeleteDeliveryChannelOutput {
        return delete_delivery_channel.execute(self, allocator, input, options);
    }

    /// Deletes the evaluation results for the specified Config
    /// rule. You can specify one Config rule per request. After you
    /// delete the evaluation results, you can call the StartConfigRulesEvaluation
    /// API to start evaluating
    /// your Amazon Web Services resources against the rule.
    pub fn deleteEvaluationResults(self: *Self, allocator: std.mem.Allocator, input: delete_evaluation_results.DeleteEvaluationResultsInput, options: delete_evaluation_results.Options) !delete_evaluation_results.DeleteEvaluationResultsOutput {
        return delete_evaluation_results.execute(self, allocator, input, options);
    }

    /// Deletes the specified organization Config rule and all of its evaluation
    /// results from all member accounts in that organization.
    ///
    /// Only a management account and a delegated administrator account can delete
    /// an organization Config rule.
    /// When calling this API with a delegated administrator, you must ensure
    /// Organizations
    /// `ListDelegatedAdministrator` permissions are added.
    ///
    /// Config sets the state of a rule to DELETE_IN_PROGRESS until the deletion is
    /// complete.
    /// You cannot update a rule while it is in this state.
    ///
    /// **Recommendation: Consider excluding the `AWS::Config::ResourceCompliance`
    /// resource type from recording before deleting rules**
    ///
    /// Deleting rules creates configuration items (CIs) for
    /// `AWS::Config::ResourceCompliance`
    /// that can affect your costs for the configuration recorder. If you are
    /// deleting rules which evaluate a large number of resource types,
    /// this can lead to a spike in the number of CIs recorded.
    ///
    /// To avoid the associated costs, you can opt to disable recording
    /// for the `AWS::Config::ResourceCompliance` resource type before deleting
    /// rules, and re-enable recording after the rules have been deleted.
    ///
    /// However, since deleting rules is an asynchronous process, it might take an
    /// hour or more to complete. During the time
    /// when recording is disabled for `AWS::Config::ResourceCompliance`, rule
    /// evaluations will not be recorded in the associated resource’s history.
    pub fn deleteOrganizationConfigRule(self: *Self, allocator: std.mem.Allocator, input: delete_organization_config_rule.DeleteOrganizationConfigRuleInput, options: delete_organization_config_rule.Options) !delete_organization_config_rule.DeleteOrganizationConfigRuleOutput {
        return delete_organization_config_rule.execute(self, allocator, input, options);
    }

    /// Deletes the specified organization conformance pack and all of the Config
    /// rules and remediation actions from
    /// all member accounts in that organization.
    ///
    /// Only a management account or a delegated administrator account can delete an
    /// organization conformance pack.
    /// When calling this API with a delegated administrator, you must ensure
    /// Organizations
    /// `ListDelegatedAdministrator` permissions are added.
    ///
    /// Config sets the state of a conformance pack to DELETE_IN_PROGRESS until the
    /// deletion is complete.
    /// You cannot update a conformance pack while it is in this state.
    ///
    /// **Recommendation: Consider excluding the `AWS::Config::ResourceCompliance`
    /// resource type from recording before deleting rules**
    ///
    /// Deleting rules creates configuration items (CIs) for
    /// `AWS::Config::ResourceCompliance`
    /// that can affect your costs for the configuration recorder. If you are
    /// deleting rules which evaluate a large number of resource types,
    /// this can lead to a spike in the number of CIs recorded.
    ///
    /// To avoid the associated costs, you can opt to disable recording
    /// for the `AWS::Config::ResourceCompliance` resource type before deleting
    /// rules, and re-enable recording after the rules have been deleted.
    ///
    /// However, since deleting rules is an asynchronous process, it might take an
    /// hour or more to complete. During the time
    /// when recording is disabled for `AWS::Config::ResourceCompliance`, rule
    /// evaluations will not be recorded in the associated resource’s history.
    pub fn deleteOrganizationConformancePack(self: *Self, allocator: std.mem.Allocator, input: delete_organization_conformance_pack.DeleteOrganizationConformancePackInput, options: delete_organization_conformance_pack.Options) !delete_organization_conformance_pack.DeleteOrganizationConformancePackOutput {
        return delete_organization_conformance_pack.execute(self, allocator, input, options);
    }

    /// Deletes pending authorization requests for a specified
    /// aggregator account in a specified region.
    pub fn deletePendingAggregationRequest(self: *Self, allocator: std.mem.Allocator, input: delete_pending_aggregation_request.DeletePendingAggregationRequestInput, options: delete_pending_aggregation_request.Options) !delete_pending_aggregation_request.DeletePendingAggregationRequestOutput {
        return delete_pending_aggregation_request.execute(self, allocator, input, options);
    }

    /// Deletes the remediation configuration.
    pub fn deleteRemediationConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_remediation_configuration.DeleteRemediationConfigurationInput, options: delete_remediation_configuration.Options) !delete_remediation_configuration.DeleteRemediationConfigurationOutput {
        return delete_remediation_configuration.execute(self, allocator, input, options);
    }

    /// Deletes one or more remediation exceptions mentioned in the resource keys.
    ///
    /// Config generates a remediation exception when a problem occurs executing a
    /// remediation action to a specific resource.
    /// Remediation exceptions blocks auto-remediation until the exception is
    /// cleared.
    pub fn deleteRemediationExceptions(self: *Self, allocator: std.mem.Allocator, input: delete_remediation_exceptions.DeleteRemediationExceptionsInput, options: delete_remediation_exceptions.Options) !delete_remediation_exceptions.DeleteRemediationExceptionsOutput {
        return delete_remediation_exceptions.execute(self, allocator, input, options);
    }

    /// Records the configuration state for a custom resource that has been deleted.
    /// This API records a new ConfigurationItem with a ResourceDeleted status. You
    /// can retrieve the ConfigurationItems recorded for this resource in your
    /// Config History.
    pub fn deleteResourceConfig(self: *Self, allocator: std.mem.Allocator, input: delete_resource_config.DeleteResourceConfigInput, options: delete_resource_config.Options) !delete_resource_config.DeleteResourceConfigOutput {
        return delete_resource_config.execute(self, allocator, input, options);
    }

    /// Deletes the retention configuration.
    pub fn deleteRetentionConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_retention_configuration.DeleteRetentionConfigurationInput, options: delete_retention_configuration.Options) !delete_retention_configuration.DeleteRetentionConfigurationOutput {
        return delete_retention_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an existing service-linked configuration recorder.
    ///
    /// This operation does not delete the configuration information that was
    /// previously recorded. You will be able to access the previously
    /// recorded information by using the
    /// [GetResourceConfigHistory](https://docs.aws.amazon.com/config/latest/APIReference/API_GetResourceConfigHistory.html) operation, but you will not
    /// be able to access this information in the Config console until
    /// you have created a new service-linked configuration recorder for the same
    /// service.
    ///
    /// **The recording scope determines if you receive configuration items**
    ///
    /// The recording scope is set by the service that is linked to the
    /// configuration recorder and determines whether you receive configuration
    /// items (CIs) in the delivery channel. If the recording scope is internal, you
    /// will not receive CIs in the delivery channel.
    pub fn deleteServiceLinkedConfigurationRecorder(self: *Self, allocator: std.mem.Allocator, input: delete_service_linked_configuration_recorder.DeleteServiceLinkedConfigurationRecorderInput, options: delete_service_linked_configuration_recorder.Options) !delete_service_linked_configuration_recorder.DeleteServiceLinkedConfigurationRecorderOutput {
        return delete_service_linked_configuration_recorder.execute(self, allocator, input, options);
    }

    /// Deletes the stored query for a single Amazon Web Services account and a
    /// single Amazon Web Services Region.
    pub fn deleteStoredQuery(self: *Self, allocator: std.mem.Allocator, input: delete_stored_query.DeleteStoredQueryInput, options: delete_stored_query.Options) !delete_stored_query.DeleteStoredQueryOutput {
        return delete_stored_query.execute(self, allocator, input, options);
    }

    /// Schedules delivery of a configuration snapshot to the Amazon S3
    /// bucket in the specified delivery channel. After the delivery has
    /// started, Config sends the following notifications using an
    /// Amazon SNS topic that you have specified.
    ///
    /// * Notification of the start of the delivery.
    ///
    /// * Notification of the completion of the delivery, if the
    /// delivery was successfully completed.
    ///
    /// * Notification of delivery failure, if the delivery
    /// failed.
    pub fn deliverConfigSnapshot(self: *Self, allocator: std.mem.Allocator, input: deliver_config_snapshot.DeliverConfigSnapshotInput, options: deliver_config_snapshot.Options) !deliver_config_snapshot.DeliverConfigSnapshotOutput {
        return deliver_config_snapshot.execute(self, allocator, input, options);
    }

    /// Returns a list of compliant and noncompliant rules with the
    /// number of resources for compliant and noncompliant rules. Does not display
    /// rules that do not have compliance results.
    ///
    /// The results can return an empty result page, but if you
    /// have a `nextToken`, the results are displayed on the next
    /// page.
    pub fn describeAggregateComplianceByConfigRules(self: *Self, allocator: std.mem.Allocator, input: describe_aggregate_compliance_by_config_rules.DescribeAggregateComplianceByConfigRulesInput, options: describe_aggregate_compliance_by_config_rules.Options) !describe_aggregate_compliance_by_config_rules.DescribeAggregateComplianceByConfigRulesOutput {
        return describe_aggregate_compliance_by_config_rules.execute(self, allocator, input, options);
    }

    /// Returns a list of the existing and deleted conformance packs and their
    /// associated compliance status with the count of compliant and noncompliant
    /// Config rules within each
    /// conformance pack. Also returns the total rule count which includes compliant
    /// rules, noncompliant rules, and rules that cannot be evaluated due to
    /// insufficient data.
    ///
    /// The results can return an empty result page, but if you have a `nextToken`,
    /// the results are displayed on the next page.
    pub fn describeAggregateComplianceByConformancePacks(self: *Self, allocator: std.mem.Allocator, input: describe_aggregate_compliance_by_conformance_packs.DescribeAggregateComplianceByConformancePacksInput, options: describe_aggregate_compliance_by_conformance_packs.Options) !describe_aggregate_compliance_by_conformance_packs.DescribeAggregateComplianceByConformancePacksOutput {
        return describe_aggregate_compliance_by_conformance_packs.execute(self, allocator, input, options);
    }

    /// Returns a list of authorizations granted to various aggregator
    /// accounts and regions.
    pub fn describeAggregationAuthorizations(self: *Self, allocator: std.mem.Allocator, input: describe_aggregation_authorizations.DescribeAggregationAuthorizationsInput, options: describe_aggregation_authorizations.Options) !describe_aggregation_authorizations.DescribeAggregationAuthorizationsOutput {
        return describe_aggregation_authorizations.execute(self, allocator, input, options);
    }

    /// Indicates whether the specified Config rules are compliant.
    /// If a rule is noncompliant, this operation returns the number of Amazon Web
    /// Services
    /// resources that do not comply with the rule.
    ///
    /// A rule is compliant if all of the evaluated resources comply
    /// with it. It is noncompliant if any of these resources do not
    /// comply.
    ///
    /// If Config has no current evaluation results for the rule,
    /// it returns `INSUFFICIENT_DATA`. This result might
    /// indicate one of the following conditions:
    ///
    /// * Config has never invoked an evaluation for the
    /// rule. To check whether it has, use the
    /// `DescribeConfigRuleEvaluationStatus` action
    /// to get the `LastSuccessfulInvocationTime` and
    /// `LastFailedInvocationTime`.
    ///
    /// * The rule's Lambda function is failing to send
    /// evaluation results to Config. Verify that the role you
    /// assigned to your configuration recorder includes the
    /// `config:PutEvaluations` permission. If the
    /// rule is a custom rule, verify that the Lambda execution
    /// role includes the `config:PutEvaluations`
    /// permission.
    ///
    /// * The rule's Lambda function has returned
    /// `NOT_APPLICABLE` for all evaluation results.
    /// This can occur if the resources were deleted or removed from
    /// the rule's scope.
    pub fn describeComplianceByConfigRule(self: *Self, allocator: std.mem.Allocator, input: describe_compliance_by_config_rule.DescribeComplianceByConfigRuleInput, options: describe_compliance_by_config_rule.Options) !describe_compliance_by_config_rule.DescribeComplianceByConfigRuleOutput {
        return describe_compliance_by_config_rule.execute(self, allocator, input, options);
    }

    /// Indicates whether the specified Amazon Web Services resources are compliant.
    /// If
    /// a resource is noncompliant, this operation returns the number of Config
    /// rules that the resource does not comply with.
    ///
    /// A resource is compliant if it complies with all the Config
    /// rules that evaluate it. It is noncompliant if it does not comply
    /// with one or more of these rules.
    ///
    /// If Config has no current evaluation results for the
    /// resource, it returns `INSUFFICIENT_DATA`. This result
    /// might indicate one of the following conditions about the rules that
    /// evaluate the resource:
    ///
    /// * Config has never invoked an evaluation for the
    /// rule. To check whether it has, use the
    /// `DescribeConfigRuleEvaluationStatus` action
    /// to get the `LastSuccessfulInvocationTime` and
    /// `LastFailedInvocationTime`.
    ///
    /// * The rule's Lambda function is failing to send
    /// evaluation results to Config. Verify that the role that
    /// you assigned to your configuration recorder includes the
    /// `config:PutEvaluations` permission. If the
    /// rule is a custom rule, verify that the Lambda execution
    /// role includes the `config:PutEvaluations`
    /// permission.
    ///
    /// * The rule's Lambda function has returned
    /// `NOT_APPLICABLE` for all evaluation results.
    /// This can occur if the resources were deleted or removed from
    /// the rule's scope.
    pub fn describeComplianceByResource(self: *Self, allocator: std.mem.Allocator, input: describe_compliance_by_resource.DescribeComplianceByResourceInput, options: describe_compliance_by_resource.Options) !describe_compliance_by_resource.DescribeComplianceByResourceOutput {
        return describe_compliance_by_resource.execute(self, allocator, input, options);
    }

    /// Returns status information for each of your Config managed rules. The status
    /// includes information such as the last time Config invoked the rule, the last
    /// time Config failed to invoke
    /// the rule, and the related error for the last failure.
    pub fn describeConfigRuleEvaluationStatus(self: *Self, allocator: std.mem.Allocator, input: describe_config_rule_evaluation_status.DescribeConfigRuleEvaluationStatusInput, options: describe_config_rule_evaluation_status.Options) !describe_config_rule_evaluation_status.DescribeConfigRuleEvaluationStatusOutput {
        return describe_config_rule_evaluation_status.execute(self, allocator, input, options);
    }

    /// Returns details about your Config rules.
    pub fn describeConfigRules(self: *Self, allocator: std.mem.Allocator, input: describe_config_rules.DescribeConfigRulesInput, options: describe_config_rules.Options) !describe_config_rules.DescribeConfigRulesOutput {
        return describe_config_rules.execute(self, allocator, input, options);
    }

    /// Returns status information for sources within an aggregator.
    /// The status includes information about the last time Config verified
    /// authorization between the source account and an aggregator account. In case
    /// of a failure, the status contains the related error code or message.
    pub fn describeConfigurationAggregatorSourcesStatus(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_aggregator_sources_status.DescribeConfigurationAggregatorSourcesStatusInput, options: describe_configuration_aggregator_sources_status.Options) !describe_configuration_aggregator_sources_status.DescribeConfigurationAggregatorSourcesStatusOutput {
        return describe_configuration_aggregator_sources_status.execute(self, allocator, input, options);
    }

    /// Returns the details of one or more configuration aggregators.
    /// If the configuration aggregator is not specified, this operation
    /// returns the details for all the configuration aggregators associated
    /// with the account.
    pub fn describeConfigurationAggregators(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_aggregators.DescribeConfigurationAggregatorsInput, options: describe_configuration_aggregators.Options) !describe_configuration_aggregators.DescribeConfigurationAggregatorsOutput {
        return describe_configuration_aggregators.execute(self, allocator, input, options);
    }

    /// Returns the current status of the configuration
    /// recorder you specify as well as the status of the last recording event for
    /// the configuration recorders.
    ///
    /// For a detailed status of recording events over time, add your Config events
    /// to Amazon CloudWatch metrics and use CloudWatch metrics.
    ///
    /// If a configuration recorder is not specified, this operation returns the
    /// status for the customer managed configuration recorder configured for the
    /// account, if applicable.
    ///
    /// When making a request to this operation, you can only specify one
    /// configuration recorder.
    pub fn describeConfigurationRecorderStatus(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_recorder_status.DescribeConfigurationRecorderStatusInput, options: describe_configuration_recorder_status.Options) !describe_configuration_recorder_status.DescribeConfigurationRecorderStatusOutput {
        return describe_configuration_recorder_status.execute(self, allocator, input, options);
    }

    /// Returns details for the configuration recorder you specify.
    ///
    /// If a configuration recorder is not specified, this operation returns details
    /// for the customer managed configuration recorder configured for the
    /// account, if applicable.
    ///
    /// When making a request to this operation, you can only specify one
    /// configuration recorder.
    pub fn describeConfigurationRecorders(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_recorders.DescribeConfigurationRecordersInput, options: describe_configuration_recorders.Options) !describe_configuration_recorders.DescribeConfigurationRecordersOutput {
        return describe_configuration_recorders.execute(self, allocator, input, options);
    }

    /// Returns compliance details for each rule in that conformance pack.
    ///
    /// You must provide exact rule names.
    pub fn describeConformancePackCompliance(self: *Self, allocator: std.mem.Allocator, input: describe_conformance_pack_compliance.DescribeConformancePackComplianceInput, options: describe_conformance_pack_compliance.Options) !describe_conformance_pack_compliance.DescribeConformancePackComplianceOutput {
        return describe_conformance_pack_compliance.execute(self, allocator, input, options);
    }

    /// Provides one or more conformance packs deployment status.
    ///
    /// If there are no conformance packs then you will see an empty result.
    pub fn describeConformancePackStatus(self: *Self, allocator: std.mem.Allocator, input: describe_conformance_pack_status.DescribeConformancePackStatusInput, options: describe_conformance_pack_status.Options) !describe_conformance_pack_status.DescribeConformancePackStatusOutput {
        return describe_conformance_pack_status.execute(self, allocator, input, options);
    }

    /// Returns a list of one or more conformance packs.
    pub fn describeConformancePacks(self: *Self, allocator: std.mem.Allocator, input: describe_conformance_packs.DescribeConformancePacksInput, options: describe_conformance_packs.Options) !describe_conformance_packs.DescribeConformancePacksOutput {
        return describe_conformance_packs.execute(self, allocator, input, options);
    }

    /// Returns the current status of the specified delivery channel.
    /// If a delivery channel is not specified, this operation returns the
    /// current status of all delivery channels associated with the
    /// account.
    ///
    /// Currently, you can specify only one delivery channel per
    /// region in your account.
    pub fn describeDeliveryChannelStatus(self: *Self, allocator: std.mem.Allocator, input: describe_delivery_channel_status.DescribeDeliveryChannelStatusInput, options: describe_delivery_channel_status.Options) !describe_delivery_channel_status.DescribeDeliveryChannelStatusOutput {
        return describe_delivery_channel_status.execute(self, allocator, input, options);
    }

    /// Returns details about the specified delivery channel. If a
    /// delivery channel is not specified, this operation returns the details
    /// of all delivery channels associated with the account.
    ///
    /// Currently, you can specify only one delivery channel per
    /// region in your account.
    pub fn describeDeliveryChannels(self: *Self, allocator: std.mem.Allocator, input: describe_delivery_channels.DescribeDeliveryChannelsInput, options: describe_delivery_channels.Options) !describe_delivery_channels.DescribeDeliveryChannelsOutput {
        return describe_delivery_channels.execute(self, allocator, input, options);
    }

    /// Provides organization Config rule deployment status for an organization.
    ///
    /// The status is not considered successful until organization Config rule is
    /// successfully deployed in all the member
    /// accounts with an exception of excluded accounts.
    ///
    /// When you specify the limit and the next token, you receive a paginated
    /// response.
    /// Limit and next token are not applicable if you specify organization Config
    /// rule names.
    /// It is only applicable, when you request all the organization Config rules.
    pub fn describeOrganizationConfigRuleStatuses(self: *Self, allocator: std.mem.Allocator, input: describe_organization_config_rule_statuses.DescribeOrganizationConfigRuleStatusesInput, options: describe_organization_config_rule_statuses.Options) !describe_organization_config_rule_statuses.DescribeOrganizationConfigRuleStatusesOutput {
        return describe_organization_config_rule_statuses.execute(self, allocator, input, options);
    }

    /// Returns a list of organization Config rules.
    ///
    /// When you specify the limit and the next token, you receive a paginated
    /// response.
    ///
    /// Limit and next token are not applicable if you specify organization Config
    /// rule names.
    /// It is only applicable, when you request all the organization Config rules.
    ///
    /// *For accounts within an organization*
    ///
    /// If you deploy an organizational rule or conformance pack in an organization
    /// administrator account, and then establish a delegated administrator and
    /// deploy an
    /// organizational rule or conformance pack in the delegated administrator
    /// account, you
    /// won't be able to see the organizational rule or conformance pack in the
    /// organization
    /// administrator account from the delegated administrator account or see the
    /// organizational
    /// rule or conformance pack in the delegated administrator account from
    /// organization
    /// administrator account. The `DescribeOrganizationConfigRules` and
    /// `DescribeOrganizationConformancePacks` APIs can only see and interact with
    /// the organization-related resource that were deployed from within the account
    /// calling
    /// those APIs.
    pub fn describeOrganizationConfigRules(self: *Self, allocator: std.mem.Allocator, input: describe_organization_config_rules.DescribeOrganizationConfigRulesInput, options: describe_organization_config_rules.Options) !describe_organization_config_rules.DescribeOrganizationConfigRulesOutput {
        return describe_organization_config_rules.execute(self, allocator, input, options);
    }

    /// Provides organization conformance pack deployment status for an
    /// organization.
    ///
    /// The status is not considered successful until organization conformance pack
    /// is successfully
    /// deployed in all the member accounts with an exception of excluded accounts.
    ///
    /// When you specify the limit and the next token, you receive a paginated
    /// response.
    /// Limit and next token are not applicable if you specify organization
    /// conformance pack names.
    /// They are only applicable, when you request all the organization conformance
    /// packs.
    pub fn describeOrganizationConformancePackStatuses(self: *Self, allocator: std.mem.Allocator, input: describe_organization_conformance_pack_statuses.DescribeOrganizationConformancePackStatusesInput, options: describe_organization_conformance_pack_statuses.Options) !describe_organization_conformance_pack_statuses.DescribeOrganizationConformancePackStatusesOutput {
        return describe_organization_conformance_pack_statuses.execute(self, allocator, input, options);
    }

    /// Returns a list of organization conformance packs.
    ///
    /// When you specify the limit and the next token, you receive a paginated
    /// response.
    ///
    /// Limit and next token are not applicable if you specify organization
    /// conformance packs names. They are only applicable,
    /// when you request all the organization conformance packs.
    ///
    /// *For accounts within an organization*
    ///
    /// If you deploy an organizational rule or conformance pack in an organization
    /// administrator account, and then establish a delegated administrator and
    /// deploy an
    /// organizational rule or conformance pack in the delegated administrator
    /// account, you
    /// won't be able to see the organizational rule or conformance pack in the
    /// organization
    /// administrator account from the delegated administrator account or see the
    /// organizational
    /// rule or conformance pack in the delegated administrator account from
    /// organization
    /// administrator account. The `DescribeOrganizationConfigRules` and
    /// `DescribeOrganizationConformancePacks` APIs can only see and interact with
    /// the organization-related resource that were deployed from within the account
    /// calling
    /// those APIs.
    pub fn describeOrganizationConformancePacks(self: *Self, allocator: std.mem.Allocator, input: describe_organization_conformance_packs.DescribeOrganizationConformancePacksInput, options: describe_organization_conformance_packs.Options) !describe_organization_conformance_packs.DescribeOrganizationConformancePacksOutput {
        return describe_organization_conformance_packs.execute(self, allocator, input, options);
    }

    /// Returns a list of all pending aggregation requests.
    pub fn describePendingAggregationRequests(self: *Self, allocator: std.mem.Allocator, input: describe_pending_aggregation_requests.DescribePendingAggregationRequestsInput, options: describe_pending_aggregation_requests.Options) !describe_pending_aggregation_requests.DescribePendingAggregationRequestsOutput {
        return describe_pending_aggregation_requests.execute(self, allocator, input, options);
    }

    /// Returns the details of one or more remediation configurations.
    pub fn describeRemediationConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_remediation_configurations.DescribeRemediationConfigurationsInput, options: describe_remediation_configurations.Options) !describe_remediation_configurations.DescribeRemediationConfigurationsOutput {
        return describe_remediation_configurations.execute(self, allocator, input, options);
    }

    /// Returns the details of one or more remediation exceptions. A detailed view
    /// of a remediation exception for a set of resources that includes an
    /// explanation of an exception and the time when the exception will be deleted.
    /// When you specify the limit and the next token, you receive a paginated
    /// response.
    ///
    /// Config generates a remediation exception when a problem occurs executing a
    /// remediation action to a specific resource.
    /// Remediation exceptions blocks auto-remediation until the exception is
    /// cleared.
    ///
    /// When you specify the limit and the next token, you receive a paginated
    /// response.
    ///
    /// Limit and next token are not applicable if you request resources in batch.
    /// It is only applicable, when you request all resources.
    pub fn describeRemediationExceptions(self: *Self, allocator: std.mem.Allocator, input: describe_remediation_exceptions.DescribeRemediationExceptionsInput, options: describe_remediation_exceptions.Options) !describe_remediation_exceptions.DescribeRemediationExceptionsOutput {
        return describe_remediation_exceptions.execute(self, allocator, input, options);
    }

    /// Provides a detailed view of a Remediation Execution for a set of resources
    /// including state, timestamps for when steps for the remediation execution
    /// occur, and any error messages for steps that have failed.
    /// When you specify the limit and the next token, you receive a paginated
    /// response.
    pub fn describeRemediationExecutionStatus(self: *Self, allocator: std.mem.Allocator, input: describe_remediation_execution_status.DescribeRemediationExecutionStatusInput, options: describe_remediation_execution_status.Options) !describe_remediation_execution_status.DescribeRemediationExecutionStatusOutput {
        return describe_remediation_execution_status.execute(self, allocator, input, options);
    }

    /// Returns the details of one or more retention configurations. If
    /// the retention configuration name is not specified, this operation
    /// returns the details for all the retention configurations for that
    /// account.
    ///
    /// Currently, Config supports only one retention
    /// configuration per region in your account.
    pub fn describeRetentionConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_retention_configurations.DescribeRetentionConfigurationsInput, options: describe_retention_configurations.Options) !describe_retention_configurations.DescribeRetentionConfigurationsOutput {
        return describe_retention_configurations.execute(self, allocator, input, options);
    }

    /// Removes all resource types specified in the `ResourceTypes` list from the
    /// [RecordingGroup](https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html) of configuration recorder and excludes these resource types when recording.
    ///
    /// For this operation, the configuration recorder must use a
    /// [RecordingStrategy](https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html) that is either `INCLUSION_BY_RESOURCE_TYPES` or `EXCLUSION_BY_RESOURCE_TYPES`.
    pub fn disassociateResourceTypes(self: *Self, allocator: std.mem.Allocator, input: disassociate_resource_types.DisassociateResourceTypesInput, options: disassociate_resource_types.Options) !disassociate_resource_types.DisassociateResourceTypesOutput {
        return disassociate_resource_types.execute(self, allocator, input, options);
    }

    /// Returns the evaluation results for the specified Config
    /// rule for a specific resource in a rule. The results indicate which
    /// Amazon Web Services resources were evaluated by the rule, when each resource
    /// was
    /// last evaluated, and whether each resource complies with the rule.
    ///
    /// The results can return an empty result page. But if you
    /// have a `nextToken`, the results are displayed on the next
    /// page.
    pub fn getAggregateComplianceDetailsByConfigRule(self: *Self, allocator: std.mem.Allocator, input: get_aggregate_compliance_details_by_config_rule.GetAggregateComplianceDetailsByConfigRuleInput, options: get_aggregate_compliance_details_by_config_rule.Options) !get_aggregate_compliance_details_by_config_rule.GetAggregateComplianceDetailsByConfigRuleOutput {
        return get_aggregate_compliance_details_by_config_rule.execute(self, allocator, input, options);
    }

    /// Returns the number of compliant and noncompliant rules for one
    /// or more accounts and regions in an aggregator.
    ///
    /// The results can return an empty result page, but if you
    /// have a nextToken, the results are displayed on the next
    /// page.
    pub fn getAggregateConfigRuleComplianceSummary(self: *Self, allocator: std.mem.Allocator, input: get_aggregate_config_rule_compliance_summary.GetAggregateConfigRuleComplianceSummaryInput, options: get_aggregate_config_rule_compliance_summary.Options) !get_aggregate_config_rule_compliance_summary.GetAggregateConfigRuleComplianceSummaryOutput {
        return get_aggregate_config_rule_compliance_summary.execute(self, allocator, input, options);
    }

    /// Returns the count of compliant and noncompliant conformance packs across all
    /// Amazon Web Services accounts and Amazon Web Services Regions in an
    /// aggregator. You can filter based on Amazon Web Services account ID or Amazon
    /// Web Services Region.
    ///
    /// The results can return an empty result page, but if you have a nextToken,
    /// the results are displayed on the next page.
    pub fn getAggregateConformancePackComplianceSummary(self: *Self, allocator: std.mem.Allocator, input: get_aggregate_conformance_pack_compliance_summary.GetAggregateConformancePackComplianceSummaryInput, options: get_aggregate_conformance_pack_compliance_summary.Options) !get_aggregate_conformance_pack_compliance_summary.GetAggregateConformancePackComplianceSummaryOutput {
        return get_aggregate_conformance_pack_compliance_summary.execute(self, allocator, input, options);
    }

    /// Returns the resource counts across accounts and regions that are present in
    /// your Config aggregator. You can request the resource counts by providing
    /// filters and GroupByKey.
    ///
    /// For example, if the input contains accountID 12345678910 and region
    /// us-east-1 in filters, the API returns the count of resources in account ID
    /// 12345678910 and region us-east-1.
    /// If the input contains ACCOUNT_ID as a GroupByKey, the API returns resource
    /// counts for all source accounts that are present in your aggregator.
    pub fn getAggregateDiscoveredResourceCounts(self: *Self, allocator: std.mem.Allocator, input: get_aggregate_discovered_resource_counts.GetAggregateDiscoveredResourceCountsInput, options: get_aggregate_discovered_resource_counts.Options) !get_aggregate_discovered_resource_counts.GetAggregateDiscoveredResourceCountsOutput {
        return get_aggregate_discovered_resource_counts.execute(self, allocator, input, options);
    }

    /// Returns configuration item that is aggregated for your specific resource in
    /// a specific source account and region.
    ///
    /// The API does not return results for deleted resources.
    pub fn getAggregateResourceConfig(self: *Self, allocator: std.mem.Allocator, input: get_aggregate_resource_config.GetAggregateResourceConfigInput, options: get_aggregate_resource_config.Options) !get_aggregate_resource_config.GetAggregateResourceConfigOutput {
        return get_aggregate_resource_config.execute(self, allocator, input, options);
    }

    /// Returns the evaluation results for the specified Config
    /// rule. The results indicate which Amazon Web Services resources were
    /// evaluated by the
    /// rule, when each resource was last evaluated, and whether each
    /// resource complies with the rule.
    pub fn getComplianceDetailsByConfigRule(self: *Self, allocator: std.mem.Allocator, input: get_compliance_details_by_config_rule.GetComplianceDetailsByConfigRuleInput, options: get_compliance_details_by_config_rule.Options) !get_compliance_details_by_config_rule.GetComplianceDetailsByConfigRuleOutput {
        return get_compliance_details_by_config_rule.execute(self, allocator, input, options);
    }

    /// Returns the evaluation results for the specified Amazon Web Services
    /// resource.
    /// The results indicate which Config rules were used to evaluate
    /// the resource, when each rule was last invoked, and whether the resource
    /// complies with each rule.
    pub fn getComplianceDetailsByResource(self: *Self, allocator: std.mem.Allocator, input: get_compliance_details_by_resource.GetComplianceDetailsByResourceInput, options: get_compliance_details_by_resource.Options) !get_compliance_details_by_resource.GetComplianceDetailsByResourceOutput {
        return get_compliance_details_by_resource.execute(self, allocator, input, options);
    }

    /// Returns the number of Config rules that are compliant and
    /// noncompliant, up to a maximum of 25 for each.
    pub fn getComplianceSummaryByConfigRule(self: *Self, allocator: std.mem.Allocator, input: get_compliance_summary_by_config_rule.GetComplianceSummaryByConfigRuleInput, options: get_compliance_summary_by_config_rule.Options) !get_compliance_summary_by_config_rule.GetComplianceSummaryByConfigRuleOutput {
        return get_compliance_summary_by_config_rule.execute(self, allocator, input, options);
    }

    /// Returns the number of resources that are compliant and the
    /// number that are noncompliant. You can specify one or more resource
    /// types to get these numbers for each resource type. The maximum
    /// number returned is 100.
    pub fn getComplianceSummaryByResourceType(self: *Self, allocator: std.mem.Allocator, input: get_compliance_summary_by_resource_type.GetComplianceSummaryByResourceTypeInput, options: get_compliance_summary_by_resource_type.Options) !get_compliance_summary_by_resource_type.GetComplianceSummaryByResourceTypeOutput {
        return get_compliance_summary_by_resource_type.execute(self, allocator, input, options);
    }

    /// Returns compliance details of a conformance pack for all Amazon Web Services
    /// resources that are monitered by conformance pack.
    pub fn getConformancePackComplianceDetails(self: *Self, allocator: std.mem.Allocator, input: get_conformance_pack_compliance_details.GetConformancePackComplianceDetailsInput, options: get_conformance_pack_compliance_details.Options) !get_conformance_pack_compliance_details.GetConformancePackComplianceDetailsOutput {
        return get_conformance_pack_compliance_details.execute(self, allocator, input, options);
    }

    /// Returns compliance details for the conformance pack based on the cumulative
    /// compliance results of all the rules in that conformance pack.
    pub fn getConformancePackComplianceSummary(self: *Self, allocator: std.mem.Allocator, input: get_conformance_pack_compliance_summary.GetConformancePackComplianceSummaryInput, options: get_conformance_pack_compliance_summary.Options) !get_conformance_pack_compliance_summary.GetConformancePackComplianceSummaryOutput {
        return get_conformance_pack_compliance_summary.execute(self, allocator, input, options);
    }

    /// Returns the policy definition containing the logic for your Config Custom
    /// Policy rule.
    pub fn getCustomRulePolicy(self: *Self, allocator: std.mem.Allocator, input: get_custom_rule_policy.GetCustomRulePolicyInput, options: get_custom_rule_policy.Options) !get_custom_rule_policy.GetCustomRulePolicyOutput {
        return get_custom_rule_policy.execute(self, allocator, input, options);
    }

    /// Returns the resource types, the number of each resource type,
    /// and the total number of resources that Config is recording in
    /// this region for your Amazon Web Services account.
    ///
    /// **Example**
    ///
    /// * Config is recording three resource types in the US
    /// East (Ohio) Region for your account: 25 EC2 instances, 20
    /// IAM users, and 15 S3 buckets.
    ///
    /// * You make a call to the
    /// `GetDiscoveredResourceCounts` action and
    /// specify that you want all resource types.
    ///
    /// * Config returns the following:
    ///
    /// * The resource types (EC2 instances, IAM users,
    /// and S3 buckets).
    ///
    /// * The number of each resource type (25, 20, and
    /// 15).
    ///
    /// * The total number of all resources
    /// (60).
    ///
    /// The response is paginated. By default, Config lists 100
    /// ResourceCount objects on each page. You can
    /// customize this number with the `limit` parameter. The
    /// response includes a `nextToken` string. To get the next
    /// page of results, run the request again and specify the string for
    /// the `nextToken` parameter.
    ///
    /// If you make a call to the GetDiscoveredResourceCounts action, you might
    /// not immediately receive resource counts in the following
    /// situations:
    ///
    /// * You are a new Config customer.
    ///
    /// * You just enabled resource recording.
    ///
    /// It might take a few minutes for Config to record and
    /// count your resources. Wait a few minutes and then retry the
    /// GetDiscoveredResourceCounts action.
    pub fn getDiscoveredResourceCounts(self: *Self, allocator: std.mem.Allocator, input: get_discovered_resource_counts.GetDiscoveredResourceCountsInput, options: get_discovered_resource_counts.Options) !get_discovered_resource_counts.GetDiscoveredResourceCountsOutput {
        return get_discovered_resource_counts.execute(self, allocator, input, options);
    }

    /// Returns detailed status for each member account within an organization for a
    /// given organization Config rule.
    pub fn getOrganizationConfigRuleDetailedStatus(self: *Self, allocator: std.mem.Allocator, input: get_organization_config_rule_detailed_status.GetOrganizationConfigRuleDetailedStatusInput, options: get_organization_config_rule_detailed_status.Options) !get_organization_config_rule_detailed_status.GetOrganizationConfigRuleDetailedStatusOutput {
        return get_organization_config_rule_detailed_status.execute(self, allocator, input, options);
    }

    /// Returns detailed status for each member account within an organization for a
    /// given organization conformance pack.
    pub fn getOrganizationConformancePackDetailedStatus(self: *Self, allocator: std.mem.Allocator, input: get_organization_conformance_pack_detailed_status.GetOrganizationConformancePackDetailedStatusInput, options: get_organization_conformance_pack_detailed_status.Options) !get_organization_conformance_pack_detailed_status.GetOrganizationConformancePackDetailedStatusOutput {
        return get_organization_conformance_pack_detailed_status.execute(self, allocator, input, options);
    }

    /// Returns the policy definition containing the logic for your organization
    /// Config Custom Policy rule.
    pub fn getOrganizationCustomRulePolicy(self: *Self, allocator: std.mem.Allocator, input: get_organization_custom_rule_policy.GetOrganizationCustomRulePolicyInput, options: get_organization_custom_rule_policy.Options) !get_organization_custom_rule_policy.GetOrganizationCustomRulePolicyOutput {
        return get_organization_custom_rule_policy.execute(self, allocator, input, options);
    }

    /// For accurate reporting on the compliance status, you must record the
    /// `AWS::Config::ResourceCompliance` resource type.
    ///
    /// For more information, see [Recording Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/config/latest/developerguide/select-resources.html) in the *Config Resources Developer Guide*.
    ///
    /// Returns a list of configurations items (CIs) for the specified resource.
    ///
    /// **Contents**
    ///
    /// The list contains details about each state of the resource
    /// during the specified time interval. If you specified a retention
    /// period to retain your CIs between a
    /// minimum of 30 days and a maximum of 7 years (2557 days), Config
    /// returns the CIs for the specified
    /// retention period.
    ///
    /// **Pagination**
    ///
    /// The response is paginated. By default, Config returns a
    /// limit of 10 configuration items per page. You can customize this
    /// number with the `limit` parameter. The response includes
    /// a `nextToken` string. To get the next page of results,
    /// run the request again and specify the string for the
    /// `nextToken` parameter.
    ///
    /// Each call to the API is limited to span a duration of seven
    /// days. It is likely that the number of records returned is
    /// smaller than the specified `limit`. In such cases,
    /// you can make another call, using the
    /// `nextToken`.
    pub fn getResourceConfigHistory(self: *Self, allocator: std.mem.Allocator, input: get_resource_config_history.GetResourceConfigHistoryInput, options: get_resource_config_history.Options) !get_resource_config_history.GetResourceConfigHistoryOutput {
        return get_resource_config_history.execute(self, allocator, input, options);
    }

    /// Returns a summary of resource evaluation for the specified resource
    /// evaluation ID from the proactive rules that were run.
    /// The results indicate which evaluation context was used to evaluate the
    /// rules, which resource details were evaluated,
    /// the evaluation mode that was run, and whether the resource details comply
    /// with the configuration of the proactive rules.
    ///
    /// To see additional information about the evaluation result, such as which
    /// rule flagged a resource as NON_COMPLIANT, use the
    /// [GetComplianceDetailsByResource](https://docs.aws.amazon.com/config/latest/APIReference/API_GetComplianceDetailsByResource.html) API.
    /// For more information, see the
    /// [Examples](https://docs.aws.amazon.com/config/latest/APIReference/API_GetResourceEvaluationSummary.html#API_GetResourceEvaluationSummary_Examples) section.
    pub fn getResourceEvaluationSummary(self: *Self, allocator: std.mem.Allocator, input: get_resource_evaluation_summary.GetResourceEvaluationSummaryInput, options: get_resource_evaluation_summary.Options) !get_resource_evaluation_summary.GetResourceEvaluationSummaryOutput {
        return get_resource_evaluation_summary.execute(self, allocator, input, options);
    }

    /// Returns the details of a specific stored query.
    pub fn getStoredQuery(self: *Self, allocator: std.mem.Allocator, input: get_stored_query.GetStoredQueryInput, options: get_stored_query.Options) !get_stored_query.GetStoredQueryOutput {
        return get_stored_query.execute(self, allocator, input, options);
    }

    /// Accepts a resource type and returns a list of resource identifiers that are
    /// aggregated for a specific resource type across accounts and regions.
    /// A resource identifier includes the resource type, ID, (if available) the
    /// custom resource name, source account, and source region.
    /// You can narrow the results to include only resources that have specific
    /// resource IDs, or a resource name, or source account ID, or source region.
    ///
    /// For example, if the input consists of accountID 12345678910 and the region
    /// is us-east-1 for resource type `AWS::EC2::Instance` then the API returns all
    /// the EC2 instance identifiers of accountID 12345678910 and region us-east-1.
    pub fn listAggregateDiscoveredResources(self: *Self, allocator: std.mem.Allocator, input: list_aggregate_discovered_resources.ListAggregateDiscoveredResourcesInput, options: list_aggregate_discovered_resources.Options) !list_aggregate_discovered_resources.ListAggregateDiscoveredResourcesOutput {
        return list_aggregate_discovered_resources.execute(self, allocator, input, options);
    }

    /// Returns a list of configuration recorders depending on the filters you
    /// specify.
    pub fn listConfigurationRecorders(self: *Self, allocator: std.mem.Allocator, input: list_configuration_recorders.ListConfigurationRecordersInput, options: list_configuration_recorders.Options) !list_configuration_recorders.ListConfigurationRecordersOutput {
        return list_configuration_recorders.execute(self, allocator, input, options);
    }

    /// Returns a list of conformance pack compliance scores.
    /// A compliance score is the percentage of the number of compliant
    /// rule-resource combinations in a conformance pack compared to the number of
    /// total possible rule-resource combinations in the conformance pack.
    /// This metric provides you with a high-level view of the compliance state of
    /// your conformance packs. You can use it to identify, investigate, and
    /// understand
    /// the level of compliance in your conformance packs.
    ///
    /// Conformance packs with no evaluation results will have a compliance score of
    /// `INSUFFICIENT_DATA`.
    pub fn listConformancePackComplianceScores(self: *Self, allocator: std.mem.Allocator, input: list_conformance_pack_compliance_scores.ListConformancePackComplianceScoresInput, options: list_conformance_pack_compliance_scores.Options) !list_conformance_pack_compliance_scores.ListConformancePackComplianceScoresOutput {
        return list_conformance_pack_compliance_scores.execute(self, allocator, input, options);
    }

    /// Returns a list of resource
    /// resource identifiers for the specified resource types for the resources of
    /// that type. A *resource identifier*
    /// includes the resource type, ID, and (if available) the custom
    /// resource name.
    ///
    /// The results consist of resources that Config has
    /// *discovered*, including those that Config is not currently
    /// recording. You can narrow the results to include only resources that
    /// have specific resource IDs or a resource name.
    ///
    /// You can specify either resource IDs or a resource name, but
    /// not both, in the same request.
    ///
    /// *CloudFormation stack recording behavior in Config*
    ///
    /// When a CloudFormation stack fails to create (for example, it enters the
    /// `ROLLBACK_FAILED` state),
    /// Config does not record a configuration item (CI) for that stack.
    /// Configuration items are only recorded for stacks that reach
    /// the following states:
    ///
    /// * `CREATE_COMPLETE`
    ///
    /// * `UPDATE_COMPLETE`
    ///
    /// * `UPDATE_ROLLBACK_COMPLETE`
    ///
    /// * `UPDATE_ROLLBACK_FAILED`
    ///
    /// * `DELETE_FAILED`
    ///
    /// * `DELETE_COMPLETE`
    ///
    /// Because no CI is created for a failed stack creation, you won't see
    /// configuration history
    /// for that stack in Config, even after the stack is deleted. This helps make
    /// sure that Config only
    /// tracks resources that were successfully provisioned.
    pub fn listDiscoveredResources(self: *Self, allocator: std.mem.Allocator, input: list_discovered_resources.ListDiscoveredResourcesInput, options: list_discovered_resources.Options) !list_discovered_resources.ListDiscoveredResourcesOutput {
        return list_discovered_resources.execute(self, allocator, input, options);
    }

    /// Returns a list of proactive resource evaluations.
    pub fn listResourceEvaluations(self: *Self, allocator: std.mem.Allocator, input: list_resource_evaluations.ListResourceEvaluationsInput, options: list_resource_evaluations.Options) !list_resource_evaluations.ListResourceEvaluationsOutput {
        return list_resource_evaluations.execute(self, allocator, input, options);
    }

    /// Lists the stored queries for a single Amazon Web Services account and a
    /// single Amazon Web Services Region. The default is 100.
    pub fn listStoredQueries(self: *Self, allocator: std.mem.Allocator, input: list_stored_queries.ListStoredQueriesInput, options: list_stored_queries.Options) !list_stored_queries.ListStoredQueriesOutput {
        return list_stored_queries.execute(self, allocator, input, options);
    }

    /// List the tags for Config resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Authorizes the aggregator account and region to collect data
    /// from the source account and region.
    ///
    /// **Tags are added at creation and cannot be updated with this operation**
    ///
    /// `PutAggregationAuthorization` is an idempotent API. Subsequent requests
    /// won’t create a duplicate resource if one was already created. If a following
    /// request has different `tags` values,
    /// Config will ignore these differences and treat it as an idempotent request
    /// of the previous. In this case, `tags` will not be updated, even if they are
    /// different.
    ///
    /// Use
    /// [TagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_TagResource.html) and [UntagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_UntagResource.html) to update tags after creation.
    pub fn putAggregationAuthorization(self: *Self, allocator: std.mem.Allocator, input: put_aggregation_authorization.PutAggregationAuthorizationInput, options: put_aggregation_authorization.Options) !put_aggregation_authorization.PutAggregationAuthorizationOutput {
        return put_aggregation_authorization.execute(self, allocator, input, options);
    }

    /// Adds or updates an Config rule to evaluate if your
    /// Amazon Web Services resources comply with your desired configurations. For
    /// information on how many Config rules you can have per account,
    /// see [
    /// **Service Limits**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/configlimits.html) in the *Config Developer Guide*.
    ///
    /// There are two types of rules: *Config Managed Rules* and *Config Custom
    /// Rules*.
    /// You can use `PutConfigRule` to create both Config Managed Rules and Config
    /// Custom Rules.
    ///
    /// Config Managed Rules are predefined,
    /// customizable rules created by Config. For a list of managed rules, see
    /// [List of Config
    /// Managed
    /// Rules](https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html). If you are adding an Config managed rule, you must specify the
    /// rule's identifier for the `SourceIdentifier` key.
    ///
    /// Config Custom Rules are rules that you create from scratch. There are two
    /// ways to create Config custom rules: with Lambda functions
    /// ([ Lambda Developer
    /// Guide](https://docs.aws.amazon.com/config/latest/developerguide/gettingstarted-concepts.html#gettingstarted-concepts-function)) and with Guard ([Guard GitHub
    /// Repository](https://github.com/aws-cloudformation/cloudformation-guard)), a
    /// policy-as-code language.
    ///
    /// Config custom rules created with Lambda
    /// are called *Config Custom Lambda Rules* and Config custom rules created with
    /// Guard are called *Config Custom Policy Rules*.
    ///
    /// If you are adding a new Config Custom Lambda rule,
    /// you first need to create an Lambda function that the rule invokes to
    /// evaluate
    /// your resources. When you use `PutConfigRule` to add a Custom Lambda rule to
    /// Config, you must specify the Amazon Resource
    /// Name (ARN) that Lambda assigns to the function. You specify the ARN
    /// in the `SourceIdentifier` key. This key is part of the
    /// `Source` object, which is part of the
    /// `ConfigRule` object.
    ///
    /// For any new Config rule that you add, specify the
    /// `ConfigRuleName` in the `ConfigRule`
    /// object. Do not specify the `ConfigRuleArn` or the
    /// `ConfigRuleId`. These values are generated by Config for new rules.
    ///
    /// If you are updating a rule that you added previously, you can
    /// specify the rule by `ConfigRuleName`,
    /// `ConfigRuleId`, or `ConfigRuleArn` in the
    /// `ConfigRule` data type that you use in this
    /// request.
    ///
    /// For more information about developing and using Config
    /// rules, see [Evaluating Resources with Config
    /// Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config.html)
    /// in the *Config Developer Guide*.
    ///
    /// **Tags are added at creation and cannot be updated with this operation**
    ///
    /// `PutConfigRule` is an idempotent API. Subsequent requests won’t create a
    /// duplicate resource if one was already created. If a following request has
    /// different `tags` values,
    /// Config will ignore these differences and treat it as an idempotent request
    /// of the previous. In this case, `tags` will not be updated, even if they are
    /// different.
    ///
    /// Use
    /// [TagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_TagResource.html) and [UntagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_UntagResource.html) to update tags after creation.
    pub fn putConfigRule(self: *Self, allocator: std.mem.Allocator, input: put_config_rule.PutConfigRuleInput, options: put_config_rule.Options) !put_config_rule.PutConfigRuleOutput {
        return put_config_rule.execute(self, allocator, input, options);
    }

    /// Creates and updates the configuration aggregator with the
    /// selected source accounts and regions. The source account can be
    /// individual account(s) or an organization.
    ///
    /// `accountIds` that are passed will be replaced with existing accounts.
    /// If you want to add additional accounts into the aggregator, call
    /// `DescribeConfigurationAggregators` to get the previous accounts and then
    /// append new ones.
    ///
    /// Config should be enabled in source accounts and regions
    /// you want to aggregate.
    ///
    /// If your source type is an organization, you must be signed in to the
    /// management account or a registered delegated administrator and all the
    /// features must be enabled in your organization.
    /// If the caller is a management account, Config calls `EnableAwsServiceAccess`
    /// API to enable integration between Config and Organizations.
    /// If the caller is a registered delegated administrator, Config calls
    /// `ListDelegatedAdministrators` API to verify whether the caller is a valid
    /// delegated administrator.
    ///
    /// To register a delegated administrator, see [Register a Delegated
    /// Administrator](https://docs.aws.amazon.com/config/latest/developerguide/set-up-aggregator-cli.html#register-a-delegated-administrator-cli) in the *Config developer guide*.
    ///
    /// **Tags are added at creation and cannot be updated with this operation**
    ///
    /// `PutConfigurationAggregator` is an idempotent API. Subsequent requests won’t
    /// create a duplicate resource if one was already created. If a following
    /// request has different `tags` values,
    /// Config will ignore these differences and treat it as an idempotent request
    /// of the previous. In this case, `tags` will not be updated, even if they are
    /// different.
    ///
    /// Use
    /// [TagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_TagResource.html) and [UntagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_UntagResource.html) to update tags after creation.
    pub fn putConfigurationAggregator(self: *Self, allocator: std.mem.Allocator, input: put_configuration_aggregator.PutConfigurationAggregatorInput, options: put_configuration_aggregator.Options) !put_configuration_aggregator.PutConfigurationAggregatorOutput {
        return put_configuration_aggregator.execute(self, allocator, input, options);
    }

    /// Creates or updates the customer managed configuration recorder.
    ///
    /// You can use this operation to create a new customer managed configuration
    /// recorder or to update the `roleARN` and the `recordingGroup` for an existing
    /// customer managed configuration recorder.
    ///
    /// To start the customer managed configuration recorder and begin recording
    /// configuration changes for the resource types you specify,
    /// use the
    /// [StartConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_StartConfigurationRecorder.html) operation.
    ///
    /// For more information, see [
    /// **Working with the Configuration Recorder**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/stop-start-recorder.html) in the *Config Developer Guide*.
    ///
    /// **One customer managed configuration recorder per account per Region**
    ///
    /// You can create only one customer managed configuration recorder for each
    /// account for each Amazon Web Services Region.
    ///
    /// **Default is to record all supported resource types, excluding the global
    /// IAM resource types**
    ///
    /// If you have not specified values for the `recordingGroup` field, the default
    /// for the customer managed configuration recorder is to record all supported
    /// resource
    /// types, excluding the global IAM resource types: `AWS::IAM::Group`,
    /// `AWS::IAM::Policy`, `AWS::IAM::Role`, and `AWS::IAM::User`.
    ///
    /// **Tags are added at creation and cannot be updated**
    ///
    /// `PutConfigurationRecorder` is an idempotent API. Subsequent requests won’t
    /// create a duplicate resource if one was already created. If a following
    /// request has different tags values,
    /// Config will ignore these differences and treat it as an idempotent request
    /// of the previous. In this case, tags will not be updated, even if they are
    /// different.
    ///
    /// Use
    /// [TagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_TagResource.html) and [UntagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_UntagResource.html) to update tags after creation.
    pub fn putConfigurationRecorder(self: *Self, allocator: std.mem.Allocator, input: put_configuration_recorder.PutConfigurationRecorderInput, options: put_configuration_recorder.Options) !put_configuration_recorder.PutConfigurationRecorderOutput {
        return put_configuration_recorder.execute(self, allocator, input, options);
    }

    /// Creates or updates a conformance pack. A conformance pack is a collection of
    /// Config rules that can be easily deployed in an account and a region and
    /// across an organization.
    /// For information on how many conformance packs you can have per account,
    /// see [
    /// **Service Limits**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/configlimits.html) in the *Config Developer Guide*.
    ///
    /// When you use `PutConformancePack` to deploy conformance packs in your
    /// account,
    /// the operation can create Config rules and remediation actions without
    /// requiring `config:PutConfigRule` or
    /// `config:PutRemediationConfigurations` permissions in your account IAM
    /// policies.
    ///
    /// This API uses the `AWSServiceRoleForConfigConforms` service-linked role in
    /// your
    /// account to create conformance pack resources. This service-linked role
    /// includes the
    /// permissions to create Config rules and remediation configurations, even
    /// if your account IAM policies explicitly deny these actions.
    ///
    /// This API creates a service-linked role `AWSServiceRoleForConfigConforms` in
    /// your account.
    /// The service-linked role is created only when the role does not exist in your
    /// account.
    ///
    /// You must specify only one of the follow parameters: `TemplateS3Uri`,
    /// `TemplateBody` or `TemplateSSMDocumentDetails`.
    ///
    /// **Tags are added at creation and cannot be updated with this operation**
    ///
    /// `PutConformancePack` is an idempotent API. Subsequent requests won't create
    /// a duplicate resource if one was already created. If a following request has
    /// different `tags` values,
    /// Config will ignore these differences and treat it as an idempotent request
    /// of the previous. In this case, `tags` will not be updated, even if they are
    /// different.
    ///
    /// Use
    /// [TagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_TagResource.html) and [UntagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_UntagResource.html) to update tags after creation.
    pub fn putConformancePack(self: *Self, allocator: std.mem.Allocator, input: put_conformance_pack.PutConformancePackInput, options: put_conformance_pack.Options) !put_conformance_pack.PutConformancePackOutput {
        return put_conformance_pack.execute(self, allocator, input, options);
    }

    /// Creates or updates a delivery channel to deliver configuration
    /// information and other compliance information.
    ///
    /// You can use this operation to create a new delivery channel or to update the
    /// Amazon S3 bucket and the
    /// Amazon SNS topic of an existing delivery channel.
    ///
    /// For more information, see [
    /// **Working with the Delivery Channel**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/manage-delivery-channel.html) in the *Config Developer Guide.*
    ///
    /// **One delivery channel per account per Region**
    ///
    /// You can have only one delivery channel for each account for each Amazon Web
    /// Services Region.
    pub fn putDeliveryChannel(self: *Self, allocator: std.mem.Allocator, input: put_delivery_channel.PutDeliveryChannelInput, options: put_delivery_channel.Options) !put_delivery_channel.PutDeliveryChannelOutput {
        return put_delivery_channel.execute(self, allocator, input, options);
    }

    /// Used by an Lambda function to deliver evaluation results to
    /// Config. This operation is required in every Lambda function
    /// that is invoked by an Config rule.
    pub fn putEvaluations(self: *Self, allocator: std.mem.Allocator, input: put_evaluations.PutEvaluationsInput, options: put_evaluations.Options) !put_evaluations.PutEvaluationsOutput {
        return put_evaluations.execute(self, allocator, input, options);
    }

    /// Add or updates the evaluations for process checks.
    /// This API checks if the rule is a process check when the name of the Config
    /// rule is provided.
    pub fn putExternalEvaluation(self: *Self, allocator: std.mem.Allocator, input: put_external_evaluation.PutExternalEvaluationInput, options: put_external_evaluation.Options) !put_external_evaluation.PutExternalEvaluationOutput {
        return put_external_evaluation.execute(self, allocator, input, options);
    }

    /// Adds or updates an Config rule for your entire organization to evaluate if
    /// your Amazon Web Services resources comply with your
    /// desired configurations. For information on how many organization Config
    /// rules you can have per account,
    /// see [
    /// **Service Limits**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/configlimits.html) in the *Config Developer Guide*.
    ///
    /// Only a management account and a delegated administrator can create or update
    /// an organization Config rule.
    /// When calling this API with a delegated administrator, you must ensure
    /// Organizations
    /// `ListDelegatedAdministrator` permissions are added. An organization can have
    /// up to 3 delegated administrators.
    ///
    /// This API enables organization service access through the
    /// `EnableAWSServiceAccess` action and creates a service-linked
    /// role `AWSServiceRoleForConfigMultiAccountSetup` in the management or
    /// delegated administrator account of your organization.
    /// The service-linked role is created only when the role does not exist in the
    /// caller account.
    /// Config verifies the existence of role with `GetRole` action.
    ///
    /// To use this API with delegated administrator, register a delegated
    /// administrator by calling Amazon Web Services Organization
    /// `register-delegated-administrator` for
    /// `config-multiaccountsetup.amazonaws.com`.
    ///
    /// There are two types of rules: *Config Managed Rules* and *Config Custom
    /// Rules*.
    /// You can use `PutOrganizationConfigRule` to create both Config Managed Rules
    /// and Config Custom Rules.
    ///
    /// Config Managed Rules are predefined,
    /// customizable rules created by Config. For a list of managed rules, see
    /// [List of Config
    /// Managed
    /// Rules](https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html). If you are adding an Config managed rule, you must specify the rule's identifier for the `RuleIdentifier` key.
    ///
    /// Config Custom Rules are rules that you create from scratch. There are two
    /// ways to create Config custom rules: with Lambda functions
    /// ([ Lambda Developer
    /// Guide](https://docs.aws.amazon.com/config/latest/developerguide/gettingstarted-concepts.html#gettingstarted-concepts-function)) and with Guard ([Guard GitHub
    /// Repository](https://github.com/aws-cloudformation/cloudformation-guard)), a
    /// policy-as-code language.
    ///
    /// Config custom rules created with Lambda
    /// are called *Config Custom Lambda Rules* and Config custom rules created with
    /// Guard are called *Config Custom Policy Rules*.
    ///
    /// If you are adding a new Config Custom Lambda rule, you first need to create
    /// an Lambda function in the management account or a delegated
    /// administrator that the rule invokes to evaluate your resources. You also
    /// need to create an IAM role in the managed account that can be assumed by the
    /// Lambda function.
    /// When you use `PutOrganizationConfigRule` to add a Custom Lambda rule to
    /// Config, you must
    /// specify the Amazon Resource Name (ARN) that Lambda assigns to the function.
    ///
    /// Prerequisite: Ensure you call `EnableAllFeatures` API to enable all features
    /// in an organization.
    ///
    /// Make sure to specify one of either `OrganizationCustomPolicyRuleMetadata`
    /// for Custom Policy rules, `OrganizationCustomRuleMetadata` for Custom Lambda
    /// rules, or `OrganizationManagedRuleMetadata` for managed rules.
    pub fn putOrganizationConfigRule(self: *Self, allocator: std.mem.Allocator, input: put_organization_config_rule.PutOrganizationConfigRuleInput, options: put_organization_config_rule.Options) !put_organization_config_rule.PutOrganizationConfigRuleOutput {
        return put_organization_config_rule.execute(self, allocator, input, options);
    }

    /// Deploys conformance packs across member accounts in an Amazon Web Services
    /// Organization. For information on how many organization conformance packs and
    /// how many Config rules you can have per account,
    /// see [
    /// **Service Limits**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/configlimits.html) in the *Config Developer Guide*.
    ///
    /// Only a management account and a delegated administrator can call this API.
    /// When calling this API with a delegated administrator, you must ensure
    /// Organizations
    /// `ListDelegatedAdministrator` permissions are added. An organization can have
    /// up to 3 delegated administrators.
    ///
    /// When you use `PutOrganizationConformancePack` to deploy conformance packs
    /// across
    /// member accounts, the operation can create Config rules and remediation
    /// actions without requiring `config:PutConfigRule` or
    /// `config:PutRemediationConfigurations` permissions in member account
    /// IAM policies.
    ///
    /// This API uses the `AWSServiceRoleForConfigConforms` service-linked role in
    /// each
    /// member account to create conformance pack resources. This service-linked
    /// role
    /// includes the permissions to create Config rules and remediation
    /// configurations, even if member account IAM policies explicitly deny these
    /// actions.
    ///
    /// This API enables organization service access for
    /// `config-multiaccountsetup.amazonaws.com`
    /// through the `EnableAWSServiceAccess` action and creates a
    /// service-linked role `AWSServiceRoleForConfigMultiAccountSetup` in the
    /// management or delegated administrator account of your organization.
    /// The service-linked role is created only when the role does not exist in the
    /// caller account.
    /// To use this API with delegated administrator, register a delegated
    /// administrator by calling Amazon Web Services Organization
    /// `register-delegate-admin` for `config-multiaccountsetup.amazonaws.com`.
    ///
    /// Prerequisite: Ensure you call `EnableAllFeatures` API to enable all features
    /// in an organization.
    ///
    /// You must specify either the `TemplateS3Uri` or the `TemplateBody` parameter,
    /// but not both.
    /// If you provide both Config uses the `TemplateS3Uri` parameter and ignores
    /// the `TemplateBody` parameter.
    ///
    /// Config sets the state of a conformance pack to CREATE_IN_PROGRESS and
    /// UPDATE_IN_PROGRESS until the conformance pack is created or updated.
    /// You cannot update a conformance pack while it is in this state.
    pub fn putOrganizationConformancePack(self: *Self, allocator: std.mem.Allocator, input: put_organization_conformance_pack.PutOrganizationConformancePackInput, options: put_organization_conformance_pack.Options) !put_organization_conformance_pack.PutOrganizationConformancePackOutput {
        return put_organization_conformance_pack.execute(self, allocator, input, options);
    }

    /// Adds or updates the remediation configuration with a specific Config rule
    /// with the
    /// selected target or action.
    /// The API creates the `RemediationConfiguration` object for the Config rule.
    /// The Config rule must already exist for you to add a remediation
    /// configuration.
    /// The target (SSM document) must exist and have permissions to use the target.
    ///
    /// **Be aware of backward incompatible changes**
    ///
    /// If you make backward incompatible changes to the SSM document,
    /// you must call this again to ensure the remediations can run.
    ///
    /// This API does not support adding remediation configurations for
    /// service-linked Config Rules such as Organization Config rules,
    /// the rules deployed by conformance packs, and rules deployed by Amazon Web
    /// Services Security Hub.
    ///
    /// **Required fields**
    ///
    /// For manual remediation configuration, you need to provide a value for
    /// `automationAssumeRole` or use a value in the `assumeRole`field to remediate
    /// your resources. The SSM automation document can use either as long as it
    /// maps to a valid parameter.
    ///
    /// However, for automatic remediation configuration, the only valid
    /// `assumeRole` field value is `AutomationAssumeRole` and you need to provide a
    /// value for `AutomationAssumeRole` to remediate your resources.
    ///
    /// **Auto remediation can be initiated even for compliant resources**
    ///
    /// If you enable auto remediation for a specific Config rule using the
    /// [PutRemediationConfigurations](https://docs.aws.amazon.com/config/latest/APIReference/emAPI_PutRemediationConfigurations.html) API or the Config console,
    /// it initiates the remediation process for all non-compliant resources for
    /// that specific rule.
    /// The auto remediation process relies on the compliance data snapshot which is
    /// captured on a periodic basis.
    /// Any non-compliant resource that is updated between the snapshot schedule
    /// will continue to be remediated based on the last known compliance data
    /// snapshot.
    ///
    /// This means that in some cases auto remediation can be initiated even for
    /// compliant resources, since the bootstrap processor uses a database that can
    /// have stale evaluation results based on the last known compliance data
    /// snapshot.
    pub fn putRemediationConfigurations(self: *Self, allocator: std.mem.Allocator, input: put_remediation_configurations.PutRemediationConfigurationsInput, options: put_remediation_configurations.Options) !put_remediation_configurations.PutRemediationConfigurationsOutput {
        return put_remediation_configurations.execute(self, allocator, input, options);
    }

    /// A remediation exception is when a specified resource is no longer considered
    /// for auto-remediation.
    /// This API adds a new exception or updates an existing exception for a
    /// specified resource with a specified Config rule.
    ///
    /// **Exceptions block auto remediation**
    ///
    /// Config generates a remediation exception when a problem occurs running a
    /// remediation action for a specified resource.
    /// Remediation exceptions blocks auto-remediation until the exception is
    /// cleared.
    ///
    /// **Manual remediation is recommended when placing an exception**
    ///
    /// When placing an exception on an Amazon Web Services resource, it is
    /// recommended that remediation is set as manual remediation until
    /// the given Config rule for the specified resource evaluates the resource as
    /// `NON_COMPLIANT`.
    /// Once the resource has been evaluated as `NON_COMPLIANT`, you can add
    /// remediation exceptions and change the remediation type back from Manual to
    /// Auto if you want to use auto-remediation.
    /// Otherwise, using auto-remediation before a `NON_COMPLIANT` evaluation result
    /// can delete resources before the exception is applied.
    ///
    /// **Exceptions can only be performed on non-compliant resources**
    ///
    /// Placing an exception can only be performed on resources that are
    /// `NON_COMPLIANT`.
    /// If you use this API for `COMPLIANT` resources or resources that are
    /// `NOT_APPLICABLE`, a remediation exception will not be generated.
    /// For more information on the conditions that initiate the possible Config
    /// evaluation results,
    /// see [Concepts | Config
    /// Rules](https://docs.aws.amazon.com/config/latest/developerguide/config-concepts.html#aws-config-rules) in the *Config Developer Guide*.
    ///
    /// **Exceptions cannot be placed on service-linked remediation actions**
    ///
    /// You cannot place an exception on service-linked remediation actions, such as
    /// remediation actions put by an organizational conformance pack.
    ///
    /// **Auto remediation can be initiated even for compliant resources**
    ///
    /// If you enable auto remediation for a specific Config rule using the
    /// [PutRemediationConfigurations](https://docs.aws.amazon.com/config/latest/APIReference/emAPI_PutRemediationConfigurations.html) API or the Config console,
    /// it initiates the remediation process for all non-compliant resources for
    /// that specific rule.
    /// The auto remediation process relies on the compliance data snapshot which is
    /// captured on a periodic basis.
    /// Any non-compliant resource that is updated between the snapshot schedule
    /// will continue to be remediated based on the last known compliance data
    /// snapshot.
    ///
    /// This means that in some cases auto remediation can be initiated even for
    /// compliant resources, since the bootstrap processor uses a database that can
    /// have stale evaluation results based on the last known compliance data
    /// snapshot.
    pub fn putRemediationExceptions(self: *Self, allocator: std.mem.Allocator, input: put_remediation_exceptions.PutRemediationExceptionsInput, options: put_remediation_exceptions.Options) !put_remediation_exceptions.PutRemediationExceptionsOutput {
        return put_remediation_exceptions.execute(self, allocator, input, options);
    }

    /// Records the configuration state for the resource provided in the request.
    ///
    /// The configuration state of a resource is represented in Config as
    /// Configuration Items.
    /// Once this API records the configuration item, you can retrieve the list of
    /// configuration items for the custom resource type using existing Config APIs.
    ///
    /// The custom resource type must be registered with CloudFormation. This API
    /// accepts the configuration item registered with CloudFormation.
    ///
    /// When you call this API, Config only stores configuration state of the
    /// resource provided in the request. This API does not change or remediate the
    /// configuration of the resource.
    ///
    /// Write-only schema properites are not recorded as part of the published
    /// configuration item.
    pub fn putResourceConfig(self: *Self, allocator: std.mem.Allocator, input: put_resource_config.PutResourceConfigInput, options: put_resource_config.Options) !put_resource_config.PutResourceConfigOutput {
        return put_resource_config.execute(self, allocator, input, options);
    }

    /// Creates and updates the retention configuration with details
    /// about retention period (number of days) that Config stores your
    /// historical information. The API creates the
    /// `RetentionConfiguration` object and names the object
    /// as **default**. When you have a
    /// `RetentionConfiguration` object named **default**, calling the API modifies
    /// the
    /// default object.
    ///
    /// Currently, Config supports only one retention
    /// configuration per region in your account.
    pub fn putRetentionConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_retention_configuration.PutRetentionConfigurationInput, options: put_retention_configuration.Options) !put_retention_configuration.PutRetentionConfigurationOutput {
        return put_retention_configuration.execute(self, allocator, input, options);
    }

    /// Creates a service-linked configuration recorder that is linked to a specific
    /// Amazon Web Services service based on the `ServicePrincipal` you specify.
    ///
    /// The configuration recorder's `name`, `recordingGroup`, `recordingMode`, and
    /// `recordingScope` is set by the service that is linked to the configuration
    /// recorder.
    ///
    /// For more information and a list of supported services/service principals,
    /// see [
    /// **Working with the Configuration Recorder**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/stop-start-recorder.html) in the *Config Developer Guide*.
    ///
    /// This API creates a service-linked role `AWSServiceRoleForConfig` in your
    /// account. The service-linked role is created only when the role does not
    /// exist in your account.
    ///
    /// **The recording scope determines if you receive configuration items**
    ///
    /// The recording scope is set by the service that is linked to the
    /// configuration recorder and determines whether you receive configuration
    /// items (CIs) in the delivery channel. If the recording scope is internal, you
    /// will not receive CIs in the delivery channel.
    ///
    /// **Tags are added at creation and cannot be updated with this operation**
    ///
    /// Use
    /// [TagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_TagResource.html) and [UntagResource](https://docs.aws.amazon.com/config/latest/APIReference/API_UntagResource.html) to update tags after creation.
    pub fn putServiceLinkedConfigurationRecorder(self: *Self, allocator: std.mem.Allocator, input: put_service_linked_configuration_recorder.PutServiceLinkedConfigurationRecorderInput, options: put_service_linked_configuration_recorder.Options) !put_service_linked_configuration_recorder.PutServiceLinkedConfigurationRecorderOutput {
        return put_service_linked_configuration_recorder.execute(self, allocator, input, options);
    }

    /// Saves a new query or updates an existing saved query. The `QueryName` must
    /// be unique for a single Amazon Web Services account and a single Amazon Web
    /// Services Region.
    /// You can create upto 300 queries in a single Amazon Web Services account and
    /// a single Amazon Web Services Region.
    ///
    /// **Tags are added at creation and cannot be updated**
    ///
    /// `PutStoredQuery` is an idempotent API. Subsequent requests won’t create a
    /// duplicate resource if one was already created. If a following request has
    /// different `tags` values,
    /// Config will ignore these differences and treat it as an idempotent request
    /// of the previous. In this case, `tags` will not be updated, even if they are
    /// different.
    pub fn putStoredQuery(self: *Self, allocator: std.mem.Allocator, input: put_stored_query.PutStoredQueryInput, options: put_stored_query.Options) !put_stored_query.PutStoredQueryOutput {
        return put_stored_query.execute(self, allocator, input, options);
    }

    /// Accepts a structured query language (SQL) SELECT command and an aggregator
    /// to query configuration state of Amazon Web Services resources across
    /// multiple accounts and regions,
    /// performs the corresponding search, and returns resource configurations
    /// matching the properties.
    ///
    /// For more information about query components, see the
    /// [
    /// **Query Components**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/query-components.html) section in the *Config Developer Guide*.
    ///
    /// If you run an aggregation query (i.e., using `GROUP BY` or using aggregate
    /// functions such as `COUNT`; e.g., `SELECT resourceId, COUNT(*) WHERE
    /// resourceType = 'AWS::IAM::Role' GROUP BY resourceId`)
    /// and do not specify the `MaxResults` or the `Limit` query parameters, the
    /// default page size is set to 500.
    ///
    /// If you run a non-aggregation query (i.e., not using `GROUP BY` or aggregate
    /// function; e.g., `SELECT * WHERE resourceType = 'AWS::IAM::Role'`)
    /// and do not specify the `MaxResults` or the `Limit` query parameters, the
    /// default page size is set to 25.
    pub fn selectAggregateResourceConfig(self: *Self, allocator: std.mem.Allocator, input: select_aggregate_resource_config.SelectAggregateResourceConfigInput, options: select_aggregate_resource_config.Options) !select_aggregate_resource_config.SelectAggregateResourceConfigOutput {
        return select_aggregate_resource_config.execute(self, allocator, input, options);
    }

    /// Accepts a structured query language (SQL) `SELECT` command, performs the
    /// corresponding search, and returns resource configurations matching the
    /// properties.
    ///
    /// For more information about query components, see the
    /// [
    /// **Query Components**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/query-components.html) section in the *Config Developer Guide*.
    pub fn selectResourceConfig(self: *Self, allocator: std.mem.Allocator, input: select_resource_config.SelectResourceConfigInput, options: select_resource_config.Options) !select_resource_config.SelectResourceConfigOutput {
        return select_resource_config.execute(self, allocator, input, options);
    }

    /// Runs an on-demand evaluation for the specified Config rules
    /// against the last known configuration state of the resources. Use
    /// `StartConfigRulesEvaluation` when you want to test
    /// that a rule you updated is working as expected.
    /// `StartConfigRulesEvaluation` does not re-record the
    /// latest configuration state for your resources. It re-runs an
    /// evaluation against the last known state of your resources.
    ///
    /// You can specify up to 25 Config rules per request.
    ///
    /// An existing `StartConfigRulesEvaluation` call for
    /// the specified rules must complete before you can call the API again.
    /// If you chose to have Config stream to an Amazon SNS topic, you
    /// will receive a `ConfigRuleEvaluationStarted` notification
    /// when the evaluation starts.
    ///
    /// You don't need to call the
    /// `StartConfigRulesEvaluation` API to run an
    /// evaluation for a new rule. When you create a rule, Config
    /// evaluates your resources against the rule automatically.
    ///
    /// The `StartConfigRulesEvaluation` API is useful if
    /// you want to run on-demand evaluations, such as the following
    /// example:
    ///
    /// * You have a custom rule that evaluates your IAM
    /// resources every 24 hours.
    ///
    /// * You update your Lambda function to add additional
    /// conditions to your rule.
    ///
    /// * Instead of waiting for the next periodic evaluation,
    /// you call the `StartConfigRulesEvaluation`
    /// API.
    ///
    /// * Config invokes your Lambda function and evaluates
    /// your IAM resources.
    ///
    /// * Your custom rule will still run periodic evaluations
    /// every 24 hours.
    pub fn startConfigRulesEvaluation(self: *Self, allocator: std.mem.Allocator, input: start_config_rules_evaluation.StartConfigRulesEvaluationInput, options: start_config_rules_evaluation.Options) !start_config_rules_evaluation.StartConfigRulesEvaluationOutput {
        return start_config_rules_evaluation.execute(self, allocator, input, options);
    }

    /// Starts the customer managed configuration recorder. The customer managed
    /// configuration recorder will begin recording configuration changes for the
    /// resource types you specify.
    ///
    /// You must have created a delivery channel to
    /// successfully start the customer managed configuration recorder. You can use
    /// the
    /// [PutDeliveryChannel](https://docs.aws.amazon.com/config/latest/APIReference/API_PutDeliveryChannel.html) operation to create a delivery channel.
    pub fn startConfigurationRecorder(self: *Self, allocator: std.mem.Allocator, input: start_configuration_recorder.StartConfigurationRecorderInput, options: start_configuration_recorder.Options) !start_configuration_recorder.StartConfigurationRecorderOutput {
        return start_configuration_recorder.execute(self, allocator, input, options);
    }

    /// Runs an on-demand remediation for the specified Config rules against the
    /// last known remediation configuration. It runs an execution against the
    /// current state of your resources. Remediation execution is asynchronous.
    ///
    /// You can specify up to 100 resource keys per request. An existing
    /// StartRemediationExecution call for the specified resource keys must complete
    /// before you can call the API again.
    pub fn startRemediationExecution(self: *Self, allocator: std.mem.Allocator, input: start_remediation_execution.StartRemediationExecutionInput, options: start_remediation_execution.Options) !start_remediation_execution.StartRemediationExecutionOutput {
        return start_remediation_execution.execute(self, allocator, input, options);
    }

    /// Runs an on-demand evaluation for the specified resource to determine whether
    /// the resource details will comply with configured Config rules.
    /// You can also use it for evaluation purposes. Config recommends using an
    /// evaluation context. It runs an execution against the resource details with
    /// all
    /// of the Config rules in your account that match with the specified proactive
    /// mode and resource type.
    ///
    /// Ensure you have the `cloudformation:DescribeType` role setup to validate the
    /// resource type schema.
    ///
    /// You can find the
    /// [Resource type
    /// schema](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html) in "*Amazon Web Services public extensions*" within the CloudFormation registry or with the following CLI commmand:
    /// `aws cloudformation describe-type --type-name "AWS::S3::Bucket" --type
    /// RESOURCE`.
    ///
    /// For more information, see [Managing extensions through the CloudFormation
    /// registry](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry.html#registry-view)
    /// and [Amazon Web Services resource and property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the CloudFormation User Guide.
    pub fn startResourceEvaluation(self: *Self, allocator: std.mem.Allocator, input: start_resource_evaluation.StartResourceEvaluationInput, options: start_resource_evaluation.Options) !start_resource_evaluation.StartResourceEvaluationOutput {
        return start_resource_evaluation.execute(self, allocator, input, options);
    }

    /// Stops the customer managed configuration recorder. The customer managed
    /// configuration recorder will stop recording configuration changes for the
    /// resource types you have specified.
    pub fn stopConfigurationRecorder(self: *Self, allocator: std.mem.Allocator, input: stop_configuration_recorder.StopConfigurationRecorderInput, options: stop_configuration_recorder.Options) !stop_configuration_recorder.StopConfigurationRecorderOutput {
        return stop_configuration_recorder.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified
    /// `ResourceArn`. If existing tags on a resource are not specified in the
    /// request parameters, they are not changed.
    /// If existing tags are specified, however, then their values will be updated.
    /// When a resource is deleted, the tags associated with that resource are
    /// deleted as well.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn describeAggregateComplianceByConfigRulesPaginator(self: *Self, params: describe_aggregate_compliance_by_config_rules.DescribeAggregateComplianceByConfigRulesInput) paginator.DescribeAggregateComplianceByConfigRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAggregateComplianceByConformancePacksPaginator(self: *Self, params: describe_aggregate_compliance_by_conformance_packs.DescribeAggregateComplianceByConformancePacksInput) paginator.DescribeAggregateComplianceByConformancePacksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAggregationAuthorizationsPaginator(self: *Self, params: describe_aggregation_authorizations.DescribeAggregationAuthorizationsInput) paginator.DescribeAggregationAuthorizationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeComplianceByConfigRulePaginator(self: *Self, params: describe_compliance_by_config_rule.DescribeComplianceByConfigRuleInput) paginator.DescribeComplianceByConfigRulePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeComplianceByResourcePaginator(self: *Self, params: describe_compliance_by_resource.DescribeComplianceByResourceInput) paginator.DescribeComplianceByResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeConfigRuleEvaluationStatusPaginator(self: *Self, params: describe_config_rule_evaluation_status.DescribeConfigRuleEvaluationStatusInput) paginator.DescribeConfigRuleEvaluationStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeConfigRulesPaginator(self: *Self, params: describe_config_rules.DescribeConfigRulesInput) paginator.DescribeConfigRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeConfigurationAggregatorSourcesStatusPaginator(self: *Self, params: describe_configuration_aggregator_sources_status.DescribeConfigurationAggregatorSourcesStatusInput) paginator.DescribeConfigurationAggregatorSourcesStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeConfigurationAggregatorsPaginator(self: *Self, params: describe_configuration_aggregators.DescribeConfigurationAggregatorsInput) paginator.DescribeConfigurationAggregatorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeConformancePackCompliancePaginator(self: *Self, params: describe_conformance_pack_compliance.DescribeConformancePackComplianceInput) paginator.DescribeConformancePackCompliancePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeConformancePackStatusPaginator(self: *Self, params: describe_conformance_pack_status.DescribeConformancePackStatusInput) paginator.DescribeConformancePackStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeConformancePacksPaginator(self: *Self, params: describe_conformance_packs.DescribeConformancePacksInput) paginator.DescribeConformancePacksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOrganizationConfigRuleStatusesPaginator(self: *Self, params: describe_organization_config_rule_statuses.DescribeOrganizationConfigRuleStatusesInput) paginator.DescribeOrganizationConfigRuleStatusesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOrganizationConfigRulesPaginator(self: *Self, params: describe_organization_config_rules.DescribeOrganizationConfigRulesInput) paginator.DescribeOrganizationConfigRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOrganizationConformancePackStatusesPaginator(self: *Self, params: describe_organization_conformance_pack_statuses.DescribeOrganizationConformancePackStatusesInput) paginator.DescribeOrganizationConformancePackStatusesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOrganizationConformancePacksPaginator(self: *Self, params: describe_organization_conformance_packs.DescribeOrganizationConformancePacksInput) paginator.DescribeOrganizationConformancePacksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePendingAggregationRequestsPaginator(self: *Self, params: describe_pending_aggregation_requests.DescribePendingAggregationRequestsInput) paginator.DescribePendingAggregationRequestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRemediationExceptionsPaginator(self: *Self, params: describe_remediation_exceptions.DescribeRemediationExceptionsInput) paginator.DescribeRemediationExceptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRemediationExecutionStatusPaginator(self: *Self, params: describe_remediation_execution_status.DescribeRemediationExecutionStatusInput) paginator.DescribeRemediationExecutionStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRetentionConfigurationsPaginator(self: *Self, params: describe_retention_configurations.DescribeRetentionConfigurationsInput) paginator.DescribeRetentionConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAggregateComplianceDetailsByConfigRulePaginator(self: *Self, params: get_aggregate_compliance_details_by_config_rule.GetAggregateComplianceDetailsByConfigRuleInput) paginator.GetAggregateComplianceDetailsByConfigRulePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAggregateConfigRuleComplianceSummaryPaginator(self: *Self, params: get_aggregate_config_rule_compliance_summary.GetAggregateConfigRuleComplianceSummaryInput) paginator.GetAggregateConfigRuleComplianceSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAggregateConformancePackComplianceSummaryPaginator(self: *Self, params: get_aggregate_conformance_pack_compliance_summary.GetAggregateConformancePackComplianceSummaryInput) paginator.GetAggregateConformancePackComplianceSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAggregateDiscoveredResourceCountsPaginator(self: *Self, params: get_aggregate_discovered_resource_counts.GetAggregateDiscoveredResourceCountsInput) paginator.GetAggregateDiscoveredResourceCountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getComplianceDetailsByConfigRulePaginator(self: *Self, params: get_compliance_details_by_config_rule.GetComplianceDetailsByConfigRuleInput) paginator.GetComplianceDetailsByConfigRulePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getComplianceDetailsByResourcePaginator(self: *Self, params: get_compliance_details_by_resource.GetComplianceDetailsByResourceInput) paginator.GetComplianceDetailsByResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getConformancePackComplianceDetailsPaginator(self: *Self, params: get_conformance_pack_compliance_details.GetConformancePackComplianceDetailsInput) paginator.GetConformancePackComplianceDetailsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getConformancePackComplianceSummaryPaginator(self: *Self, params: get_conformance_pack_compliance_summary.GetConformancePackComplianceSummaryInput) paginator.GetConformancePackComplianceSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDiscoveredResourceCountsPaginator(self: *Self, params: get_discovered_resource_counts.GetDiscoveredResourceCountsInput) paginator.GetDiscoveredResourceCountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getOrganizationConfigRuleDetailedStatusPaginator(self: *Self, params: get_organization_config_rule_detailed_status.GetOrganizationConfigRuleDetailedStatusInput) paginator.GetOrganizationConfigRuleDetailedStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getOrganizationConformancePackDetailedStatusPaginator(self: *Self, params: get_organization_conformance_pack_detailed_status.GetOrganizationConformancePackDetailedStatusInput) paginator.GetOrganizationConformancePackDetailedStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourceConfigHistoryPaginator(self: *Self, params: get_resource_config_history.GetResourceConfigHistoryInput) paginator.GetResourceConfigHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAggregateDiscoveredResourcesPaginator(self: *Self, params: list_aggregate_discovered_resources.ListAggregateDiscoveredResourcesInput) paginator.ListAggregateDiscoveredResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfigurationRecordersPaginator(self: *Self, params: list_configuration_recorders.ListConfigurationRecordersInput) paginator.ListConfigurationRecordersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConformancePackComplianceScoresPaginator(self: *Self, params: list_conformance_pack_compliance_scores.ListConformancePackComplianceScoresInput) paginator.ListConformancePackComplianceScoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDiscoveredResourcesPaginator(self: *Self, params: list_discovered_resources.ListDiscoveredResourcesInput) paginator.ListDiscoveredResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceEvaluationsPaginator(self: *Self, params: list_resource_evaluations.ListResourceEvaluationsInput) paginator.ListResourceEvaluationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStoredQueriesPaginator(self: *Self, params: list_stored_queries.ListStoredQueriesInput) paginator.ListStoredQueriesPaginator {
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

    pub fn selectAggregateResourceConfigPaginator(self: *Self, params: select_aggregate_resource_config.SelectAggregateResourceConfigInput) paginator.SelectAggregateResourceConfigPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn selectResourceConfigPaginator(self: *Self, params: select_resource_config.SelectResourceConfigInput) paginator.SelectResourceConfigPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

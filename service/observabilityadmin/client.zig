const aws = @import("aws");
const std = @import("std");

const create_centralization_rule_for_organization = @import("create_centralization_rule_for_organization.zig");
const create_s3_table_integration = @import("create_s3_table_integration.zig");
const create_telemetry_pipeline = @import("create_telemetry_pipeline.zig");
const create_telemetry_rule = @import("create_telemetry_rule.zig");
const create_telemetry_rule_for_organization = @import("create_telemetry_rule_for_organization.zig");
const delete_centralization_rule_for_organization = @import("delete_centralization_rule_for_organization.zig");
const delete_s3_table_integration = @import("delete_s3_table_integration.zig");
const delete_telemetry_pipeline = @import("delete_telemetry_pipeline.zig");
const delete_telemetry_rule = @import("delete_telemetry_rule.zig");
const delete_telemetry_rule_for_organization = @import("delete_telemetry_rule_for_organization.zig");
const get_centralization_rule_for_organization = @import("get_centralization_rule_for_organization.zig");
const get_s3_table_integration = @import("get_s3_table_integration.zig");
const get_telemetry_enrichment_status = @import("get_telemetry_enrichment_status.zig");
const get_telemetry_evaluation_status = @import("get_telemetry_evaluation_status.zig");
const get_telemetry_evaluation_status_for_organization = @import("get_telemetry_evaluation_status_for_organization.zig");
const get_telemetry_pipeline = @import("get_telemetry_pipeline.zig");
const get_telemetry_rule = @import("get_telemetry_rule.zig");
const get_telemetry_rule_for_organization = @import("get_telemetry_rule_for_organization.zig");
const list_centralization_rules_for_organization = @import("list_centralization_rules_for_organization.zig");
const list_resource_telemetry = @import("list_resource_telemetry.zig");
const list_resource_telemetry_for_organization = @import("list_resource_telemetry_for_organization.zig");
const list_s3_table_integrations = @import("list_s3_table_integrations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_telemetry_pipelines = @import("list_telemetry_pipelines.zig");
const list_telemetry_rules = @import("list_telemetry_rules.zig");
const list_telemetry_rules_for_organization = @import("list_telemetry_rules_for_organization.zig");
const start_telemetry_enrichment = @import("start_telemetry_enrichment.zig");
const start_telemetry_evaluation = @import("start_telemetry_evaluation.zig");
const start_telemetry_evaluation_for_organization = @import("start_telemetry_evaluation_for_organization.zig");
const stop_telemetry_enrichment = @import("stop_telemetry_enrichment.zig");
const stop_telemetry_evaluation = @import("stop_telemetry_evaluation.zig");
const stop_telemetry_evaluation_for_organization = @import("stop_telemetry_evaluation_for_organization.zig");
const tag_resource = @import("tag_resource.zig");
const test_telemetry_pipeline = @import("test_telemetry_pipeline.zig");
const untag_resource = @import("untag_resource.zig");
const update_centralization_rule_for_organization = @import("update_centralization_rule_for_organization.zig");
const update_telemetry_pipeline = @import("update_telemetry_pipeline.zig");
const update_telemetry_rule = @import("update_telemetry_rule.zig");
const update_telemetry_rule_for_organization = @import("update_telemetry_rule_for_organization.zig");
const validate_telemetry_pipeline_configuration = @import("validate_telemetry_pipeline_configuration.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ObservabilityAdmin";

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

    /// Creates a centralization rule that applies across an Amazon Web Services
    /// Organization. This operation can only be called by the organization's
    /// management account or a delegated administrator account.
    pub fn createCentralizationRuleForOrganization(self: *Self, allocator: std.mem.Allocator, input: create_centralization_rule_for_organization.CreateCentralizationRuleForOrganizationInput, options: CallOptions) !create_centralization_rule_for_organization.CreateCentralizationRuleForOrganizationOutput {
        return create_centralization_rule_for_organization.execute(self, allocator, input, options);
    }

    /// Creates an integration between CloudWatch and S3 Tables for analytics. This
    /// integration enables querying CloudWatch telemetry data using analytics
    /// engines like Amazon Athena, Amazon Redshift, and Apache Spark.
    pub fn createS3TableIntegration(self: *Self, allocator: std.mem.Allocator, input: create_s3_table_integration.CreateS3TableIntegrationInput, options: CallOptions) !create_s3_table_integration.CreateS3TableIntegrationOutput {
        return create_s3_table_integration.execute(self, allocator, input, options);
    }

    /// Creates a telemetry pipeline for processing and transforming telemetry data.
    /// The pipeline defines how data flows from sources through processors to
    /// destinations, enabling data transformation and delivering capabilities.
    pub fn createTelemetryPipeline(self: *Self, allocator: std.mem.Allocator, input: create_telemetry_pipeline.CreateTelemetryPipelineInput, options: CallOptions) !create_telemetry_pipeline.CreateTelemetryPipelineOutput {
        return create_telemetry_pipeline.execute(self, allocator, input, options);
    }

    /// Creates a telemetry rule that defines how telemetry should be configured for
    /// Amazon Web Services resources in your account. The rule specifies which
    /// resources should have telemetry enabled and how that telemetry data should
    /// be collected based on resource type, telemetry type, and selection criteria.
    pub fn createTelemetryRule(self: *Self, allocator: std.mem.Allocator, input: create_telemetry_rule.CreateTelemetryRuleInput, options: CallOptions) !create_telemetry_rule.CreateTelemetryRuleOutput {
        return create_telemetry_rule.execute(self, allocator, input, options);
    }

    /// Creates a telemetry rule that applies across an Amazon Web Services
    /// Organization. This operation can only be called by the organization's
    /// management account or a delegated administrator account.
    pub fn createTelemetryRuleForOrganization(self: *Self, allocator: std.mem.Allocator, input: create_telemetry_rule_for_organization.CreateTelemetryRuleForOrganizationInput, options: CallOptions) !create_telemetry_rule_for_organization.CreateTelemetryRuleForOrganizationOutput {
        return create_telemetry_rule_for_organization.execute(self, allocator, input, options);
    }

    /// Deletes an organization-wide centralization rule. This operation can only be
    /// called by the organization's management account or a delegated administrator
    /// account.
    pub fn deleteCentralizationRuleForOrganization(self: *Self, allocator: std.mem.Allocator, input: delete_centralization_rule_for_organization.DeleteCentralizationRuleForOrganizationInput, options: CallOptions) !delete_centralization_rule_for_organization.DeleteCentralizationRuleForOrganizationOutput {
        return delete_centralization_rule_for_organization.execute(self, allocator, input, options);
    }

    /// Deletes an S3 Table integration and its associated data. This operation
    /// removes the connection between CloudWatch Observability Admin and S3 Tables.
    pub fn deleteS3TableIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_s3_table_integration.DeleteS3TableIntegrationInput, options: CallOptions) !delete_s3_table_integration.DeleteS3TableIntegrationOutput {
        return delete_s3_table_integration.execute(self, allocator, input, options);
    }

    /// Deletes a telemetry pipeline and its associated resources. This operation
    /// stops data processing and removes the pipeline configuration.
    pub fn deleteTelemetryPipeline(self: *Self, allocator: std.mem.Allocator, input: delete_telemetry_pipeline.DeleteTelemetryPipelineInput, options: CallOptions) !delete_telemetry_pipeline.DeleteTelemetryPipelineOutput {
        return delete_telemetry_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes a telemetry rule from your account. Any telemetry configurations
    /// previously created by the rule will remain but no new resources will be
    /// configured by this rule.
    pub fn deleteTelemetryRule(self: *Self, allocator: std.mem.Allocator, input: delete_telemetry_rule.DeleteTelemetryRuleInput, options: CallOptions) !delete_telemetry_rule.DeleteTelemetryRuleOutput {
        return delete_telemetry_rule.execute(self, allocator, input, options);
    }

    /// Deletes an organization-wide telemetry rule. This operation can only be
    /// called by the organization's management account or a delegated administrator
    /// account.
    pub fn deleteTelemetryRuleForOrganization(self: *Self, allocator: std.mem.Allocator, input: delete_telemetry_rule_for_organization.DeleteTelemetryRuleForOrganizationInput, options: CallOptions) !delete_telemetry_rule_for_organization.DeleteTelemetryRuleForOrganizationOutput {
        return delete_telemetry_rule_for_organization.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific organization centralization rule. This
    /// operation can only be called by the organization's management account or a
    /// delegated administrator account.
    pub fn getCentralizationRuleForOrganization(self: *Self, allocator: std.mem.Allocator, input: get_centralization_rule_for_organization.GetCentralizationRuleForOrganizationInput, options: CallOptions) !get_centralization_rule_for_organization.GetCentralizationRuleForOrganizationOutput {
        return get_centralization_rule_for_organization.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific S3 Table integration, including its
    /// configuration, status, and metadata.
    pub fn getS3TableIntegration(self: *Self, allocator: std.mem.Allocator, input: get_s3_table_integration.GetS3TableIntegrationInput, options: CallOptions) !get_s3_table_integration.GetS3TableIntegrationOutput {
        return get_s3_table_integration.execute(self, allocator, input, options);
    }

    /// Returns the current status of the resource tags for telemetry feature, which
    /// enhances telemetry data with additional resource metadata from Resource
    /// Explorer.
    pub fn getTelemetryEnrichmentStatus(self: *Self, allocator: std.mem.Allocator, input: get_telemetry_enrichment_status.GetTelemetryEnrichmentStatusInput, options: CallOptions) !get_telemetry_enrichment_status.GetTelemetryEnrichmentStatusOutput {
        return get_telemetry_enrichment_status.execute(self, allocator, input, options);
    }

    /// Returns the current onboarding status of the telemetry config feature,
    /// including the status of the feature and reason the feature failed to start
    /// or stop.
    pub fn getTelemetryEvaluationStatus(self: *Self, allocator: std.mem.Allocator, input: get_telemetry_evaluation_status.GetTelemetryEvaluationStatusInput, options: CallOptions) !get_telemetry_evaluation_status.GetTelemetryEvaluationStatusOutput {
        return get_telemetry_evaluation_status.execute(self, allocator, input, options);
    }

    /// This returns the onboarding status of the telemetry configuration feature
    /// for the organization. It can only be called by a Management Account of an
    /// Amazon Web Services Organization or an assigned Delegated Admin Account of
    /// Amazon CloudWatch telemetry config.
    pub fn getTelemetryEvaluationStatusForOrganization(self: *Self, allocator: std.mem.Allocator, input: get_telemetry_evaluation_status_for_organization.GetTelemetryEvaluationStatusForOrganizationInput, options: CallOptions) !get_telemetry_evaluation_status_for_organization.GetTelemetryEvaluationStatusForOrganizationOutput {
        return get_telemetry_evaluation_status_for_organization.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific telemetry pipeline, including its
    /// configuration, status, and metadata.
    pub fn getTelemetryPipeline(self: *Self, allocator: std.mem.Allocator, input: get_telemetry_pipeline.GetTelemetryPipelineInput, options: CallOptions) !get_telemetry_pipeline.GetTelemetryPipelineOutput {
        return get_telemetry_pipeline.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific telemetry rule in your account.
    pub fn getTelemetryRule(self: *Self, allocator: std.mem.Allocator, input: get_telemetry_rule.GetTelemetryRuleInput, options: CallOptions) !get_telemetry_rule.GetTelemetryRuleOutput {
        return get_telemetry_rule.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific organization telemetry rule. This
    /// operation can only be called by the organization's management account or a
    /// delegated administrator account.
    pub fn getTelemetryRuleForOrganization(self: *Self, allocator: std.mem.Allocator, input: get_telemetry_rule_for_organization.GetTelemetryRuleForOrganizationInput, options: CallOptions) !get_telemetry_rule_for_organization.GetTelemetryRuleForOrganizationOutput {
        return get_telemetry_rule_for_organization.execute(self, allocator, input, options);
    }

    /// Lists all centralization rules in your organization. This operation can only
    /// be called by the organization's management account or a delegated
    /// administrator account.
    pub fn listCentralizationRulesForOrganization(self: *Self, allocator: std.mem.Allocator, input: list_centralization_rules_for_organization.ListCentralizationRulesForOrganizationInput, options: CallOptions) !list_centralization_rules_for_organization.ListCentralizationRulesForOrganizationOutput {
        return list_centralization_rules_for_organization.execute(self, allocator, input, options);
    }

    /// Returns a list of telemetry configurations for Amazon Web Services resources
    /// supported by telemetry config. For more information, see [Auditing
    /// CloudWatch telemetry
    /// configurations](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/telemetry-config-cloudwatch.html).
    pub fn listResourceTelemetry(self: *Self, allocator: std.mem.Allocator, input: list_resource_telemetry.ListResourceTelemetryInput, options: CallOptions) !list_resource_telemetry.ListResourceTelemetryOutput {
        return list_resource_telemetry.execute(self, allocator, input, options);
    }

    /// Returns a list of telemetry configurations for Amazon Web Services resources
    /// supported by telemetry config in the organization.
    pub fn listResourceTelemetryForOrganization(self: *Self, allocator: std.mem.Allocator, input: list_resource_telemetry_for_organization.ListResourceTelemetryForOrganizationInput, options: CallOptions) !list_resource_telemetry_for_organization.ListResourceTelemetryForOrganizationOutput {
        return list_resource_telemetry_for_organization.execute(self, allocator, input, options);
    }

    /// Lists all S3 Table integrations in your account. We recommend using
    /// pagination to ensure that the operation returns quickly and successfully.
    pub fn listS3TableIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_s3_table_integrations.ListS3TableIntegrationsInput, options: CallOptions) !list_s3_table_integrations.ListS3TableIntegrationsOutput {
        return list_s3_table_integrations.execute(self, allocator, input, options);
    }

    /// Lists all tags attached to the specified resource. Supports telemetry rule
    /// resources and telemetry pipeline resources.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of telemetry pipelines in your account. Returns up to 100
    /// results. If more than 100 telemetry pipelines exist, include the `NextToken`
    /// value from the response to retrieve the next set of results.
    pub fn listTelemetryPipelines(self: *Self, allocator: std.mem.Allocator, input: list_telemetry_pipelines.ListTelemetryPipelinesInput, options: CallOptions) !list_telemetry_pipelines.ListTelemetryPipelinesOutput {
        return list_telemetry_pipelines.execute(self, allocator, input, options);
    }

    /// Lists all telemetry rules in your account. You can filter the results by
    /// specifying a rule name prefix.
    pub fn listTelemetryRules(self: *Self, allocator: std.mem.Allocator, input: list_telemetry_rules.ListTelemetryRulesInput, options: CallOptions) !list_telemetry_rules.ListTelemetryRulesOutput {
        return list_telemetry_rules.execute(self, allocator, input, options);
    }

    /// Lists all telemetry rules in your organization. This operation can only be
    /// called by the organization's management account or a delegated administrator
    /// account.
    pub fn listTelemetryRulesForOrganization(self: *Self, allocator: std.mem.Allocator, input: list_telemetry_rules_for_organization.ListTelemetryRulesForOrganizationInput, options: CallOptions) !list_telemetry_rules_for_organization.ListTelemetryRulesForOrganizationOutput {
        return list_telemetry_rules_for_organization.execute(self, allocator, input, options);
    }

    /// Enables the resource tags for telemetry feature for your account, which
    /// enhances telemetry data with additional resource metadata from Resource
    /// Explorer to provide richer context for monitoring and observability.
    pub fn startTelemetryEnrichment(self: *Self, allocator: std.mem.Allocator, input: start_telemetry_enrichment.StartTelemetryEnrichmentInput, options: CallOptions) !start_telemetry_enrichment.StartTelemetryEnrichmentOutput {
        return start_telemetry_enrichment.execute(self, allocator, input, options);
    }

    /// This action begins onboarding the caller Amazon Web Services account to the
    /// telemetry config feature.
    pub fn startTelemetryEvaluation(self: *Self, allocator: std.mem.Allocator, input: start_telemetry_evaluation.StartTelemetryEvaluationInput, options: CallOptions) !start_telemetry_evaluation.StartTelemetryEvaluationOutput {
        return start_telemetry_evaluation.execute(self, allocator, input, options);
    }

    /// This actions begins onboarding the organization and all member accounts to
    /// the telemetry config feature.
    pub fn startTelemetryEvaluationForOrganization(self: *Self, allocator: std.mem.Allocator, input: start_telemetry_evaluation_for_organization.StartTelemetryEvaluationForOrganizationInput, options: CallOptions) !start_telemetry_evaluation_for_organization.StartTelemetryEvaluationForOrganizationOutput {
        return start_telemetry_evaluation_for_organization.execute(self, allocator, input, options);
    }

    /// Disables the resource tags for telemetry feature for your account, stopping
    /// the enhancement of telemetry data with additional resource metadata.
    pub fn stopTelemetryEnrichment(self: *Self, allocator: std.mem.Allocator, input: stop_telemetry_enrichment.StopTelemetryEnrichmentInput, options: CallOptions) !stop_telemetry_enrichment.StopTelemetryEnrichmentOutput {
        return stop_telemetry_enrichment.execute(self, allocator, input, options);
    }

    /// This action begins offboarding the caller Amazon Web Services account from
    /// the telemetry config feature.
    pub fn stopTelemetryEvaluation(self: *Self, allocator: std.mem.Allocator, input: stop_telemetry_evaluation.StopTelemetryEvaluationInput, options: CallOptions) !stop_telemetry_evaluation.StopTelemetryEvaluationOutput {
        return stop_telemetry_evaluation.execute(self, allocator, input, options);
    }

    /// This action offboards the Organization of the caller Amazon Web Services
    /// account from the telemetry config feature.
    pub fn stopTelemetryEvaluationForOrganization(self: *Self, allocator: std.mem.Allocator, input: stop_telemetry_evaluation_for_organization.StopTelemetryEvaluationForOrganizationInput, options: CallOptions) !stop_telemetry_evaluation_for_organization.StopTelemetryEvaluationForOrganizationOutput {
        return stop_telemetry_evaluation_for_organization.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a resource. Supports telemetry rule resources and
    /// telemetry pipeline resources.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests a pipeline configuration with sample records to validate data
    /// processing before deployment. This operation helps ensure your pipeline
    /// configuration works as expected.
    pub fn testTelemetryPipeline(self: *Self, allocator: std.mem.Allocator, input: test_telemetry_pipeline.TestTelemetryPipelineInput, options: CallOptions) !test_telemetry_pipeline.TestTelemetryPipelineOutput {
        return test_telemetry_pipeline.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource. Supports telemetry rule resources and
    /// telemetry pipeline resources.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing centralization rule that applies across an Amazon Web
    /// Services Organization. This operation can only be called by the
    /// organization's management account or a delegated administrator account.
    pub fn updateCentralizationRuleForOrganization(self: *Self, allocator: std.mem.Allocator, input: update_centralization_rule_for_organization.UpdateCentralizationRuleForOrganizationInput, options: CallOptions) !update_centralization_rule_for_organization.UpdateCentralizationRuleForOrganizationOutput {
        return update_centralization_rule_for_organization.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing telemetry pipeline.
    ///
    /// The following attributes cannot be updated after pipeline creation:
    ///
    /// * **Pipeline name** - The pipeline name is immutable
    /// * **Pipeline ARN** - The ARN is automatically generated and cannot be
    ///   changed
    /// * **Source type** - Once a pipeline is created with a specific source type
    ///   (such as S3, CloudWatch Logs, GitHub, or third-party sources), it cannot
    ///   be changed to a different source type
    ///
    /// Processors can be added, removed, or modified. However, some processors are
    /// not supported for third-party pipelines and cannot be added through updates.
    ///
    /// **Source-Specific Update Rules**
    ///
    /// **CloudWatch Logs Sources (Vended and Custom)**
    ///
    /// **Updatable:** `sts_role_arn`
    ///
    /// **Fixed:** `data_source_name`, `data_source_type`, sink (must remain
    /// `@original`)
    ///
    /// **S3 Sources (Crowdstrike, Zscaler, SentinelOne, Custom)**
    ///
    /// **Updatable:** All SQS configuration parameters, `sts_role_arn`, codec
    /// settings, compression type, bucket ownership settings, sink log group
    ///
    /// **Fixed:** `notification_type`, `aws.region`
    ///
    /// **GitHub Audit Logs**
    ///
    /// **Updatable:** All Amazon Web Services Secrets Manager attributes, `scope`
    /// (can switch between ORGANIZATION/ENTERPRISE), `organization` or `enterprise`
    /// name, `range`, authentication credentials (PAT or GitHub App)
    ///
    /// **Microsoft Sources (Entra ID, Office365, Windows)**
    ///
    /// **Updatable:** All Amazon Web Services Secrets Manager attributes,
    /// `tenant_id`, `workspace_id` (Windows only), OAuth2 credentials (`client_id`,
    /// `client_secret`)
    ///
    /// **Okta Sources (SSO, Auth0)**
    ///
    /// **Updatable:** All Amazon Web Services Secrets Manager attributes, `domain`,
    /// `range` (SSO only), OAuth2 credentials (`client_id`, `client_secret`)
    ///
    /// **Palo Alto Networks**
    ///
    /// **Updatable:** All Amazon Web Services Secrets Manager attributes,
    /// `hostname`, basic authentication credentials (`username`, `password`)
    ///
    /// **ServiceNow CMDB**
    ///
    /// **Updatable:** All Amazon Web Services Secrets Manager attributes,
    /// `instance_url`, `range`, OAuth2 credentials (`client_id`, `client_secret`)
    ///
    /// **Wiz CNAPP**
    ///
    /// **Updatable:** All Amazon Web Services Secrets Manager attributes, `region`,
    /// `range`, OAuth2 credentials (`client_id`, `client_secret`)
    pub fn updateTelemetryPipeline(self: *Self, allocator: std.mem.Allocator, input: update_telemetry_pipeline.UpdateTelemetryPipelineInput, options: CallOptions) !update_telemetry_pipeline.UpdateTelemetryPipelineOutput {
        return update_telemetry_pipeline.execute(self, allocator, input, options);
    }

    /// Updates an existing telemetry rule in your account. If multiple users
    /// attempt to modify the same telemetry rule simultaneously, a
    /// ConflictException is returned to provide specific error information for
    /// concurrent modification scenarios.
    pub fn updateTelemetryRule(self: *Self, allocator: std.mem.Allocator, input: update_telemetry_rule.UpdateTelemetryRuleInput, options: CallOptions) !update_telemetry_rule.UpdateTelemetryRuleOutput {
        return update_telemetry_rule.execute(self, allocator, input, options);
    }

    /// Updates an existing telemetry rule that applies across an Amazon Web
    /// Services Organization. This operation can only be called by the
    /// organization's management account or a delegated administrator account.
    pub fn updateTelemetryRuleForOrganization(self: *Self, allocator: std.mem.Allocator, input: update_telemetry_rule_for_organization.UpdateTelemetryRuleForOrganizationInput, options: CallOptions) !update_telemetry_rule_for_organization.UpdateTelemetryRuleForOrganizationOutput {
        return update_telemetry_rule_for_organization.execute(self, allocator, input, options);
    }

    /// Validates a pipeline configuration without creating the pipeline. This
    /// operation checks the configuration for syntax errors and compatibility
    /// issues.
    pub fn validateTelemetryPipelineConfiguration(self: *Self, allocator: std.mem.Allocator, input: validate_telemetry_pipeline_configuration.ValidateTelemetryPipelineConfigurationInput, options: CallOptions) !validate_telemetry_pipeline_configuration.ValidateTelemetryPipelineConfigurationOutput {
        return validate_telemetry_pipeline_configuration.execute(self, allocator, input, options);
    }

    pub fn listCentralizationRulesForOrganizationPaginator(self: *Self, params: list_centralization_rules_for_organization.ListCentralizationRulesForOrganizationInput) paginator.ListCentralizationRulesForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceTelemetryPaginator(self: *Self, params: list_resource_telemetry.ListResourceTelemetryInput) paginator.ListResourceTelemetryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceTelemetryForOrganizationPaginator(self: *Self, params: list_resource_telemetry_for_organization.ListResourceTelemetryForOrganizationInput) paginator.ListResourceTelemetryForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listS3TableIntegrationsPaginator(self: *Self, params: list_s3_table_integrations.ListS3TableIntegrationsInput) paginator.ListS3TableIntegrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTelemetryPipelinesPaginator(self: *Self, params: list_telemetry_pipelines.ListTelemetryPipelinesInput) paginator.ListTelemetryPipelinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTelemetryRulesPaginator(self: *Self, params: list_telemetry_rules.ListTelemetryRulesInput) paginator.ListTelemetryRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTelemetryRulesForOrganizationPaginator(self: *Self, params: list_telemetry_rules_for_organization.ListTelemetryRulesForOrganizationInput) paginator.ListTelemetryRulesForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

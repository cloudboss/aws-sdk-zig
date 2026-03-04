const aws = @import("aws");
const std = @import("std");

const accept_resource_grouping_recommendations = @import("accept_resource_grouping_recommendations.zig");
const add_draft_app_version_resource_mappings = @import("add_draft_app_version_resource_mappings.zig");
const batch_update_recommendation_status = @import("batch_update_recommendation_status.zig");
const create_app = @import("create_app.zig");
const create_app_version_app_component = @import("create_app_version_app_component.zig");
const create_app_version_resource = @import("create_app_version_resource.zig");
const create_recommendation_template = @import("create_recommendation_template.zig");
const create_resiliency_policy = @import("create_resiliency_policy.zig");
const delete_app = @import("delete_app.zig");
const delete_app_assessment = @import("delete_app_assessment.zig");
const delete_app_input_source = @import("delete_app_input_source.zig");
const delete_app_version_app_component = @import("delete_app_version_app_component.zig");
const delete_app_version_resource = @import("delete_app_version_resource.zig");
const delete_recommendation_template = @import("delete_recommendation_template.zig");
const delete_resiliency_policy = @import("delete_resiliency_policy.zig");
const describe_app = @import("describe_app.zig");
const describe_app_assessment = @import("describe_app_assessment.zig");
const describe_app_version = @import("describe_app_version.zig");
const describe_app_version_app_component = @import("describe_app_version_app_component.zig");
const describe_app_version_resource = @import("describe_app_version_resource.zig");
const describe_app_version_resources_resolution_status = @import("describe_app_version_resources_resolution_status.zig");
const describe_app_version_template = @import("describe_app_version_template.zig");
const describe_draft_app_version_resources_import_status = @import("describe_draft_app_version_resources_import_status.zig");
const describe_metrics_export = @import("describe_metrics_export.zig");
const describe_resiliency_policy = @import("describe_resiliency_policy.zig");
const describe_resource_grouping_recommendation_task = @import("describe_resource_grouping_recommendation_task.zig");
const import_resources_to_draft_app_version = @import("import_resources_to_draft_app_version.zig");
const list_alarm_recommendations = @import("list_alarm_recommendations.zig");
const list_app_assessment_compliance_drifts = @import("list_app_assessment_compliance_drifts.zig");
const list_app_assessment_resource_drifts = @import("list_app_assessment_resource_drifts.zig");
const list_app_assessments = @import("list_app_assessments.zig");
const list_app_component_compliances = @import("list_app_component_compliances.zig");
const list_app_component_recommendations = @import("list_app_component_recommendations.zig");
const list_app_input_sources = @import("list_app_input_sources.zig");
const list_app_version_app_components = @import("list_app_version_app_components.zig");
const list_app_version_resource_mappings = @import("list_app_version_resource_mappings.zig");
const list_app_version_resources = @import("list_app_version_resources.zig");
const list_app_versions = @import("list_app_versions.zig");
const list_apps = @import("list_apps.zig");
const list_metrics = @import("list_metrics.zig");
const list_recommendation_templates = @import("list_recommendation_templates.zig");
const list_resiliency_policies = @import("list_resiliency_policies.zig");
const list_resource_grouping_recommendations = @import("list_resource_grouping_recommendations.zig");
const list_sop_recommendations = @import("list_sop_recommendations.zig");
const list_suggested_resiliency_policies = @import("list_suggested_resiliency_policies.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_test_recommendations = @import("list_test_recommendations.zig");
const list_unsupported_app_version_resources = @import("list_unsupported_app_version_resources.zig");
const publish_app_version = @import("publish_app_version.zig");
const put_draft_app_version_template = @import("put_draft_app_version_template.zig");
const reject_resource_grouping_recommendations = @import("reject_resource_grouping_recommendations.zig");
const remove_draft_app_version_resource_mappings = @import("remove_draft_app_version_resource_mappings.zig");
const resolve_app_version_resources = @import("resolve_app_version_resources.zig");
const start_app_assessment = @import("start_app_assessment.zig");
const start_metrics_export = @import("start_metrics_export.zig");
const start_resource_grouping_recommendation_task = @import("start_resource_grouping_recommendation_task.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_app = @import("update_app.zig");
const update_app_version = @import("update_app_version.zig");
const update_app_version_app_component = @import("update_app_version_app_component.zig");
const update_app_version_resource = @import("update_app_version_resource.zig");
const update_resiliency_policy = @import("update_resiliency_policy.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "resiliencehub";

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

    /// Accepts the resource grouping recommendations suggested by Resilience Hub
    /// for your application.
    pub fn acceptResourceGroupingRecommendations(self: *Self, allocator: std.mem.Allocator, input: accept_resource_grouping_recommendations.AcceptResourceGroupingRecommendationsInput, options: CallOptions) !accept_resource_grouping_recommendations.AcceptResourceGroupingRecommendationsOutput {
        return accept_resource_grouping_recommendations.execute(self, allocator, input, options);
    }

    /// Adds the source of resource-maps to the draft version of an application.
    /// During
    /// assessment, Resilience Hub will use these resource-maps to resolve the
    /// latest physical
    /// ID for each resource in the application template. For more information about
    /// different types
    /// of resources supported by Resilience Hub and how to add them in your
    /// application, see
    /// [Step
    /// 2: How is your application
    /// managed?](https://docs.aws.amazon.com/resilience-hub/latest/userguide/how-app-manage.html) in the Resilience Hub User Guide.
    pub fn addDraftAppVersionResourceMappings(self: *Self, allocator: std.mem.Allocator, input: add_draft_app_version_resource_mappings.AddDraftAppVersionResourceMappingsInput, options: CallOptions) !add_draft_app_version_resource_mappings.AddDraftAppVersionResourceMappingsOutput {
        return add_draft_app_version_resource_mappings.execute(self, allocator, input, options);
    }

    /// Enables you to include or exclude one or more operational recommendations.
    pub fn batchUpdateRecommendationStatus(self: *Self, allocator: std.mem.Allocator, input: batch_update_recommendation_status.BatchUpdateRecommendationStatusInput, options: CallOptions) !batch_update_recommendation_status.BatchUpdateRecommendationStatusOutput {
        return batch_update_recommendation_status.execute(self, allocator, input, options);
    }

    /// Creates an Resilience Hub application. An Resilience Hub application is a
    /// collection of Amazon Web Services resources structured to prevent and
    /// recover Amazon Web Services application disruptions. To describe a
    /// Resilience Hub application, you provide an
    /// application name, resources from one or more CloudFormation stacks, Resource
    /// Groups, Terraform state files, AppRegistry applications, and an appropriate
    /// resiliency policy. In addition, you can also add resources that are located
    /// on Amazon Elastic Kubernetes Service (Amazon EKS) clusters as optional
    /// resources. For more information
    /// about the number of resources supported per application, see [Service
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/resiliencehub.html#limits_resiliencehub).
    ///
    /// After you create an Resilience Hub application, you publish it so that you
    /// can run
    /// a resiliency assessment on it. You can then use recommendations from the
    /// assessment to improve
    /// resiliency by running another assessment, comparing results, and then
    /// iterating the process
    /// until you achieve your goals for recovery time objective (RTO) and recovery
    /// point objective
    /// (RPO).
    pub fn createApp(self: *Self, allocator: std.mem.Allocator, input: create_app.CreateAppInput, options: CallOptions) !create_app.CreateAppOutput {
        return create_app.execute(self, allocator, input, options);
    }

    /// Creates a new Application Component in the Resilience Hub application.
    ///
    /// This API updates the Resilience Hub application draft version. To use this
    /// Application Component for running assessments, you must publish the
    /// Resilience Hub
    /// application using the `PublishAppVersion` API.
    pub fn createAppVersionAppComponent(self: *Self, allocator: std.mem.Allocator, input: create_app_version_app_component.CreateAppVersionAppComponentInput, options: CallOptions) !create_app_version_app_component.CreateAppVersionAppComponentOutput {
        return create_app_version_app_component.execute(self, allocator, input, options);
    }

    /// Adds a resource to the Resilience Hub application and assigns it to the
    /// specified
    /// Application Components. If you specify a new Application Component,
    /// Resilience Hub will
    /// automatically create the Application Component.
    ///
    /// * This action has no effect outside Resilience Hub.
    ///
    /// * This API updates the Resilience Hub application draft version. To use this
    /// resource for running resiliency assessments, you must publish the Resilience
    /// Hub
    /// application using the `PublishAppVersion` API.
    ///
    /// * To update application version with new `physicalResourceID`, you must
    /// call `ResolveAppVersionResources` API.
    pub fn createAppVersionResource(self: *Self, allocator: std.mem.Allocator, input: create_app_version_resource.CreateAppVersionResourceInput, options: CallOptions) !create_app_version_resource.CreateAppVersionResourceOutput {
        return create_app_version_resource.execute(self, allocator, input, options);
    }

    /// Creates a new recommendation template for the Resilience Hub application.
    pub fn createRecommendationTemplate(self: *Self, allocator: std.mem.Allocator, input: create_recommendation_template.CreateRecommendationTemplateInput, options: CallOptions) !create_recommendation_template.CreateRecommendationTemplateOutput {
        return create_recommendation_template.execute(self, allocator, input, options);
    }

    /// Creates a resiliency policy for an application.
    ///
    /// Resilience Hub allows you to provide a value of zero for `rtoInSecs`
    /// and `rpoInSecs` of your resiliency policy. But, while assessing your
    /// application,
    /// the lowest possible assessment result is near zero. Hence, if you provide
    /// value zero for
    /// `rtoInSecs` and `rpoInSecs`, the estimated workload RTO and
    /// estimated workload RPO result will be near zero and the **Compliance
    /// status** for your application will be set to **Policy
    /// breached**.
    pub fn createResiliencyPolicy(self: *Self, allocator: std.mem.Allocator, input: create_resiliency_policy.CreateResiliencyPolicyInput, options: CallOptions) !create_resiliency_policy.CreateResiliencyPolicyOutput {
        return create_resiliency_policy.execute(self, allocator, input, options);
    }

    /// Deletes an Resilience Hub application. This is a destructive action that
    /// can't be
    /// undone.
    pub fn deleteApp(self: *Self, allocator: std.mem.Allocator, input: delete_app.DeleteAppInput, options: CallOptions) !delete_app.DeleteAppOutput {
        return delete_app.execute(self, allocator, input, options);
    }

    /// Deletes an Resilience Hub application assessment. This is a destructive
    /// action
    /// that can't be undone.
    pub fn deleteAppAssessment(self: *Self, allocator: std.mem.Allocator, input: delete_app_assessment.DeleteAppAssessmentInput, options: CallOptions) !delete_app_assessment.DeleteAppAssessmentOutput {
        return delete_app_assessment.execute(self, allocator, input, options);
    }

    /// Deletes the input source and all of its imported resources from the
    /// Resilience Hub
    /// application.
    pub fn deleteAppInputSource(self: *Self, allocator: std.mem.Allocator, input: delete_app_input_source.DeleteAppInputSourceInput, options: CallOptions) !delete_app_input_source.DeleteAppInputSourceOutput {
        return delete_app_input_source.execute(self, allocator, input, options);
    }

    /// Deletes an Application Component from the Resilience Hub application.
    ///
    /// * This API updates the Resilience Hub application draft version. To use this
    /// Application Component for running assessments, you must publish the
    /// Resilience Hub
    /// application using the `PublishAppVersion` API.
    ///
    /// * You will not be able to delete an Application Component if it has
    ///   resources associated
    /// with it.
    pub fn deleteAppVersionAppComponent(self: *Self, allocator: std.mem.Allocator, input: delete_app_version_app_component.DeleteAppVersionAppComponentInput, options: CallOptions) !delete_app_version_app_component.DeleteAppVersionAppComponentOutput {
        return delete_app_version_app_component.execute(self, allocator, input, options);
    }

    /// Deletes a resource from the Resilience Hub application.
    ///
    /// * You can only delete a manually added resource. To exclude non-manually
    ///   added
    /// resources, use the `UpdateAppVersionResource` API.
    ///
    /// * This action has no effect outside Resilience Hub.
    ///
    /// * This API updates the Resilience Hub application draft version. To use this
    /// resource for running resiliency assessments, you must publish the Resilience
    /// Hub
    /// application using the `PublishAppVersion` API.
    pub fn deleteAppVersionResource(self: *Self, allocator: std.mem.Allocator, input: delete_app_version_resource.DeleteAppVersionResourceInput, options: CallOptions) !delete_app_version_resource.DeleteAppVersionResourceOutput {
        return delete_app_version_resource.execute(self, allocator, input, options);
    }

    /// Deletes a recommendation template. This is a destructive action that can't
    /// be
    /// undone.
    pub fn deleteRecommendationTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_recommendation_template.DeleteRecommendationTemplateInput, options: CallOptions) !delete_recommendation_template.DeleteRecommendationTemplateOutput {
        return delete_recommendation_template.execute(self, allocator, input, options);
    }

    /// Deletes a resiliency policy. This is a destructive action that can't be
    /// undone.
    pub fn deleteResiliencyPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resiliency_policy.DeleteResiliencyPolicyInput, options: CallOptions) !delete_resiliency_policy.DeleteResiliencyPolicyOutput {
        return delete_resiliency_policy.execute(self, allocator, input, options);
    }

    /// Describes an Resilience Hub application.
    pub fn describeApp(self: *Self, allocator: std.mem.Allocator, input: describe_app.DescribeAppInput, options: CallOptions) !describe_app.DescribeAppOutput {
        return describe_app.execute(self, allocator, input, options);
    }

    /// Describes an assessment for an Resilience Hub application.
    pub fn describeAppAssessment(self: *Self, allocator: std.mem.Allocator, input: describe_app_assessment.DescribeAppAssessmentInput, options: CallOptions) !describe_app_assessment.DescribeAppAssessmentOutput {
        return describe_app_assessment.execute(self, allocator, input, options);
    }

    /// Describes the Resilience Hub application version.
    pub fn describeAppVersion(self: *Self, allocator: std.mem.Allocator, input: describe_app_version.DescribeAppVersionInput, options: CallOptions) !describe_app_version.DescribeAppVersionOutput {
        return describe_app_version.execute(self, allocator, input, options);
    }

    /// Describes an Application Component in the Resilience Hub application.
    pub fn describeAppVersionAppComponent(self: *Self, allocator: std.mem.Allocator, input: describe_app_version_app_component.DescribeAppVersionAppComponentInput, options: CallOptions) !describe_app_version_app_component.DescribeAppVersionAppComponentOutput {
        return describe_app_version_app_component.execute(self, allocator, input, options);
    }

    /// Describes a resource of the Resilience Hub application.
    ///
    /// This API accepts only one of the following parameters to describe the
    /// resource:
    ///
    /// * `resourceName`
    ///
    /// * `logicalResourceId`
    ///
    /// * `physicalResourceId` (Along with `physicalResourceId`, you can
    /// also provide `awsAccountId`, and `awsRegion`)
    pub fn describeAppVersionResource(self: *Self, allocator: std.mem.Allocator, input: describe_app_version_resource.DescribeAppVersionResourceInput, options: CallOptions) !describe_app_version_resource.DescribeAppVersionResourceOutput {
        return describe_app_version_resource.execute(self, allocator, input, options);
    }

    /// Returns the resolution status for the specified resolution identifier for an
    /// application
    /// version. If `resolutionId` is not specified, the current resolution status
    /// is
    /// returned.
    pub fn describeAppVersionResourcesResolutionStatus(self: *Self, allocator: std.mem.Allocator, input: describe_app_version_resources_resolution_status.DescribeAppVersionResourcesResolutionStatusInput, options: CallOptions) !describe_app_version_resources_resolution_status.DescribeAppVersionResourcesResolutionStatusOutput {
        return describe_app_version_resources_resolution_status.execute(self, allocator, input, options);
    }

    /// Describes details about an Resilience Hub application.
    pub fn describeAppVersionTemplate(self: *Self, allocator: std.mem.Allocator, input: describe_app_version_template.DescribeAppVersionTemplateInput, options: CallOptions) !describe_app_version_template.DescribeAppVersionTemplateOutput {
        return describe_app_version_template.execute(self, allocator, input, options);
    }

    /// Describes the status of importing resources to an application version.
    ///
    /// If you get a 404 error with
    /// `ResourceImportStatusNotFoundAppMetadataException`, you must call
    /// `importResourcesToDraftAppVersion` after creating the application and before
    /// calling `describeDraftAppVersionResourcesImportStatus` to obtain the
    /// status.
    pub fn describeDraftAppVersionResourcesImportStatus(self: *Self, allocator: std.mem.Allocator, input: describe_draft_app_version_resources_import_status.DescribeDraftAppVersionResourcesImportStatusInput, options: CallOptions) !describe_draft_app_version_resources_import_status.DescribeDraftAppVersionResourcesImportStatusOutput {
        return describe_draft_app_version_resources_import_status.execute(self, allocator, input, options);
    }

    /// Describes the metrics of the application configuration being exported.
    pub fn describeMetricsExport(self: *Self, allocator: std.mem.Allocator, input: describe_metrics_export.DescribeMetricsExportInput, options: CallOptions) !describe_metrics_export.DescribeMetricsExportOutput {
        return describe_metrics_export.execute(self, allocator, input, options);
    }

    /// Describes a specified resiliency policy for an Resilience Hub application.
    /// The
    /// returned policy object includes creation time, data location constraints,
    /// the Amazon Resource
    /// Name (ARN) for the policy, tags, tier, and more.
    pub fn describeResiliencyPolicy(self: *Self, allocator: std.mem.Allocator, input: describe_resiliency_policy.DescribeResiliencyPolicyInput, options: CallOptions) !describe_resiliency_policy.DescribeResiliencyPolicyOutput {
        return describe_resiliency_policy.execute(self, allocator, input, options);
    }

    /// Describes the resource grouping recommendation tasks run by Resilience Hub
    /// for your application.
    pub fn describeResourceGroupingRecommendationTask(self: *Self, allocator: std.mem.Allocator, input: describe_resource_grouping_recommendation_task.DescribeResourceGroupingRecommendationTaskInput, options: CallOptions) !describe_resource_grouping_recommendation_task.DescribeResourceGroupingRecommendationTaskOutput {
        return describe_resource_grouping_recommendation_task.execute(self, allocator, input, options);
    }

    /// Imports resources to Resilience Hub application draft version from different
    /// input
    /// sources. For more information about the input sources supported by
    /// Resilience Hub, see
    /// [Discover the structure and describe your Resilience Hub
    /// application](https://docs.aws.amazon.com/resilience-hub/latest/userguide/discover-structure.html).
    pub fn importResourcesToDraftAppVersion(self: *Self, allocator: std.mem.Allocator, input: import_resources_to_draft_app_version.ImportResourcesToDraftAppVersionInput, options: CallOptions) !import_resources_to_draft_app_version.ImportResourcesToDraftAppVersionOutput {
        return import_resources_to_draft_app_version.execute(self, allocator, input, options);
    }

    /// Lists the alarm recommendations for an Resilience Hub application.
    pub fn listAlarmRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_alarm_recommendations.ListAlarmRecommendationsInput, options: CallOptions) !list_alarm_recommendations.ListAlarmRecommendationsOutput {
        return list_alarm_recommendations.execute(self, allocator, input, options);
    }

    /// List of compliance drifts that were detected while running an
    /// assessment.
    pub fn listAppAssessmentComplianceDrifts(self: *Self, allocator: std.mem.Allocator, input: list_app_assessment_compliance_drifts.ListAppAssessmentComplianceDriftsInput, options: CallOptions) !list_app_assessment_compliance_drifts.ListAppAssessmentComplianceDriftsOutput {
        return list_app_assessment_compliance_drifts.execute(self, allocator, input, options);
    }

    /// List of resource drifts that were detected while running an
    /// assessment.
    pub fn listAppAssessmentResourceDrifts(self: *Self, allocator: std.mem.Allocator, input: list_app_assessment_resource_drifts.ListAppAssessmentResourceDriftsInput, options: CallOptions) !list_app_assessment_resource_drifts.ListAppAssessmentResourceDriftsOutput {
        return list_app_assessment_resource_drifts.execute(self, allocator, input, options);
    }

    /// Lists the assessments for an Resilience Hub application. You can use request
    /// parameters to refine the results for the response object.
    pub fn listAppAssessments(self: *Self, allocator: std.mem.Allocator, input: list_app_assessments.ListAppAssessmentsInput, options: CallOptions) !list_app_assessments.ListAppAssessmentsOutput {
        return list_app_assessments.execute(self, allocator, input, options);
    }

    /// Lists the compliances for an Resilience Hub Application Component.
    pub fn listAppComponentCompliances(self: *Self, allocator: std.mem.Allocator, input: list_app_component_compliances.ListAppComponentCompliancesInput, options: CallOptions) !list_app_component_compliances.ListAppComponentCompliancesOutput {
        return list_app_component_compliances.execute(self, allocator, input, options);
    }

    /// Lists the recommendations for an Resilience Hub Application Component.
    pub fn listAppComponentRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_app_component_recommendations.ListAppComponentRecommendationsInput, options: CallOptions) !list_app_component_recommendations.ListAppComponentRecommendationsOutput {
        return list_app_component_recommendations.execute(self, allocator, input, options);
    }

    /// Lists all the input sources of the Resilience Hub application. For more
    /// information about the input sources supported by Resilience Hub, see
    /// [Discover
    /// the structure and describe your Resilience Hub
    /// application](https://docs.aws.amazon.com/resilience-hub/latest/userguide/discover-structure.html).
    pub fn listAppInputSources(self: *Self, allocator: std.mem.Allocator, input: list_app_input_sources.ListAppInputSourcesInput, options: CallOptions) !list_app_input_sources.ListAppInputSourcesOutput {
        return list_app_input_sources.execute(self, allocator, input, options);
    }

    /// Lists all the Application Components in the Resilience Hub application.
    pub fn listAppVersionAppComponents(self: *Self, allocator: std.mem.Allocator, input: list_app_version_app_components.ListAppVersionAppComponentsInput, options: CallOptions) !list_app_version_app_components.ListAppVersionAppComponentsOutput {
        return list_app_version_app_components.execute(self, allocator, input, options);
    }

    /// Lists how the resources in an application version are mapped/sourced from.
    /// Mappings can be
    /// physical resource identifiers, CloudFormation stacks, resource-groups, or an
    /// application registry
    /// app.
    pub fn listAppVersionResourceMappings(self: *Self, allocator: std.mem.Allocator, input: list_app_version_resource_mappings.ListAppVersionResourceMappingsInput, options: CallOptions) !list_app_version_resource_mappings.ListAppVersionResourceMappingsOutput {
        return list_app_version_resource_mappings.execute(self, allocator, input, options);
    }

    /// Lists all the resources in an Resilience Hub application.
    pub fn listAppVersionResources(self: *Self, allocator: std.mem.Allocator, input: list_app_version_resources.ListAppVersionResourcesInput, options: CallOptions) !list_app_version_resources.ListAppVersionResourcesOutput {
        return list_app_version_resources.execute(self, allocator, input, options);
    }

    /// Lists the different versions for the Resilience Hub applications.
    pub fn listAppVersions(self: *Self, allocator: std.mem.Allocator, input: list_app_versions.ListAppVersionsInput, options: CallOptions) !list_app_versions.ListAppVersionsOutput {
        return list_app_versions.execute(self, allocator, input, options);
    }

    /// Lists your Resilience Hub applications.
    ///
    /// You can filter applications using only one filter at a time or without using
    /// any filter.
    /// If you try to filter applications using multiple filters, you will get the
    /// following
    /// error:
    ///
    /// `An error occurred (ValidationException) when calling the ListApps
    /// operation: Only
    /// one filter is supported for this operation.`
    pub fn listApps(self: *Self, allocator: std.mem.Allocator, input: list_apps.ListAppsInput, options: CallOptions) !list_apps.ListAppsOutput {
        return list_apps.execute(self, allocator, input, options);
    }

    /// Lists the metrics that can be exported.
    pub fn listMetrics(self: *Self, allocator: std.mem.Allocator, input: list_metrics.ListMetricsInput, options: CallOptions) !list_metrics.ListMetricsOutput {
        return list_metrics.execute(self, allocator, input, options);
    }

    /// Lists the recommendation templates for the Resilience Hub applications.
    pub fn listRecommendationTemplates(self: *Self, allocator: std.mem.Allocator, input: list_recommendation_templates.ListRecommendationTemplatesInput, options: CallOptions) !list_recommendation_templates.ListRecommendationTemplatesOutput {
        return list_recommendation_templates.execute(self, allocator, input, options);
    }

    /// Lists the resiliency policies for the Resilience Hub applications.
    pub fn listResiliencyPolicies(self: *Self, allocator: std.mem.Allocator, input: list_resiliency_policies.ListResiliencyPoliciesInput, options: CallOptions) !list_resiliency_policies.ListResiliencyPoliciesOutput {
        return list_resiliency_policies.execute(self, allocator, input, options);
    }

    /// Lists the resource grouping recommendations suggested by Resilience Hub for
    /// your application.
    pub fn listResourceGroupingRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_resource_grouping_recommendations.ListResourceGroupingRecommendationsInput, options: CallOptions) !list_resource_grouping_recommendations.ListResourceGroupingRecommendationsOutput {
        return list_resource_grouping_recommendations.execute(self, allocator, input, options);
    }

    /// Lists the standard operating procedure (SOP) recommendations for the
    /// Resilience Hub applications.
    pub fn listSopRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_sop_recommendations.ListSopRecommendationsInput, options: CallOptions) !list_sop_recommendations.ListSopRecommendationsOutput {
        return list_sop_recommendations.execute(self, allocator, input, options);
    }

    /// Lists the suggested resiliency policies for the Resilience Hub
    /// applications.
    pub fn listSuggestedResiliencyPolicies(self: *Self, allocator: std.mem.Allocator, input: list_suggested_resiliency_policies.ListSuggestedResiliencyPoliciesInput, options: CallOptions) !list_suggested_resiliency_policies.ListSuggestedResiliencyPoliciesOutput {
        return list_suggested_resiliency_policies.execute(self, allocator, input, options);
    }

    /// Lists the tags for your resources in your Resilience Hub applications.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the test recommendations for the Resilience Hub application.
    pub fn listTestRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_test_recommendations.ListTestRecommendationsInput, options: CallOptions) !list_test_recommendations.ListTestRecommendationsOutput {
        return list_test_recommendations.execute(self, allocator, input, options);
    }

    /// Lists the resources that are not currently supported in Resilience Hub. An
    /// unsupported resource is a resource that exists in the object that was used
    /// to create an app,
    /// but is not supported by Resilience Hub.
    pub fn listUnsupportedAppVersionResources(self: *Self, allocator: std.mem.Allocator, input: list_unsupported_app_version_resources.ListUnsupportedAppVersionResourcesInput, options: CallOptions) !list_unsupported_app_version_resources.ListUnsupportedAppVersionResourcesOutput {
        return list_unsupported_app_version_resources.execute(self, allocator, input, options);
    }

    /// Publishes a new version of a specific Resilience Hub application.
    pub fn publishAppVersion(self: *Self, allocator: std.mem.Allocator, input: publish_app_version.PublishAppVersionInput, options: CallOptions) !publish_app_version.PublishAppVersionOutput {
        return publish_app_version.execute(self, allocator, input, options);
    }

    /// Adds or updates the app template for an Resilience Hub application draft
    /// version.
    pub fn putDraftAppVersionTemplate(self: *Self, allocator: std.mem.Allocator, input: put_draft_app_version_template.PutDraftAppVersionTemplateInput, options: CallOptions) !put_draft_app_version_template.PutDraftAppVersionTemplateOutput {
        return put_draft_app_version_template.execute(self, allocator, input, options);
    }

    /// Rejects resource grouping recommendations.
    pub fn rejectResourceGroupingRecommendations(self: *Self, allocator: std.mem.Allocator, input: reject_resource_grouping_recommendations.RejectResourceGroupingRecommendationsInput, options: CallOptions) !reject_resource_grouping_recommendations.RejectResourceGroupingRecommendationsOutput {
        return reject_resource_grouping_recommendations.execute(self, allocator, input, options);
    }

    /// Removes resource mappings from a draft application version.
    pub fn removeDraftAppVersionResourceMappings(self: *Self, allocator: std.mem.Allocator, input: remove_draft_app_version_resource_mappings.RemoveDraftAppVersionResourceMappingsInput, options: CallOptions) !remove_draft_app_version_resource_mappings.RemoveDraftAppVersionResourceMappingsOutput {
        return remove_draft_app_version_resource_mappings.execute(self, allocator, input, options);
    }

    /// Resolves the resources for an application version.
    pub fn resolveAppVersionResources(self: *Self, allocator: std.mem.Allocator, input: resolve_app_version_resources.ResolveAppVersionResourcesInput, options: CallOptions) !resolve_app_version_resources.ResolveAppVersionResourcesOutput {
        return resolve_app_version_resources.execute(self, allocator, input, options);
    }

    /// Creates a new application assessment for an application.
    pub fn startAppAssessment(self: *Self, allocator: std.mem.Allocator, input: start_app_assessment.StartAppAssessmentInput, options: CallOptions) !start_app_assessment.StartAppAssessmentOutput {
        return start_app_assessment.execute(self, allocator, input, options);
    }

    /// Initiates the export task of metrics.
    pub fn startMetricsExport(self: *Self, allocator: std.mem.Allocator, input: start_metrics_export.StartMetricsExportInput, options: CallOptions) !start_metrics_export.StartMetricsExportOutput {
        return start_metrics_export.execute(self, allocator, input, options);
    }

    /// Starts grouping recommendation task.
    pub fn startResourceGroupingRecommendationTask(self: *Self, allocator: std.mem.Allocator, input: start_resource_grouping_recommendation_task.StartResourceGroupingRecommendationTaskInput, options: CallOptions) !start_resource_grouping_recommendation_task.StartResourceGroupingRecommendationTaskOutput {
        return start_resource_grouping_recommendation_task.execute(self, allocator, input, options);
    }

    /// Applies one or more tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an application.
    pub fn updateApp(self: *Self, allocator: std.mem.Allocator, input: update_app.UpdateAppInput, options: CallOptions) !update_app.UpdateAppOutput {
        return update_app.execute(self, allocator, input, options);
    }

    /// Updates the Resilience Hub application version.
    ///
    /// This API updates the Resilience Hub application draft version. To use this
    /// information for running resiliency assessments, you must publish the
    /// Resilience Hub
    /// application using the `PublishAppVersion` API.
    pub fn updateAppVersion(self: *Self, allocator: std.mem.Allocator, input: update_app_version.UpdateAppVersionInput, options: CallOptions) !update_app_version.UpdateAppVersionOutput {
        return update_app_version.execute(self, allocator, input, options);
    }

    /// Updates an existing Application Component in the Resilience Hub application.
    ///
    /// This API updates the Resilience Hub application draft version. To use this
    /// Application Component for running assessments, you must publish the
    /// Resilience Hub
    /// application using the `PublishAppVersion` API.
    pub fn updateAppVersionAppComponent(self: *Self, allocator: std.mem.Allocator, input: update_app_version_app_component.UpdateAppVersionAppComponentInput, options: CallOptions) !update_app_version_app_component.UpdateAppVersionAppComponentOutput {
        return update_app_version_app_component.execute(self, allocator, input, options);
    }

    /// Updates the resource details in the Resilience Hub application.
    ///
    /// * This action has no effect outside Resilience Hub.
    ///
    /// * This API updates the Resilience Hub application draft version. To use this
    /// resource for running resiliency assessments, you must publish the Resilience
    /// Hub
    /// application using the `PublishAppVersion` API.
    ///
    /// * To update application version with new `physicalResourceID`, you must
    /// call `ResolveAppVersionResources` API.
    pub fn updateAppVersionResource(self: *Self, allocator: std.mem.Allocator, input: update_app_version_resource.UpdateAppVersionResourceInput, options: CallOptions) !update_app_version_resource.UpdateAppVersionResourceOutput {
        return update_app_version_resource.execute(self, allocator, input, options);
    }

    /// Updates a resiliency policy.
    ///
    /// Resilience Hub allows you to provide a value of zero for `rtoInSecs`
    /// and `rpoInSecs` of your resiliency policy. But, while assessing your
    /// application,
    /// the lowest possible assessment result is near zero. Hence, if you provide
    /// value zero for
    /// `rtoInSecs` and `rpoInSecs`, the estimated workload RTO and
    /// estimated workload RPO result will be near zero and the **Compliance
    /// status** for your application will be set to **Policy
    /// breached**.
    pub fn updateResiliencyPolicy(self: *Self, allocator: std.mem.Allocator, input: update_resiliency_policy.UpdateResiliencyPolicyInput, options: CallOptions) !update_resiliency_policy.UpdateResiliencyPolicyOutput {
        return update_resiliency_policy.execute(self, allocator, input, options);
    }

    pub fn listAlarmRecommendationsPaginator(self: *Self, params: list_alarm_recommendations.ListAlarmRecommendationsInput) paginator.ListAlarmRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppAssessmentComplianceDriftsPaginator(self: *Self, params: list_app_assessment_compliance_drifts.ListAppAssessmentComplianceDriftsInput) paginator.ListAppAssessmentComplianceDriftsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppAssessmentResourceDriftsPaginator(self: *Self, params: list_app_assessment_resource_drifts.ListAppAssessmentResourceDriftsInput) paginator.ListAppAssessmentResourceDriftsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppAssessmentsPaginator(self: *Self, params: list_app_assessments.ListAppAssessmentsInput) paginator.ListAppAssessmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppComponentCompliancesPaginator(self: *Self, params: list_app_component_compliances.ListAppComponentCompliancesInput) paginator.ListAppComponentCompliancesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppComponentRecommendationsPaginator(self: *Self, params: list_app_component_recommendations.ListAppComponentRecommendationsInput) paginator.ListAppComponentRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppInputSourcesPaginator(self: *Self, params: list_app_input_sources.ListAppInputSourcesInput) paginator.ListAppInputSourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppVersionAppComponentsPaginator(self: *Self, params: list_app_version_app_components.ListAppVersionAppComponentsInput) paginator.ListAppVersionAppComponentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppVersionResourceMappingsPaginator(self: *Self, params: list_app_version_resource_mappings.ListAppVersionResourceMappingsInput) paginator.ListAppVersionResourceMappingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppVersionResourcesPaginator(self: *Self, params: list_app_version_resources.ListAppVersionResourcesInput) paginator.ListAppVersionResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppVersionsPaginator(self: *Self, params: list_app_versions.ListAppVersionsInput) paginator.ListAppVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppsPaginator(self: *Self, params: list_apps.ListAppsInput) paginator.ListAppsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMetricsPaginator(self: *Self, params: list_metrics.ListMetricsInput) paginator.ListMetricsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecommendationTemplatesPaginator(self: *Self, params: list_recommendation_templates.ListRecommendationTemplatesInput) paginator.ListRecommendationTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResiliencyPoliciesPaginator(self: *Self, params: list_resiliency_policies.ListResiliencyPoliciesInput) paginator.ListResiliencyPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResourceGroupingRecommendationsPaginator(self: *Self, params: list_resource_grouping_recommendations.ListResourceGroupingRecommendationsInput) paginator.ListResourceGroupingRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSopRecommendationsPaginator(self: *Self, params: list_sop_recommendations.ListSopRecommendationsInput) paginator.ListSopRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSuggestedResiliencyPoliciesPaginator(self: *Self, params: list_suggested_resiliency_policies.ListSuggestedResiliencyPoliciesInput) paginator.ListSuggestedResiliencyPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestRecommendationsPaginator(self: *Self, params: list_test_recommendations.ListTestRecommendationsInput) paginator.ListTestRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUnsupportedAppVersionResourcesPaginator(self: *Self, params: list_unsupported_app_version_resources.ListUnsupportedAppVersionResourcesInput) paginator.ListUnsupportedAppVersionResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

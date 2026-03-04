const aws = @import("aws");
const std = @import("std");

const add_attributes_to_findings = @import("add_attributes_to_findings.zig");
const create_assessment_target = @import("create_assessment_target.zig");
const create_assessment_template = @import("create_assessment_template.zig");
const create_exclusions_preview = @import("create_exclusions_preview.zig");
const create_resource_group = @import("create_resource_group.zig");
const delete_assessment_run = @import("delete_assessment_run.zig");
const delete_assessment_target = @import("delete_assessment_target.zig");
const delete_assessment_template = @import("delete_assessment_template.zig");
const describe_assessment_runs = @import("describe_assessment_runs.zig");
const describe_assessment_targets = @import("describe_assessment_targets.zig");
const describe_assessment_templates = @import("describe_assessment_templates.zig");
const describe_cross_account_access_role = @import("describe_cross_account_access_role.zig");
const describe_exclusions = @import("describe_exclusions.zig");
const describe_findings = @import("describe_findings.zig");
const describe_resource_groups = @import("describe_resource_groups.zig");
const describe_rules_packages = @import("describe_rules_packages.zig");
const get_assessment_report = @import("get_assessment_report.zig");
const get_exclusions_preview = @import("get_exclusions_preview.zig");
const get_telemetry_metadata = @import("get_telemetry_metadata.zig");
const list_assessment_run_agents = @import("list_assessment_run_agents.zig");
const list_assessment_runs = @import("list_assessment_runs.zig");
const list_assessment_targets = @import("list_assessment_targets.zig");
const list_assessment_templates = @import("list_assessment_templates.zig");
const list_event_subscriptions = @import("list_event_subscriptions.zig");
const list_exclusions = @import("list_exclusions.zig");
const list_findings = @import("list_findings.zig");
const list_rules_packages = @import("list_rules_packages.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const preview_agents = @import("preview_agents.zig");
const register_cross_account_access_role = @import("register_cross_account_access_role.zig");
const remove_attributes_from_findings = @import("remove_attributes_from_findings.zig");
const set_tags_for_resource = @import("set_tags_for_resource.zig");
const start_assessment_run = @import("start_assessment_run.zig");
const stop_assessment_run = @import("stop_assessment_run.zig");
const subscribe_to_event = @import("subscribe_to_event.zig");
const unsubscribe_from_event = @import("unsubscribe_from_event.zig");
const update_assessment_target = @import("update_assessment_target.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Inspector";

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

    /// Assigns attributes (key and value pairs) to the findings that are specified
    /// by the
    /// ARNs of the findings.
    pub fn addAttributesToFindings(self: *Self, allocator: std.mem.Allocator, input: add_attributes_to_findings.AddAttributesToFindingsInput, options: CallOptions) !add_attributes_to_findings.AddAttributesToFindingsOutput {
        return add_attributes_to_findings.execute(self, allocator, input, options);
    }

    /// Creates a new assessment target using the ARN of the resource group that is
    /// generated
    /// by CreateResourceGroup. If resourceGroupArn is not specified, all EC2
    /// instances in the current AWS account and region are included in the
    /// assessment target. If
    /// the [service-linked
    /// role](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_slr.html) isn’t already registered, this action also creates and
    /// registers a service-linked role to grant Amazon Inspector access to AWS
    /// Services needed to
    /// perform security assessments. You can create up to 50 assessment targets per
    /// AWS account.
    /// You can run up to 500 concurrent agents per AWS account. For more
    /// information, see [
    /// Amazon Inspector Assessment
    /// Targets](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_applications.html).
    pub fn createAssessmentTarget(self: *Self, allocator: std.mem.Allocator, input: create_assessment_target.CreateAssessmentTargetInput, options: CallOptions) !create_assessment_target.CreateAssessmentTargetOutput {
        return create_assessment_target.execute(self, allocator, input, options);
    }

    /// Creates an assessment template for the assessment target that is specified
    /// by the ARN
    /// of the assessment target. If the [service-linked
    /// role](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_slr.html) isn’t already registered, this action also creates and
    /// registers a service-linked role to grant Amazon Inspector access to AWS
    /// Services needed to
    /// perform security assessments.
    pub fn createAssessmentTemplate(self: *Self, allocator: std.mem.Allocator, input: create_assessment_template.CreateAssessmentTemplateInput, options: CallOptions) !create_assessment_template.CreateAssessmentTemplateOutput {
        return create_assessment_template.execute(self, allocator, input, options);
    }

    /// Starts the generation of an exclusions preview for the specified assessment
    /// template.
    /// The exclusions preview lists the potential exclusions (ExclusionPreview)
    /// that Inspector can
    /// detect before it runs the assessment.
    pub fn createExclusionsPreview(self: *Self, allocator: std.mem.Allocator, input: create_exclusions_preview.CreateExclusionsPreviewInput, options: CallOptions) !create_exclusions_preview.CreateExclusionsPreviewOutput {
        return create_exclusions_preview.execute(self, allocator, input, options);
    }

    /// Creates a resource group using the specified set of tags (key and value
    /// pairs) that
    /// are used to select the EC2 instances to be included in an Amazon Inspector
    /// assessment
    /// target. The created resource group is then used to create an Amazon
    /// Inspector assessment
    /// target. For more information, see CreateAssessmentTarget.
    pub fn createResourceGroup(self: *Self, allocator: std.mem.Allocator, input: create_resource_group.CreateResourceGroupInput, options: CallOptions) !create_resource_group.CreateResourceGroupOutput {
        return create_resource_group.execute(self, allocator, input, options);
    }

    /// Deletes the assessment run that is specified by the ARN of the assessment
    /// run.
    pub fn deleteAssessmentRun(self: *Self, allocator: std.mem.Allocator, input: delete_assessment_run.DeleteAssessmentRunInput, options: CallOptions) !delete_assessment_run.DeleteAssessmentRunOutput {
        return delete_assessment_run.execute(self, allocator, input, options);
    }

    /// Deletes the assessment target that is specified by the ARN of the assessment
    /// target.
    pub fn deleteAssessmentTarget(self: *Self, allocator: std.mem.Allocator, input: delete_assessment_target.DeleteAssessmentTargetInput, options: CallOptions) !delete_assessment_target.DeleteAssessmentTargetOutput {
        return delete_assessment_target.execute(self, allocator, input, options);
    }

    /// Deletes the assessment template that is specified by the ARN of the
    /// assessment
    /// template.
    pub fn deleteAssessmentTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_assessment_template.DeleteAssessmentTemplateInput, options: CallOptions) !delete_assessment_template.DeleteAssessmentTemplateOutput {
        return delete_assessment_template.execute(self, allocator, input, options);
    }

    /// Describes the assessment runs that are specified by the ARNs of the
    /// assessment
    /// runs.
    pub fn describeAssessmentRuns(self: *Self, allocator: std.mem.Allocator, input: describe_assessment_runs.DescribeAssessmentRunsInput, options: CallOptions) !describe_assessment_runs.DescribeAssessmentRunsOutput {
        return describe_assessment_runs.execute(self, allocator, input, options);
    }

    /// Describes the assessment targets that are specified by the ARNs of the
    /// assessment
    /// targets.
    pub fn describeAssessmentTargets(self: *Self, allocator: std.mem.Allocator, input: describe_assessment_targets.DescribeAssessmentTargetsInput, options: CallOptions) !describe_assessment_targets.DescribeAssessmentTargetsOutput {
        return describe_assessment_targets.execute(self, allocator, input, options);
    }

    /// Describes the assessment templates that are specified by the ARNs of the
    /// assessment
    /// templates.
    pub fn describeAssessmentTemplates(self: *Self, allocator: std.mem.Allocator, input: describe_assessment_templates.DescribeAssessmentTemplatesInput, options: CallOptions) !describe_assessment_templates.DescribeAssessmentTemplatesOutput {
        return describe_assessment_templates.execute(self, allocator, input, options);
    }

    /// Describes the IAM role that enables Amazon Inspector to access your AWS
    /// account.
    pub fn describeCrossAccountAccessRole(self: *Self, allocator: std.mem.Allocator, input: describe_cross_account_access_role.DescribeCrossAccountAccessRoleInput, options: CallOptions) !describe_cross_account_access_role.DescribeCrossAccountAccessRoleOutput {
        return describe_cross_account_access_role.execute(self, allocator, input, options);
    }

    /// Describes the exclusions that are specified by the exclusions' ARNs.
    pub fn describeExclusions(self: *Self, allocator: std.mem.Allocator, input: describe_exclusions.DescribeExclusionsInput, options: CallOptions) !describe_exclusions.DescribeExclusionsOutput {
        return describe_exclusions.execute(self, allocator, input, options);
    }

    /// Describes the findings that are specified by the ARNs of the findings.
    pub fn describeFindings(self: *Self, allocator: std.mem.Allocator, input: describe_findings.DescribeFindingsInput, options: CallOptions) !describe_findings.DescribeFindingsOutput {
        return describe_findings.execute(self, allocator, input, options);
    }

    /// Describes the resource groups that are specified by the ARNs of the resource
    /// groups.
    pub fn describeResourceGroups(self: *Self, allocator: std.mem.Allocator, input: describe_resource_groups.DescribeResourceGroupsInput, options: CallOptions) !describe_resource_groups.DescribeResourceGroupsOutput {
        return describe_resource_groups.execute(self, allocator, input, options);
    }

    /// Describes the rules packages that are specified by the ARNs of the rules
    /// packages.
    pub fn describeRulesPackages(self: *Self, allocator: std.mem.Allocator, input: describe_rules_packages.DescribeRulesPackagesInput, options: CallOptions) !describe_rules_packages.DescribeRulesPackagesOutput {
        return describe_rules_packages.execute(self, allocator, input, options);
    }

    /// Produces an assessment report that includes detailed and comprehensive
    /// results of a
    /// specified assessment run.
    pub fn getAssessmentReport(self: *Self, allocator: std.mem.Allocator, input: get_assessment_report.GetAssessmentReportInput, options: CallOptions) !get_assessment_report.GetAssessmentReportOutput {
        return get_assessment_report.execute(self, allocator, input, options);
    }

    /// Retrieves the exclusions preview (a list of ExclusionPreview objects)
    /// specified by
    /// the preview token. You can obtain the preview token by running the
    /// CreateExclusionsPreview
    /// API.
    pub fn getExclusionsPreview(self: *Self, allocator: std.mem.Allocator, input: get_exclusions_preview.GetExclusionsPreviewInput, options: CallOptions) !get_exclusions_preview.GetExclusionsPreviewOutput {
        return get_exclusions_preview.execute(self, allocator, input, options);
    }

    /// Information about the data that is collected for the specified assessment
    /// run.
    pub fn getTelemetryMetadata(self: *Self, allocator: std.mem.Allocator, input: get_telemetry_metadata.GetTelemetryMetadataInput, options: CallOptions) !get_telemetry_metadata.GetTelemetryMetadataOutput {
        return get_telemetry_metadata.execute(self, allocator, input, options);
    }

    /// Lists the agents of the assessment runs that are specified by the ARNs of
    /// the
    /// assessment runs.
    pub fn listAssessmentRunAgents(self: *Self, allocator: std.mem.Allocator, input: list_assessment_run_agents.ListAssessmentRunAgentsInput, options: CallOptions) !list_assessment_run_agents.ListAssessmentRunAgentsOutput {
        return list_assessment_run_agents.execute(self, allocator, input, options);
    }

    /// Lists the assessment runs that correspond to the assessment templates that
    /// are
    /// specified by the ARNs of the assessment templates.
    pub fn listAssessmentRuns(self: *Self, allocator: std.mem.Allocator, input: list_assessment_runs.ListAssessmentRunsInput, options: CallOptions) !list_assessment_runs.ListAssessmentRunsOutput {
        return list_assessment_runs.execute(self, allocator, input, options);
    }

    /// Lists the ARNs of the assessment targets within this AWS account. For more
    /// information about assessment targets, see [Amazon Inspector Assessment
    /// Targets](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_applications.html).
    pub fn listAssessmentTargets(self: *Self, allocator: std.mem.Allocator, input: list_assessment_targets.ListAssessmentTargetsInput, options: CallOptions) !list_assessment_targets.ListAssessmentTargetsOutput {
        return list_assessment_targets.execute(self, allocator, input, options);
    }

    /// Lists the assessment templates that correspond to the assessment targets
    /// that are
    /// specified by the ARNs of the assessment targets.
    pub fn listAssessmentTemplates(self: *Self, allocator: std.mem.Allocator, input: list_assessment_templates.ListAssessmentTemplatesInput, options: CallOptions) !list_assessment_templates.ListAssessmentTemplatesOutput {
        return list_assessment_templates.execute(self, allocator, input, options);
    }

    /// Lists all the event subscriptions for the assessment template that is
    /// specified by
    /// the ARN of the assessment template. For more information, see
    /// SubscribeToEvent and UnsubscribeFromEvent.
    pub fn listEventSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_event_subscriptions.ListEventSubscriptionsInput, options: CallOptions) !list_event_subscriptions.ListEventSubscriptionsOutput {
        return list_event_subscriptions.execute(self, allocator, input, options);
    }

    /// List exclusions that are generated by the assessment run.
    pub fn listExclusions(self: *Self, allocator: std.mem.Allocator, input: list_exclusions.ListExclusionsInput, options: CallOptions) !list_exclusions.ListExclusionsOutput {
        return list_exclusions.execute(self, allocator, input, options);
    }

    /// Lists findings that are generated by the assessment runs that are specified
    /// by the
    /// ARNs of the assessment runs.
    pub fn listFindings(self: *Self, allocator: std.mem.Allocator, input: list_findings.ListFindingsInput, options: CallOptions) !list_findings.ListFindingsOutput {
        return list_findings.execute(self, allocator, input, options);
    }

    /// Lists all available Amazon Inspector rules packages.
    pub fn listRulesPackages(self: *Self, allocator: std.mem.Allocator, input: list_rules_packages.ListRulesPackagesInput, options: CallOptions) !list_rules_packages.ListRulesPackagesOutput {
        return list_rules_packages.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with an assessment template.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Previews the agents installed on the EC2 instances that are part of the
    /// specified
    /// assessment target.
    pub fn previewAgents(self: *Self, allocator: std.mem.Allocator, input: preview_agents.PreviewAgentsInput, options: CallOptions) !preview_agents.PreviewAgentsOutput {
        return preview_agents.execute(self, allocator, input, options);
    }

    /// Registers the IAM role that grants Amazon Inspector access to AWS Services
    /// needed to
    /// perform security assessments.
    pub fn registerCrossAccountAccessRole(self: *Self, allocator: std.mem.Allocator, input: register_cross_account_access_role.RegisterCrossAccountAccessRoleInput, options: CallOptions) !register_cross_account_access_role.RegisterCrossAccountAccessRoleOutput {
        return register_cross_account_access_role.execute(self, allocator, input, options);
    }

    /// Removes entire attributes (key and value pairs) from the findings that are
    /// specified
    /// by the ARNs of the findings where an attribute with the specified key
    /// exists.
    pub fn removeAttributesFromFindings(self: *Self, allocator: std.mem.Allocator, input: remove_attributes_from_findings.RemoveAttributesFromFindingsInput, options: CallOptions) !remove_attributes_from_findings.RemoveAttributesFromFindingsOutput {
        return remove_attributes_from_findings.execute(self, allocator, input, options);
    }

    /// Sets tags (key and value pairs) to the assessment template that is specified
    /// by the
    /// ARN of the assessment template.
    pub fn setTagsForResource(self: *Self, allocator: std.mem.Allocator, input: set_tags_for_resource.SetTagsForResourceInput, options: CallOptions) !set_tags_for_resource.SetTagsForResourceOutput {
        return set_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts the assessment run specified by the ARN of the assessment template.
    /// For this
    /// API to function properly, you must not exceed the limit of running up to 500
    /// concurrent
    /// agents per AWS account.
    pub fn startAssessmentRun(self: *Self, allocator: std.mem.Allocator, input: start_assessment_run.StartAssessmentRunInput, options: CallOptions) !start_assessment_run.StartAssessmentRunOutput {
        return start_assessment_run.execute(self, allocator, input, options);
    }

    /// Stops the assessment run that is specified by the ARN of the assessment
    /// run.
    pub fn stopAssessmentRun(self: *Self, allocator: std.mem.Allocator, input: stop_assessment_run.StopAssessmentRunInput, options: CallOptions) !stop_assessment_run.StopAssessmentRunOutput {
        return stop_assessment_run.execute(self, allocator, input, options);
    }

    /// Enables the process of sending Amazon Simple Notification Service (SNS)
    /// notifications
    /// about a specified event to a specified SNS topic.
    pub fn subscribeToEvent(self: *Self, allocator: std.mem.Allocator, input: subscribe_to_event.SubscribeToEventInput, options: CallOptions) !subscribe_to_event.SubscribeToEventOutput {
        return subscribe_to_event.execute(self, allocator, input, options);
    }

    /// Disables the process of sending Amazon Simple Notification Service (SNS)
    /// notifications about a specified event to a specified SNS topic.
    pub fn unsubscribeFromEvent(self: *Self, allocator: std.mem.Allocator, input: unsubscribe_from_event.UnsubscribeFromEventInput, options: CallOptions) !unsubscribe_from_event.UnsubscribeFromEventOutput {
        return unsubscribe_from_event.execute(self, allocator, input, options);
    }

    /// Updates the assessment target that is specified by the ARN of the assessment
    /// target.
    ///
    /// If resourceGroupArn is not specified, all EC2 instances in the current AWS
    /// account
    /// and region are included in the assessment target.
    pub fn updateAssessmentTarget(self: *Self, allocator: std.mem.Allocator, input: update_assessment_target.UpdateAssessmentTargetInput, options: CallOptions) !update_assessment_target.UpdateAssessmentTargetOutput {
        return update_assessment_target.execute(self, allocator, input, options);
    }

    pub fn getExclusionsPreviewPaginator(self: *Self, params: get_exclusions_preview.GetExclusionsPreviewInput) paginator.GetExclusionsPreviewPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssessmentRunAgentsPaginator(self: *Self, params: list_assessment_run_agents.ListAssessmentRunAgentsInput) paginator.ListAssessmentRunAgentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssessmentRunsPaginator(self: *Self, params: list_assessment_runs.ListAssessmentRunsInput) paginator.ListAssessmentRunsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssessmentTargetsPaginator(self: *Self, params: list_assessment_targets.ListAssessmentTargetsInput) paginator.ListAssessmentTargetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssessmentTemplatesPaginator(self: *Self, params: list_assessment_templates.ListAssessmentTemplatesInput) paginator.ListAssessmentTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEventSubscriptionsPaginator(self: *Self, params: list_event_subscriptions.ListEventSubscriptionsInput) paginator.ListEventSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listExclusionsPaginator(self: *Self, params: list_exclusions.ListExclusionsInput) paginator.ListExclusionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFindingsPaginator(self: *Self, params: list_findings.ListFindingsInput) paginator.ListFindingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRulesPackagesPaginator(self: *Self, params: list_rules_packages.ListRulesPackagesInput) paginator.ListRulesPackagesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn previewAgentsPaginator(self: *Self, params: preview_agents.PreviewAgentsInput) paginator.PreviewAgentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

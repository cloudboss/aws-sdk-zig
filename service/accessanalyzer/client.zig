const aws = @import("aws");
const std = @import("std");

const apply_archive_rule = @import("apply_archive_rule.zig");
const cancel_policy_generation = @import("cancel_policy_generation.zig");
const check_access_not_granted = @import("check_access_not_granted.zig");
const check_no_new_access = @import("check_no_new_access.zig");
const check_no_public_access = @import("check_no_public_access.zig");
const create_access_preview = @import("create_access_preview.zig");
const create_analyzer = @import("create_analyzer.zig");
const create_archive_rule = @import("create_archive_rule.zig");
const delete_analyzer = @import("delete_analyzer.zig");
const delete_archive_rule = @import("delete_archive_rule.zig");
const generate_finding_recommendation = @import("generate_finding_recommendation.zig");
const get_access_preview = @import("get_access_preview.zig");
const get_analyzed_resource = @import("get_analyzed_resource.zig");
const get_analyzer = @import("get_analyzer.zig");
const get_archive_rule = @import("get_archive_rule.zig");
const get_finding = @import("get_finding.zig");
const get_finding_recommendation = @import("get_finding_recommendation.zig");
const get_finding_v2 = @import("get_finding_v2.zig");
const get_findings_statistics = @import("get_findings_statistics.zig");
const get_generated_policy = @import("get_generated_policy.zig");
const list_access_preview_findings = @import("list_access_preview_findings.zig");
const list_access_previews = @import("list_access_previews.zig");
const list_analyzed_resources = @import("list_analyzed_resources.zig");
const list_analyzers = @import("list_analyzers.zig");
const list_archive_rules = @import("list_archive_rules.zig");
const list_findings = @import("list_findings.zig");
const list_findings_v2 = @import("list_findings_v2.zig");
const list_policy_generations = @import("list_policy_generations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_policy_generation = @import("start_policy_generation.zig");
const start_resource_scan = @import("start_resource_scan.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_analyzer = @import("update_analyzer.zig");
const update_archive_rule = @import("update_archive_rule.zig");
const update_findings = @import("update_findings.zig");
const validate_policy = @import("validate_policy.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AccessAnalyzer";

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

    /// Retroactively applies the archive rule to existing findings that meet the
    /// archive rule criteria.
    pub fn applyArchiveRule(self: *Self, allocator: std.mem.Allocator, input: apply_archive_rule.ApplyArchiveRuleInput, options: CallOptions) !apply_archive_rule.ApplyArchiveRuleOutput {
        return apply_archive_rule.execute(self, allocator, input, options);
    }

    /// Cancels the requested policy generation.
    pub fn cancelPolicyGeneration(self: *Self, allocator: std.mem.Allocator, input: cancel_policy_generation.CancelPolicyGenerationInput, options: CallOptions) !cancel_policy_generation.CancelPolicyGenerationOutput {
        return cancel_policy_generation.execute(self, allocator, input, options);
    }

    /// Checks whether the specified access isn't allowed by a policy.
    pub fn checkAccessNotGranted(self: *Self, allocator: std.mem.Allocator, input: check_access_not_granted.CheckAccessNotGrantedInput, options: CallOptions) !check_access_not_granted.CheckAccessNotGrantedOutput {
        return check_access_not_granted.execute(self, allocator, input, options);
    }

    /// Checks whether new access is allowed for an updated policy when compared to
    /// the existing policy.
    ///
    /// You can find examples for reference policies and learn how to set up and run
    /// a custom policy check for new access in the [IAM Access Analyzer custom
    /// policy checks
    /// samples](https://github.com/aws-samples/iam-access-analyzer-custom-policy-check-samples) repository on GitHub. The reference policies in this repository are meant to be passed to the `existingPolicyDocument` request parameter.
    pub fn checkNoNewAccess(self: *Self, allocator: std.mem.Allocator, input: check_no_new_access.CheckNoNewAccessInput, options: CallOptions) !check_no_new_access.CheckNoNewAccessOutput {
        return check_no_new_access.execute(self, allocator, input, options);
    }

    /// Checks whether a resource policy can grant public access to the specified
    /// resource type.
    pub fn checkNoPublicAccess(self: *Self, allocator: std.mem.Allocator, input: check_no_public_access.CheckNoPublicAccessInput, options: CallOptions) !check_no_public_access.CheckNoPublicAccessOutput {
        return check_no_public_access.execute(self, allocator, input, options);
    }

    /// Creates an access preview that allows you to preview IAM Access Analyzer
    /// findings for your resource before deploying resource permissions.
    pub fn createAccessPreview(self: *Self, allocator: std.mem.Allocator, input: create_access_preview.CreateAccessPreviewInput, options: CallOptions) !create_access_preview.CreateAccessPreviewOutput {
        return create_access_preview.execute(self, allocator, input, options);
    }

    /// Creates an analyzer for your account.
    pub fn createAnalyzer(self: *Self, allocator: std.mem.Allocator, input: create_analyzer.CreateAnalyzerInput, options: CallOptions) !create_analyzer.CreateAnalyzerOutput {
        return create_analyzer.execute(self, allocator, input, options);
    }

    /// Creates an archive rule for the specified analyzer. Archive rules
    /// automatically archive new findings that meet the criteria you define when
    /// you create the rule.
    ///
    /// To learn about filter keys that you can use to create an archive rule, see
    /// [IAM Access Analyzer filter
    /// keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-reference-filter-keys.html) in the **IAM User Guide**.
    pub fn createArchiveRule(self: *Self, allocator: std.mem.Allocator, input: create_archive_rule.CreateArchiveRuleInput, options: CallOptions) !create_archive_rule.CreateArchiveRuleOutput {
        return create_archive_rule.execute(self, allocator, input, options);
    }

    /// Deletes the specified analyzer. When you delete an analyzer, IAM Access
    /// Analyzer is disabled for the account or organization in the current or
    /// specific Region. All findings that were generated by the analyzer are
    /// deleted. You cannot undo this action.
    pub fn deleteAnalyzer(self: *Self, allocator: std.mem.Allocator, input: delete_analyzer.DeleteAnalyzerInput, options: CallOptions) !delete_analyzer.DeleteAnalyzerOutput {
        return delete_analyzer.execute(self, allocator, input, options);
    }

    /// Deletes the specified archive rule.
    pub fn deleteArchiveRule(self: *Self, allocator: std.mem.Allocator, input: delete_archive_rule.DeleteArchiveRuleInput, options: CallOptions) !delete_archive_rule.DeleteArchiveRuleOutput {
        return delete_archive_rule.execute(self, allocator, input, options);
    }

    /// Creates a recommendation for an unused permissions finding.
    pub fn generateFindingRecommendation(self: *Self, allocator: std.mem.Allocator, input: generate_finding_recommendation.GenerateFindingRecommendationInput, options: CallOptions) !generate_finding_recommendation.GenerateFindingRecommendationOutput {
        return generate_finding_recommendation.execute(self, allocator, input, options);
    }

    /// Retrieves information about an access preview for the specified analyzer.
    pub fn getAccessPreview(self: *Self, allocator: std.mem.Allocator, input: get_access_preview.GetAccessPreviewInput, options: CallOptions) !get_access_preview.GetAccessPreviewOutput {
        return get_access_preview.execute(self, allocator, input, options);
    }

    /// Retrieves information about a resource that was analyzed.
    ///
    /// This action is supported only for external access analyzers.
    pub fn getAnalyzedResource(self: *Self, allocator: std.mem.Allocator, input: get_analyzed_resource.GetAnalyzedResourceInput, options: CallOptions) !get_analyzed_resource.GetAnalyzedResourceOutput {
        return get_analyzed_resource.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified analyzer.
    pub fn getAnalyzer(self: *Self, allocator: std.mem.Allocator, input: get_analyzer.GetAnalyzerInput, options: CallOptions) !get_analyzer.GetAnalyzerOutput {
        return get_analyzer.execute(self, allocator, input, options);
    }

    /// Retrieves information about an archive rule.
    ///
    /// To learn about filter keys that you can use to create an archive rule, see
    /// [IAM Access Analyzer filter
    /// keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-reference-filter-keys.html) in the **IAM User Guide**.
    pub fn getArchiveRule(self: *Self, allocator: std.mem.Allocator, input: get_archive_rule.GetArchiveRuleInput, options: CallOptions) !get_archive_rule.GetArchiveRuleOutput {
        return get_archive_rule.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified finding. GetFinding and
    /// GetFindingV2 both use `access-analyzer:GetFinding` in the `Action` element
    /// of an IAM policy statement. You must have permission to perform the
    /// `access-analyzer:GetFinding` action.
    ///
    /// GetFinding is supported only for external access analyzers. You must use
    /// GetFindingV2 for internal and unused access analyzers.
    pub fn getFinding(self: *Self, allocator: std.mem.Allocator, input: get_finding.GetFindingInput, options: CallOptions) !get_finding.GetFindingOutput {
        return get_finding.execute(self, allocator, input, options);
    }

    /// Retrieves information about a finding recommendation for the specified
    /// analyzer.
    pub fn getFindingRecommendation(self: *Self, allocator: std.mem.Allocator, input: get_finding_recommendation.GetFindingRecommendationInput, options: CallOptions) !get_finding_recommendation.GetFindingRecommendationOutput {
        return get_finding_recommendation.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified finding. GetFinding and
    /// GetFindingV2 both use `access-analyzer:GetFinding` in the `Action` element
    /// of an IAM policy statement. You must have permission to perform the
    /// `access-analyzer:GetFinding` action.
    pub fn getFindingV2(self: *Self, allocator: std.mem.Allocator, input: get_finding_v2.GetFindingV2Input, options: CallOptions) !get_finding_v2.GetFindingV2Output {
        return get_finding_v2.execute(self, allocator, input, options);
    }

    /// Retrieves a list of aggregated finding statistics for an external access or
    /// unused access analyzer.
    pub fn getFindingsStatistics(self: *Self, allocator: std.mem.Allocator, input: get_findings_statistics.GetFindingsStatisticsInput, options: CallOptions) !get_findings_statistics.GetFindingsStatisticsOutput {
        return get_findings_statistics.execute(self, allocator, input, options);
    }

    /// Retrieves the policy that was generated using `StartPolicyGeneration`.
    pub fn getGeneratedPolicy(self: *Self, allocator: std.mem.Allocator, input: get_generated_policy.GetGeneratedPolicyInput, options: CallOptions) !get_generated_policy.GetGeneratedPolicyOutput {
        return get_generated_policy.execute(self, allocator, input, options);
    }

    /// Retrieves a list of access preview findings generated by the specified
    /// access preview.
    pub fn listAccessPreviewFindings(self: *Self, allocator: std.mem.Allocator, input: list_access_preview_findings.ListAccessPreviewFindingsInput, options: CallOptions) !list_access_preview_findings.ListAccessPreviewFindingsOutput {
        return list_access_preview_findings.execute(self, allocator, input, options);
    }

    /// Retrieves a list of access previews for the specified analyzer.
    pub fn listAccessPreviews(self: *Self, allocator: std.mem.Allocator, input: list_access_previews.ListAccessPreviewsInput, options: CallOptions) !list_access_previews.ListAccessPreviewsOutput {
        return list_access_previews.execute(self, allocator, input, options);
    }

    /// Retrieves a list of resources of the specified type that have been analyzed
    /// by the specified analyzer.
    pub fn listAnalyzedResources(self: *Self, allocator: std.mem.Allocator, input: list_analyzed_resources.ListAnalyzedResourcesInput, options: CallOptions) !list_analyzed_resources.ListAnalyzedResourcesOutput {
        return list_analyzed_resources.execute(self, allocator, input, options);
    }

    /// Retrieves a list of analyzers.
    pub fn listAnalyzers(self: *Self, allocator: std.mem.Allocator, input: list_analyzers.ListAnalyzersInput, options: CallOptions) !list_analyzers.ListAnalyzersOutput {
        return list_analyzers.execute(self, allocator, input, options);
    }

    /// Retrieves a list of archive rules created for the specified analyzer.
    pub fn listArchiveRules(self: *Self, allocator: std.mem.Allocator, input: list_archive_rules.ListArchiveRulesInput, options: CallOptions) !list_archive_rules.ListArchiveRulesOutput {
        return list_archive_rules.execute(self, allocator, input, options);
    }

    /// Retrieves a list of findings generated by the specified analyzer.
    /// ListFindings and ListFindingsV2 both use `access-analyzer:ListFindings` in
    /// the `Action` element of an IAM policy statement. You must have permission to
    /// perform the `access-analyzer:ListFindings` action.
    ///
    /// To learn about filter keys that you can use to retrieve a list of findings,
    /// see [IAM Access Analyzer filter
    /// keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-reference-filter-keys.html) in the **IAM User Guide**.
    ///
    /// ListFindings is supported only for external access analyzers. You must use
    /// ListFindingsV2 for internal and unused access analyzers.
    pub fn listFindings(self: *Self, allocator: std.mem.Allocator, input: list_findings.ListFindingsInput, options: CallOptions) !list_findings.ListFindingsOutput {
        return list_findings.execute(self, allocator, input, options);
    }

    /// Retrieves a list of findings generated by the specified analyzer.
    /// ListFindings and ListFindingsV2 both use `access-analyzer:ListFindings` in
    /// the `Action` element of an IAM policy statement. You must have permission to
    /// perform the `access-analyzer:ListFindings` action.
    ///
    /// To learn about filter keys that you can use to retrieve a list of findings,
    /// see [IAM Access Analyzer filter
    /// keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-reference-filter-keys.html) in the **IAM User Guide**.
    pub fn listFindingsV2(self: *Self, allocator: std.mem.Allocator, input: list_findings_v2.ListFindingsV2Input, options: CallOptions) !list_findings_v2.ListFindingsV2Output {
        return list_findings_v2.execute(self, allocator, input, options);
    }

    /// Lists all of the policy generations requested in the last seven days.
    pub fn listPolicyGenerations(self: *Self, allocator: std.mem.Allocator, input: list_policy_generations.ListPolicyGenerationsInput, options: CallOptions) !list_policy_generations.ListPolicyGenerationsOutput {
        return list_policy_generations.execute(self, allocator, input, options);
    }

    /// Retrieves a list of tags applied to the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts the policy generation request.
    pub fn startPolicyGeneration(self: *Self, allocator: std.mem.Allocator, input: start_policy_generation.StartPolicyGenerationInput, options: CallOptions) !start_policy_generation.StartPolicyGenerationOutput {
        return start_policy_generation.execute(self, allocator, input, options);
    }

    /// Immediately starts a scan of the policies applied to the specified resource.
    ///
    /// This action is supported only for external access analyzers.
    pub fn startResourceScan(self: *Self, allocator: std.mem.Allocator, input: start_resource_scan.StartResourceScanInput, options: CallOptions) !start_resource_scan.StartResourceScanOutput {
        return start_resource_scan.execute(self, allocator, input, options);
    }

    /// Adds a tag to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies the configuration of an existing analyzer.
    ///
    /// This action is not supported for external access analyzers.
    pub fn updateAnalyzer(self: *Self, allocator: std.mem.Allocator, input: update_analyzer.UpdateAnalyzerInput, options: CallOptions) !update_analyzer.UpdateAnalyzerOutput {
        return update_analyzer.execute(self, allocator, input, options);
    }

    /// Updates the criteria and values for the specified archive rule.
    pub fn updateArchiveRule(self: *Self, allocator: std.mem.Allocator, input: update_archive_rule.UpdateArchiveRuleInput, options: CallOptions) !update_archive_rule.UpdateArchiveRuleOutput {
        return update_archive_rule.execute(self, allocator, input, options);
    }

    /// Updates the status for the specified findings.
    pub fn updateFindings(self: *Self, allocator: std.mem.Allocator, input: update_findings.UpdateFindingsInput, options: CallOptions) !update_findings.UpdateFindingsOutput {
        return update_findings.execute(self, allocator, input, options);
    }

    /// Requests the validation of a policy and returns a list of findings. The
    /// findings help you identify issues and provide actionable recommendations to
    /// resolve the issue and enable you to author functional policies that meet
    /// security best practices.
    pub fn validatePolicy(self: *Self, allocator: std.mem.Allocator, input: validate_policy.ValidatePolicyInput, options: CallOptions) !validate_policy.ValidatePolicyOutput {
        return validate_policy.execute(self, allocator, input, options);
    }

    pub fn getFindingRecommendationPaginator(self: *Self, params: get_finding_recommendation.GetFindingRecommendationInput) paginator.GetFindingRecommendationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getFindingV2Paginator(self: *Self, params: get_finding_v2.GetFindingV2Input) paginator.GetFindingV2Paginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAccessPreviewFindingsPaginator(self: *Self, params: list_access_preview_findings.ListAccessPreviewFindingsInput) paginator.ListAccessPreviewFindingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAccessPreviewsPaginator(self: *Self, params: list_access_previews.ListAccessPreviewsInput) paginator.ListAccessPreviewsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAnalyzedResourcesPaginator(self: *Self, params: list_analyzed_resources.ListAnalyzedResourcesInput) paginator.ListAnalyzedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAnalyzersPaginator(self: *Self, params: list_analyzers.ListAnalyzersInput) paginator.ListAnalyzersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listArchiveRulesPaginator(self: *Self, params: list_archive_rules.ListArchiveRulesInput) paginator.ListArchiveRulesPaginator {
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

    pub fn listFindingsV2Paginator(self: *Self, params: list_findings_v2.ListFindingsV2Input) paginator.ListFindingsV2Paginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPolicyGenerationsPaginator(self: *Self, params: list_policy_generations.ListPolicyGenerationsInput) paginator.ListPolicyGenerationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn validatePolicyPaginator(self: *Self, params: validate_policy.ValidatePolicyInput) paginator.ValidatePolicyPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

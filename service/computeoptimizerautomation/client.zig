const aws = @import("aws");
const std = @import("std");

const associate_accounts = @import("associate_accounts.zig");
const create_automation_rule = @import("create_automation_rule.zig");
const delete_automation_rule = @import("delete_automation_rule.zig");
const disassociate_accounts = @import("disassociate_accounts.zig");
const get_automation_event = @import("get_automation_event.zig");
const get_automation_rule = @import("get_automation_rule.zig");
const get_enrollment_configuration = @import("get_enrollment_configuration.zig");
const list_accounts = @import("list_accounts.zig");
const list_automation_event_steps = @import("list_automation_event_steps.zig");
const list_automation_event_summaries = @import("list_automation_event_summaries.zig");
const list_automation_events = @import("list_automation_events.zig");
const list_automation_rule_preview = @import("list_automation_rule_preview.zig");
const list_automation_rule_preview_summaries = @import("list_automation_rule_preview_summaries.zig");
const list_automation_rules = @import("list_automation_rules.zig");
const list_recommended_action_summaries = @import("list_recommended_action_summaries.zig");
const list_recommended_actions = @import("list_recommended_actions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const rollback_automation_event = @import("rollback_automation_event.zig");
const start_automation_event = @import("start_automation_event.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_automation_rule = @import("update_automation_rule.zig");
const update_enrollment_configuration = @import("update_enrollment_configuration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Compute Optimizer Automation";

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

    /// Associates one or more member accounts with your organization's management
    /// account, enabling centralized implementation of optimization actions across
    /// those accounts. Once associated, the management account (or a delegated
    /// administrator) can apply recommended actions to the member account. When you
    /// associate a member account, its organization rule mode is automatically set
    /// to "Any allowed," which permits the management account to create Automation
    /// rules that automatically apply actions to that account. If the member
    /// account has not previously enabled the Automation feature, the association
    /// process automatically enables it.
    ///
    /// Only the management account or a delegated administrator can perform this
    /// action.
    pub fn associateAccounts(self: *Self, allocator: std.mem.Allocator, input: associate_accounts.AssociateAccountsInput, options: associate_accounts.Options) !associate_accounts.AssociateAccountsOutput {
        return associate_accounts.execute(self, allocator, input, options);
    }

    /// Creates a new automation rule to apply recommended actions to resources
    /// based on specified criteria.
    pub fn createAutomationRule(self: *Self, allocator: std.mem.Allocator, input: create_automation_rule.CreateAutomationRuleInput, options: create_automation_rule.Options) !create_automation_rule.CreateAutomationRuleOutput {
        return create_automation_rule.execute(self, allocator, input, options);
    }

    /// Deletes an existing automation rule.
    pub fn deleteAutomationRule(self: *Self, allocator: std.mem.Allocator, input: delete_automation_rule.DeleteAutomationRuleInput, options: delete_automation_rule.Options) !delete_automation_rule.DeleteAutomationRuleOutput {
        return delete_automation_rule.execute(self, allocator, input, options);
    }

    /// Disassociates member accounts from your organization's management account,
    /// removing centralized automation capabilities. Once disassociated,
    /// organization rules no longer apply to the member account, and the management
    /// account (or delegated administrator) cannot create Automation rules for that
    /// account.
    ///
    /// Only the management account or a delegated administrator can perform this
    /// action.
    pub fn disassociateAccounts(self: *Self, allocator: std.mem.Allocator, input: disassociate_accounts.DisassociateAccountsInput, options: disassociate_accounts.Options) !disassociate_accounts.DisassociateAccountsOutput {
        return disassociate_accounts.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific automation event.
    pub fn getAutomationEvent(self: *Self, allocator: std.mem.Allocator, input: get_automation_event.GetAutomationEventInput, options: get_automation_event.Options) !get_automation_event.GetAutomationEventOutput {
        return get_automation_event.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific automation rule.
    pub fn getAutomationRule(self: *Self, allocator: std.mem.Allocator, input: get_automation_rule.GetAutomationRuleInput, options: get_automation_rule.Options) !get_automation_rule.GetAutomationRuleOutput {
        return get_automation_rule.execute(self, allocator, input, options);
    }

    /// Retrieves the current enrollment configuration for Compute Optimizer
    /// Automation.
    pub fn getEnrollmentConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_enrollment_configuration.GetEnrollmentConfigurationInput, options: get_enrollment_configuration.Options) !get_enrollment_configuration.GetEnrollmentConfigurationOutput {
        return get_enrollment_configuration.execute(self, allocator, input, options);
    }

    /// Lists the accounts in your organization that are enrolled in Compute
    /// Optimizer and whether they have enabled Automation.
    ///
    /// Only the management account or a delegated administrator can perform this
    /// action.
    pub fn listAccounts(self: *Self, allocator: std.mem.Allocator, input: list_accounts.ListAccountsInput, options: list_accounts.Options) !list_accounts.ListAccountsOutput {
        return list_accounts.execute(self, allocator, input, options);
    }

    /// Lists the steps for a specific automation event. You can only list steps for
    /// events created within the past year.
    pub fn listAutomationEventSteps(self: *Self, allocator: std.mem.Allocator, input: list_automation_event_steps.ListAutomationEventStepsInput, options: list_automation_event_steps.Options) !list_automation_event_steps.ListAutomationEventStepsOutput {
        return list_automation_event_steps.execute(self, allocator, input, options);
    }

    /// Provides a summary of automation events based on specified filters. Only
    /// events created within the past year will be included in the summary.
    pub fn listAutomationEventSummaries(self: *Self, allocator: std.mem.Allocator, input: list_automation_event_summaries.ListAutomationEventSummariesInput, options: list_automation_event_summaries.Options) !list_automation_event_summaries.ListAutomationEventSummariesOutput {
        return list_automation_event_summaries.execute(self, allocator, input, options);
    }

    /// Lists automation events based on specified filters. You can retrieve events
    /// that were created within the past year.
    pub fn listAutomationEvents(self: *Self, allocator: std.mem.Allocator, input: list_automation_events.ListAutomationEventsInput, options: list_automation_events.Options) !list_automation_events.ListAutomationEventsOutput {
        return list_automation_events.execute(self, allocator, input, options);
    }

    /// Returns a preview of the recommended actions that match your Automation
    /// rule's configuration and criteria.
    pub fn listAutomationRulePreview(self: *Self, allocator: std.mem.Allocator, input: list_automation_rule_preview.ListAutomationRulePreviewInput, options: list_automation_rule_preview.Options) !list_automation_rule_preview.ListAutomationRulePreviewOutput {
        return list_automation_rule_preview.execute(self, allocator, input, options);
    }

    /// Returns a summary of the recommended actions that match your rule preview
    /// configuration and criteria.
    pub fn listAutomationRulePreviewSummaries(self: *Self, allocator: std.mem.Allocator, input: list_automation_rule_preview_summaries.ListAutomationRulePreviewSummariesInput, options: list_automation_rule_preview_summaries.Options) !list_automation_rule_preview_summaries.ListAutomationRulePreviewSummariesOutput {
        return list_automation_rule_preview_summaries.execute(self, allocator, input, options);
    }

    /// Lists the automation rules that match specified filters.
    pub fn listAutomationRules(self: *Self, allocator: std.mem.Allocator, input: list_automation_rules.ListAutomationRulesInput, options: list_automation_rules.Options) !list_automation_rules.ListAutomationRulesOutput {
        return list_automation_rules.execute(self, allocator, input, options);
    }

    /// Provides a summary of recommended actions based on specified filters.
    ///
    /// Management accounts and delegated administrators can retrieve recommended
    /// actions that include associated member accounts. You can associate a member
    /// account using `AssociateAccounts`.
    pub fn listRecommendedActionSummaries(self: *Self, allocator: std.mem.Allocator, input: list_recommended_action_summaries.ListRecommendedActionSummariesInput, options: list_recommended_action_summaries.Options) !list_recommended_action_summaries.ListRecommendedActionSummariesOutput {
        return list_recommended_action_summaries.execute(self, allocator, input, options);
    }

    /// Lists the recommended actions based that match specified filters.
    ///
    /// Management accounts and delegated administrators can retrieve recommended
    /// actions that include associated member accounts. You can associate a member
    /// account using `AssociateAccounts`.
    pub fn listRecommendedActions(self: *Self, allocator: std.mem.Allocator, input: list_recommended_actions.ListRecommendedActionsInput, options: list_recommended_actions.Options) !list_recommended_actions.ListRecommendedActionsOutput {
        return list_recommended_actions.execute(self, allocator, input, options);
    }

    /// Lists the tags for a specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Initiates a rollback for a completed automation event.
    ///
    /// Management accounts and delegated administrators can only initiate a
    /// rollback for events belonging to associated member accounts. You can
    /// associate a member account using `AssociateAccounts`.
    pub fn rollbackAutomationEvent(self: *Self, allocator: std.mem.Allocator, input: rollback_automation_event.RollbackAutomationEventInput, options: rollback_automation_event.Options) !rollback_automation_event.RollbackAutomationEventOutput {
        return rollback_automation_event.execute(self, allocator, input, options);
    }

    /// Initiates a one-time, on-demand automation for the specified recommended
    /// action.
    ///
    /// Management accounts and delegated administrators can only initiate
    /// recommended actions for associated member accounts. You can associate a
    /// member account using `AssociateAccounts`.
    pub fn startAutomationEvent(self: *Self, allocator: std.mem.Allocator, input: start_automation_event.StartAutomationEventInput, options: start_automation_event.Options) !start_automation_event.StartAutomationEventOutput {
        return start_automation_event.execute(self, allocator, input, options);
    }

    /// Adds tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing automation rule.
    pub fn updateAutomationRule(self: *Self, allocator: std.mem.Allocator, input: update_automation_rule.UpdateAutomationRuleInput, options: update_automation_rule.Options) !update_automation_rule.UpdateAutomationRuleOutput {
        return update_automation_rule.execute(self, allocator, input, options);
    }

    /// Updates your account’s Compute Optimizer Automation enrollment
    /// configuration.
    pub fn updateEnrollmentConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_enrollment_configuration.UpdateEnrollmentConfigurationInput, options: update_enrollment_configuration.Options) !update_enrollment_configuration.UpdateEnrollmentConfigurationOutput {
        return update_enrollment_configuration.execute(self, allocator, input, options);
    }

    pub fn listAccountsPaginator(self: *Self, params: list_accounts.ListAccountsInput) paginator.ListAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAutomationEventStepsPaginator(self: *Self, params: list_automation_event_steps.ListAutomationEventStepsInput) paginator.ListAutomationEventStepsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAutomationEventSummariesPaginator(self: *Self, params: list_automation_event_summaries.ListAutomationEventSummariesInput) paginator.ListAutomationEventSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAutomationEventsPaginator(self: *Self, params: list_automation_events.ListAutomationEventsInput) paginator.ListAutomationEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAutomationRulePreviewPaginator(self: *Self, params: list_automation_rule_preview.ListAutomationRulePreviewInput) paginator.ListAutomationRulePreviewPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAutomationRulePreviewSummariesPaginator(self: *Self, params: list_automation_rule_preview_summaries.ListAutomationRulePreviewSummariesInput) paginator.ListAutomationRulePreviewSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAutomationRulesPaginator(self: *Self, params: list_automation_rules.ListAutomationRulesInput) paginator.ListAutomationRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecommendedActionSummariesPaginator(self: *Self, params: list_recommended_action_summaries.ListRecommendedActionSummariesInput) paginator.ListRecommendedActionSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecommendedActionsPaginator(self: *Self, params: list_recommended_actions.ListRecommendedActionsInput) paginator.ListRecommendedActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

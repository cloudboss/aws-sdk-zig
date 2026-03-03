const aws = @import("aws");
const std = @import("std");

const associate_accounts = @import("associate_accounts.zig");
const associate_pricing_rules = @import("associate_pricing_rules.zig");
const batch_associate_resources_to_custom_line_item = @import("batch_associate_resources_to_custom_line_item.zig");
const batch_disassociate_resources_from_custom_line_item = @import("batch_disassociate_resources_from_custom_line_item.zig");
const create_billing_group = @import("create_billing_group.zig");
const create_custom_line_item = @import("create_custom_line_item.zig");
const create_pricing_plan = @import("create_pricing_plan.zig");
const create_pricing_rule = @import("create_pricing_rule.zig");
const delete_billing_group = @import("delete_billing_group.zig");
const delete_custom_line_item = @import("delete_custom_line_item.zig");
const delete_pricing_plan = @import("delete_pricing_plan.zig");
const delete_pricing_rule = @import("delete_pricing_rule.zig");
const disassociate_accounts = @import("disassociate_accounts.zig");
const disassociate_pricing_rules = @import("disassociate_pricing_rules.zig");
const get_billing_group_cost_report = @import("get_billing_group_cost_report.zig");
const list_account_associations = @import("list_account_associations.zig");
const list_billing_group_cost_reports = @import("list_billing_group_cost_reports.zig");
const list_billing_groups = @import("list_billing_groups.zig");
const list_custom_line_item_versions = @import("list_custom_line_item_versions.zig");
const list_custom_line_items = @import("list_custom_line_items.zig");
const list_pricing_plans = @import("list_pricing_plans.zig");
const list_pricing_plans_associated_with_pricing_rule = @import("list_pricing_plans_associated_with_pricing_rule.zig");
const list_pricing_rules = @import("list_pricing_rules.zig");
const list_pricing_rules_associated_to_pricing_plan = @import("list_pricing_rules_associated_to_pricing_plan.zig");
const list_resources_associated_to_custom_line_item = @import("list_resources_associated_to_custom_line_item.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_billing_group = @import("update_billing_group.zig");
const update_custom_line_item = @import("update_custom_line_item.zig");
const update_pricing_plan = @import("update_pricing_plan.zig");
const update_pricing_rule = @import("update_pricing_rule.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "billingconductor";

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

    /// Connects an array of account IDs in a consolidated billing family to a
    /// predefined billing group. The account IDs must be a part of the consolidated
    /// billing family during the current month, and not already associated with
    /// another billing group. The maximum number of accounts that can be associated
    /// in one call is 30.
    pub fn associateAccounts(self: *Self, allocator: std.mem.Allocator, input: associate_accounts.AssociateAccountsInput, options: CallOptions) !associate_accounts.AssociateAccountsOutput {
        return associate_accounts.execute(self, allocator, input, options);
    }

    /// Connects an array of `PricingRuleArns` to a defined `PricingPlan`. The
    /// maximum number `PricingRuleArn` that can be associated in one call is 30.
    pub fn associatePricingRules(self: *Self, allocator: std.mem.Allocator, input: associate_pricing_rules.AssociatePricingRulesInput, options: CallOptions) !associate_pricing_rules.AssociatePricingRulesOutput {
        return associate_pricing_rules.execute(self, allocator, input, options);
    }

    /// Associates a batch of resources to a percentage custom line item.
    pub fn batchAssociateResourcesToCustomLineItem(self: *Self, allocator: std.mem.Allocator, input: batch_associate_resources_to_custom_line_item.BatchAssociateResourcesToCustomLineItemInput, options: CallOptions) !batch_associate_resources_to_custom_line_item.BatchAssociateResourcesToCustomLineItemOutput {
        return batch_associate_resources_to_custom_line_item.execute(self, allocator, input, options);
    }

    /// Disassociates a batch of resources from a percentage custom line item.
    pub fn batchDisassociateResourcesFromCustomLineItem(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_resources_from_custom_line_item.BatchDisassociateResourcesFromCustomLineItemInput, options: CallOptions) !batch_disassociate_resources_from_custom_line_item.BatchDisassociateResourcesFromCustomLineItemOutput {
        return batch_disassociate_resources_from_custom_line_item.execute(self, allocator, input, options);
    }

    /// Creates a billing group that resembles a consolidated billing family that
    /// Amazon Web Services charges, based off of the predefined pricing plan
    /// computation.
    pub fn createBillingGroup(self: *Self, allocator: std.mem.Allocator, input: create_billing_group.CreateBillingGroupInput, options: CallOptions) !create_billing_group.CreateBillingGroupOutput {
        return create_billing_group.execute(self, allocator, input, options);
    }

    /// Creates a custom line item that can be used to create a one-time fixed
    /// charge that can be applied to a single billing group for the current or
    /// previous billing period. The one-time fixed charge is either a fee or
    /// discount.
    pub fn createCustomLineItem(self: *Self, allocator: std.mem.Allocator, input: create_custom_line_item.CreateCustomLineItemInput, options: CallOptions) !create_custom_line_item.CreateCustomLineItemOutput {
        return create_custom_line_item.execute(self, allocator, input, options);
    }

    /// Creates a pricing plan that is used for computing Amazon Web Services
    /// charges for billing groups.
    pub fn createPricingPlan(self: *Self, allocator: std.mem.Allocator, input: create_pricing_plan.CreatePricingPlanInput, options: CallOptions) !create_pricing_plan.CreatePricingPlanOutput {
        return create_pricing_plan.execute(self, allocator, input, options);
    }

    /// Creates a pricing rule can be associated to a pricing plan, or a set of
    /// pricing plans.
    pub fn createPricingRule(self: *Self, allocator: std.mem.Allocator, input: create_pricing_rule.CreatePricingRuleInput, options: CallOptions) !create_pricing_rule.CreatePricingRuleOutput {
        return create_pricing_rule.execute(self, allocator, input, options);
    }

    /// Deletes a billing group.
    pub fn deleteBillingGroup(self: *Self, allocator: std.mem.Allocator, input: delete_billing_group.DeleteBillingGroupInput, options: CallOptions) !delete_billing_group.DeleteBillingGroupOutput {
        return delete_billing_group.execute(self, allocator, input, options);
    }

    /// Deletes the custom line item identified by the given ARN in the current, or
    /// previous billing period.
    pub fn deleteCustomLineItem(self: *Self, allocator: std.mem.Allocator, input: delete_custom_line_item.DeleteCustomLineItemInput, options: CallOptions) !delete_custom_line_item.DeleteCustomLineItemOutput {
        return delete_custom_line_item.execute(self, allocator, input, options);
    }

    /// Deletes a pricing plan. The pricing plan must not be associated with any
    /// billing groups to delete successfully.
    pub fn deletePricingPlan(self: *Self, allocator: std.mem.Allocator, input: delete_pricing_plan.DeletePricingPlanInput, options: CallOptions) !delete_pricing_plan.DeletePricingPlanOutput {
        return delete_pricing_plan.execute(self, allocator, input, options);
    }

    /// Deletes the pricing rule that's identified by the input Amazon Resource Name
    /// (ARN).
    pub fn deletePricingRule(self: *Self, allocator: std.mem.Allocator, input: delete_pricing_rule.DeletePricingRuleInput, options: CallOptions) !delete_pricing_rule.DeletePricingRuleOutput {
        return delete_pricing_rule.execute(self, allocator, input, options);
    }

    /// Removes the specified list of account IDs from the given billing group.
    pub fn disassociateAccounts(self: *Self, allocator: std.mem.Allocator, input: disassociate_accounts.DisassociateAccountsInput, options: CallOptions) !disassociate_accounts.DisassociateAccountsOutput {
        return disassociate_accounts.execute(self, allocator, input, options);
    }

    /// Disassociates a list of pricing rules from a pricing plan.
    pub fn disassociatePricingRules(self: *Self, allocator: std.mem.Allocator, input: disassociate_pricing_rules.DisassociatePricingRulesInput, options: CallOptions) !disassociate_pricing_rules.DisassociatePricingRulesOutput {
        return disassociate_pricing_rules.execute(self, allocator, input, options);
    }

    /// Retrieves the margin summary report, which includes the Amazon Web Services
    /// cost and charged amount (pro forma cost) by Amazon Web Services service for
    /// a specific billing group.
    pub fn getBillingGroupCostReport(self: *Self, allocator: std.mem.Allocator, input: get_billing_group_cost_report.GetBillingGroupCostReportInput, options: CallOptions) !get_billing_group_cost_report.GetBillingGroupCostReportOutput {
        return get_billing_group_cost_report.execute(self, allocator, input, options);
    }

    /// This is a paginated call to list linked accounts that are linked to the
    /// payer account for the specified time period. If no information is provided,
    /// the current billing period is used. The response will optionally include the
    /// billing group that's associated with the linked account.
    pub fn listAccountAssociations(self: *Self, allocator: std.mem.Allocator, input: list_account_associations.ListAccountAssociationsInput, options: CallOptions) !list_account_associations.ListAccountAssociationsOutput {
        return list_account_associations.execute(self, allocator, input, options);
    }

    /// A paginated call to retrieve a summary report of actual Amazon Web Services
    /// charges and the calculated Amazon Web Services charges based on the
    /// associated pricing plan of a billing group.
    pub fn listBillingGroupCostReports(self: *Self, allocator: std.mem.Allocator, input: list_billing_group_cost_reports.ListBillingGroupCostReportsInput, options: CallOptions) !list_billing_group_cost_reports.ListBillingGroupCostReportsOutput {
        return list_billing_group_cost_reports.execute(self, allocator, input, options);
    }

    /// A paginated call to retrieve a list of billing groups for the given billing
    /// period. If you don't provide a billing group, the current billing period is
    /// used.
    pub fn listBillingGroups(self: *Self, allocator: std.mem.Allocator, input: list_billing_groups.ListBillingGroupsInput, options: CallOptions) !list_billing_groups.ListBillingGroupsOutput {
        return list_billing_groups.execute(self, allocator, input, options);
    }

    /// A paginated call to get a list of all custom line item versions.
    pub fn listCustomLineItemVersions(self: *Self, allocator: std.mem.Allocator, input: list_custom_line_item_versions.ListCustomLineItemVersionsInput, options: CallOptions) !list_custom_line_item_versions.ListCustomLineItemVersionsOutput {
        return list_custom_line_item_versions.execute(self, allocator, input, options);
    }

    /// A paginated call to get a list of all custom line items (FFLIs) for the
    /// given billing period. If you don't provide a billing period, the current
    /// billing period is used.
    pub fn listCustomLineItems(self: *Self, allocator: std.mem.Allocator, input: list_custom_line_items.ListCustomLineItemsInput, options: CallOptions) !list_custom_line_items.ListCustomLineItemsOutput {
        return list_custom_line_items.execute(self, allocator, input, options);
    }

    /// A paginated call to get pricing plans for the given billing period. If you
    /// don't provide a billing period, the current billing period is used.
    pub fn listPricingPlans(self: *Self, allocator: std.mem.Allocator, input: list_pricing_plans.ListPricingPlansInput, options: CallOptions) !list_pricing_plans.ListPricingPlansOutput {
        return list_pricing_plans.execute(self, allocator, input, options);
    }

    /// A list of the pricing plans that are associated with a pricing rule.
    pub fn listPricingPlansAssociatedWithPricingRule(self: *Self, allocator: std.mem.Allocator, input: list_pricing_plans_associated_with_pricing_rule.ListPricingPlansAssociatedWithPricingRuleInput, options: CallOptions) !list_pricing_plans_associated_with_pricing_rule.ListPricingPlansAssociatedWithPricingRuleOutput {
        return list_pricing_plans_associated_with_pricing_rule.execute(self, allocator, input, options);
    }

    /// Describes a pricing rule that can be associated to a pricing plan, or set of
    /// pricing plans.
    pub fn listPricingRules(self: *Self, allocator: std.mem.Allocator, input: list_pricing_rules.ListPricingRulesInput, options: CallOptions) !list_pricing_rules.ListPricingRulesOutput {
        return list_pricing_rules.execute(self, allocator, input, options);
    }

    /// Lists the pricing rules that are associated with a pricing plan.
    pub fn listPricingRulesAssociatedToPricingPlan(self: *Self, allocator: std.mem.Allocator, input: list_pricing_rules_associated_to_pricing_plan.ListPricingRulesAssociatedToPricingPlanInput, options: CallOptions) !list_pricing_rules_associated_to_pricing_plan.ListPricingRulesAssociatedToPricingPlanOutput {
        return list_pricing_rules_associated_to_pricing_plan.execute(self, allocator, input, options);
    }

    /// List the resources that are associated to a custom line item.
    pub fn listResourcesAssociatedToCustomLineItem(self: *Self, allocator: std.mem.Allocator, input: list_resources_associated_to_custom_line_item.ListResourcesAssociatedToCustomLineItemInput, options: CallOptions) !list_resources_associated_to_custom_line_item.ListResourcesAssociatedToCustomLineItemOutput {
        return list_resources_associated_to_custom_line_item.execute(self, allocator, input, options);
    }

    /// A list the tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified
    /// `resourceArn`. If existing tags on a resource are not specified in the
    /// request parameters, they are not changed.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// This updates an existing billing group.
    pub fn updateBillingGroup(self: *Self, allocator: std.mem.Allocator, input: update_billing_group.UpdateBillingGroupInput, options: CallOptions) !update_billing_group.UpdateBillingGroupOutput {
        return update_billing_group.execute(self, allocator, input, options);
    }

    /// Update an existing custom line item in the current or previous billing
    /// period.
    pub fn updateCustomLineItem(self: *Self, allocator: std.mem.Allocator, input: update_custom_line_item.UpdateCustomLineItemInput, options: CallOptions) !update_custom_line_item.UpdateCustomLineItemOutput {
        return update_custom_line_item.execute(self, allocator, input, options);
    }

    /// This updates an existing pricing plan.
    pub fn updatePricingPlan(self: *Self, allocator: std.mem.Allocator, input: update_pricing_plan.UpdatePricingPlanInput, options: CallOptions) !update_pricing_plan.UpdatePricingPlanOutput {
        return update_pricing_plan.execute(self, allocator, input, options);
    }

    /// Updates an existing pricing rule.
    pub fn updatePricingRule(self: *Self, allocator: std.mem.Allocator, input: update_pricing_rule.UpdatePricingRuleInput, options: CallOptions) !update_pricing_rule.UpdatePricingRuleOutput {
        return update_pricing_rule.execute(self, allocator, input, options);
    }

    pub fn getBillingGroupCostReportPaginator(self: *Self, params: get_billing_group_cost_report.GetBillingGroupCostReportInput) paginator.GetBillingGroupCostReportPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountAssociationsPaginator(self: *Self, params: list_account_associations.ListAccountAssociationsInput) paginator.ListAccountAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillingGroupCostReportsPaginator(self: *Self, params: list_billing_group_cost_reports.ListBillingGroupCostReportsInput) paginator.ListBillingGroupCostReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillingGroupsPaginator(self: *Self, params: list_billing_groups.ListBillingGroupsInput) paginator.ListBillingGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCustomLineItemVersionsPaginator(self: *Self, params: list_custom_line_item_versions.ListCustomLineItemVersionsInput) paginator.ListCustomLineItemVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCustomLineItemsPaginator(self: *Self, params: list_custom_line_items.ListCustomLineItemsInput) paginator.ListCustomLineItemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPricingPlansPaginator(self: *Self, params: list_pricing_plans.ListPricingPlansInput) paginator.ListPricingPlansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPricingPlansAssociatedWithPricingRulePaginator(self: *Self, params: list_pricing_plans_associated_with_pricing_rule.ListPricingPlansAssociatedWithPricingRuleInput) paginator.ListPricingPlansAssociatedWithPricingRulePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPricingRulesPaginator(self: *Self, params: list_pricing_rules.ListPricingRulesInput) paginator.ListPricingRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPricingRulesAssociatedToPricingPlanPaginator(self: *Self, params: list_pricing_rules_associated_to_pricing_plan.ListPricingRulesAssociatedToPricingPlanInput) paginator.ListPricingRulesAssociatedToPricingPlanPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourcesAssociatedToCustomLineItemPaginator(self: *Self, params: list_resources_associated_to_custom_line_item.ListResourcesAssociatedToCustomLineItemInput) paginator.ListResourcesAssociatedToCustomLineItemPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

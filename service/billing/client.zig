const aws = @import("aws");
const std = @import("std");

const associate_source_views = @import("associate_source_views.zig");
const create_billing_view = @import("create_billing_view.zig");
const delete_billing_view = @import("delete_billing_view.zig");
const disassociate_source_views = @import("disassociate_source_views.zig");
const get_billing_preferences = @import("get_billing_preferences.zig");
const get_billing_view = @import("get_billing_view.zig");
const get_credit_allocation_history = @import("get_credit_allocation_history.zig");
const get_credits = @import("get_credits.zig");
const get_enterprise_support_charge_summary = @import("get_enterprise_support_charge_summary.zig");
const get_enterprise_support_contract_details = @import("get_enterprise_support_contract_details.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const list_billing_view_segments = @import("list_billing_view_segments.zig");
const list_billing_views = @import("list_billing_views.zig");
const list_business_support_account_charges = @import("list_business_support_account_charges.zig");
const list_business_support_subscription_history = @import("list_business_support_subscription_history.zig");
const list_enterprise_support_linked_account_charges = @import("list_enterprise_support_linked_account_charges.zig");
const list_source_views_for_billing_view = @import("list_source_views_for_billing_view.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const redeem_credits = @import("redeem_credits.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_billing_preferences = @import("update_billing_preferences.zig");
const update_billing_view = @import("update_billing_view.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Billing";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Associates one or more source billing views with an existing billing view.
    /// This allows creating aggregate billing views that combine data from multiple
    /// sources.
    pub fn associateSourceViews(self: *Self, allocator: std.mem.Allocator, input: associate_source_views.AssociateSourceViewsInput, options: CallOptions) !associate_source_views.AssociateSourceViewsOutput {
        return associate_source_views.execute(self, allocator, input, options);
    }

    /// Creates a billing view with the specified billing view attributes.
    pub fn createBillingView(self: *Self, allocator: std.mem.Allocator, input: create_billing_view.CreateBillingViewInput, options: CallOptions) !create_billing_view.CreateBillingViewOutput {
        return create_billing_view.execute(self, allocator, input, options);
    }

    /// Deletes the specified billing view.
    pub fn deleteBillingView(self: *Self, allocator: std.mem.Allocator, input: delete_billing_view.DeleteBillingViewInput, options: CallOptions) !delete_billing_view.DeleteBillingViewOutput {
        return delete_billing_view.execute(self, allocator, input, options);
    }

    /// Removes the association between one or more source billing views and an
    /// existing billing view. This allows modifying the composition of aggregate
    /// billing views.
    pub fn disassociateSourceViews(self: *Self, allocator: std.mem.Allocator, input: disassociate_source_views.DisassociateSourceViewsInput, options: CallOptions) !disassociate_source_views.DisassociateSourceViewsOutput {
        return disassociate_source_views.execute(self, allocator, input, options);
    }

    /// Retrieves billing preferences for the specified feature. Each feature
    /// controls a distinct billing capability: which accounts can share Reserved
    /// Instances or credits, whether billing alerts are enabled, the historical
    /// record of sharing changes, and per-credit options.
    pub fn getBillingPreferences(self: *Self, allocator: std.mem.Allocator, input: get_billing_preferences.GetBillingPreferencesInput, options: CallOptions) !get_billing_preferences.GetBillingPreferencesOutput {
        return get_billing_preferences.execute(self, allocator, input, options);
    }

    /// Returns the metadata associated to the specified billing view ARN.
    pub fn getBillingView(self: *Self, allocator: std.mem.Allocator, input: get_billing_view.GetBillingViewInput, options: CallOptions) !get_billing_view.GetBillingViewOutput {
        return get_billing_view.execute(self, allocator, input, options);
    }

    /// Returns the per-billing-month allocation history for credits applied to an
    /// Amazon Web Services account's bills. Traverses the consolidated billing
    /// family to capture cross-account credit applications. Supports pagination and
    /// optional filtering to a single credit.
    pub fn getCreditAllocationHistory(self: *Self, allocator: std.mem.Allocator, input: get_credit_allocation_history.GetCreditAllocationHistoryInput, options: CallOptions) !get_credit_allocation_history.GetCreditAllocationHistoryOutput {
        return get_credit_allocation_history.execute(self, allocator, input, options);
    }

    /// Returns the list of Amazon Web Services account credits for the specified
    /// account. Each credit includes its identifier, type, monetary amounts,
    /// applicable products, expiration, sharing configuration, and current enabled
    /// status.
    ///
    /// When the caller is the management account of a consolidated billing family
    /// and `payerAccountFlag` is `true`, the response aggregates credits across the
    /// entire family. Otherwise, the response includes only credits owned by the
    /// account specified in `accountId`.
    pub fn getCredits(self: *Self, allocator: std.mem.Allocator, input: get_credits.GetCreditsInput, options: CallOptions) !get_credits.GetCreditsOutput {
        return get_credits.execute(self, allocator, input, options);
    }

    /// Returns a summary of Enterprise Support data aggregated across all accounts
    /// in the Enterprise Support profile.
    pub fn getEnterpriseSupportChargeSummary(self: *Self, allocator: std.mem.Allocator, input: get_enterprise_support_charge_summary.GetEnterpriseSupportChargeSummaryInput, options: CallOptions) !get_enterprise_support_charge_summary.GetEnterpriseSupportChargeSummaryOutput {
        return get_enterprise_support_charge_summary.execute(self, allocator, input, options);
    }

    /// Returns Enterprise Support contract details.
    pub fn getEnterpriseSupportContractDetails(self: *Self, allocator: std.mem.Allocator, input: get_enterprise_support_contract_details.GetEnterpriseSupportContractDetailsInput, options: CallOptions) !get_enterprise_support_contract_details.GetEnterpriseSupportContractDetailsOutput {
        return get_enterprise_support_contract_details.execute(self, allocator, input, options);
    }

    /// Returns the resource-based policy document attached to the resource in
    /// `JSON` format.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Lists the segments of a billing view over a given time period. Each segment
    /// identifies the billing domain (`PRO_FORMA` or `BILLABLE`) and the account
    /// relationships that apply during its time range.
    ///
    /// If you don't provide an `arn`, the response includes segments for the
    /// caller's `PRIMARY` billing view.
    ///
    /// If a mid-period change occurs, the response includes multiple segments, each
    /// with its own time range. The response omits hidden segments, so the segments
    /// it returns might not cover the entire requested time period.
    pub fn listBillingViewSegments(self: *Self, allocator: std.mem.Allocator, input: list_billing_view_segments.ListBillingViewSegmentsInput, options: CallOptions) !list_billing_view_segments.ListBillingViewSegmentsOutput {
        return list_billing_view_segments.execute(self, allocator, input, options);
    }

    /// Lists the billing views available for a given time period.
    ///
    /// Every Amazon Web Services account has a unique `PRIMARY` billing view that
    /// represents the billing data available by default. Accounts that use Billing
    /// Conductor also have `BILLING_GROUP` billing views representing pro forma
    /// costs associated with each created billing group.
    pub fn listBillingViews(self: *Self, allocator: std.mem.Allocator, input: list_billing_views.ListBillingViewsInput, options: CallOptions) !list_billing_views.ListBillingViewsOutput {
        return list_billing_views.execute(self, allocator, input, options);
    }

    /// Returns Business Support charges broken down at the linked account level for
    /// a given billing month.
    pub fn listBusinessSupportAccountCharges(self: *Self, allocator: std.mem.Allocator, input: list_business_support_account_charges.ListBusinessSupportAccountChargesInput, options: CallOptions) !list_business_support_account_charges.ListBusinessSupportAccountChargesOutput {
        return list_business_support_account_charges.execute(self, allocator, input, options);
    }

    /// Returns the history of Business Support subscription contracts across
    /// accounts.
    pub fn listBusinessSupportSubscriptionHistory(self: *Self, allocator: std.mem.Allocator, input: list_business_support_subscription_history.ListBusinessSupportSubscriptionHistoryInput, options: CallOptions) !list_business_support_subscription_history.ListBusinessSupportSubscriptionHistoryOutput {
        return list_business_support_subscription_history.execute(self, allocator, input, options);
    }

    /// Returns Support-eligible spend broken down at linked account level.
    pub fn listEnterpriseSupportLinkedAccountCharges(self: *Self, allocator: std.mem.Allocator, input: list_enterprise_support_linked_account_charges.ListEnterpriseSupportLinkedAccountChargesInput, options: CallOptions) !list_enterprise_support_linked_account_charges.ListEnterpriseSupportLinkedAccountChargesOutput {
        return list_enterprise_support_linked_account_charges.execute(self, allocator, input, options);
    }

    /// Lists the source views (managed Amazon Web Services billing views)
    /// associated with the billing view.
    pub fn listSourceViewsForBillingView(self: *Self, allocator: std.mem.Allocator, input: list_source_views_for_billing_view.ListSourceViewsForBillingViewInput, options: CallOptions) !list_source_views_for_billing_view.ListSourceViewsForBillingViewOutput {
        return list_source_views_for_billing_view.execute(self, allocator, input, options);
    }

    /// Lists tags associated with the billing view resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Redeems an Amazon Web Services promotional credit code on behalf of the
    /// calling account. On success, a new credit is added to the account's credit
    /// ledger with the amount, validity period, and applicable products defined by
    /// the promotion. The credit is then automatically applied to subsequent bills
    /// according to the standard credit application order.
    pub fn redeemCredits(self: *Self, allocator: std.mem.Allocator, input: redeem_credits.RedeemCreditsInput, options: CallOptions) !redeem_credits.RedeemCreditsOutput {
        return redeem_credits.execute(self, allocator, input, options);
    }

    /// An API operation for adding one or more tags (key-value pairs) to a
    /// resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a resource. Specify only tag keys in your
    /// request. Don't specify the value.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates billing preferences for the specified feature. Each feature targets
    /// a distinct billing capability and has its own set of supported keys. The
    /// action sets the value for each provided key; keys not present in the request
    /// are unchanged.
    ///
    /// Sharing keys (`RI_SHARING`, `CREDIT_SHARING`, `CREDIT_LEVEL_SHARING`, and
    /// sharing keys under `CREDIT_PREFERENCE_OPTIONS`) may only be set by the
    /// management account of a consolidated billing family. The
    /// `credit/{creditId}/status` key may be set by member accounts for credits
    /// they own, or by the management account for any credit in the family.
    pub fn updateBillingPreferences(self: *Self, allocator: std.mem.Allocator, input: update_billing_preferences.UpdateBillingPreferencesInput, options: CallOptions) !update_billing_preferences.UpdateBillingPreferencesOutput {
        return update_billing_preferences.execute(self, allocator, input, options);
    }

    /// An API to update the attributes of the billing view.
    pub fn updateBillingView(self: *Self, allocator: std.mem.Allocator, input: update_billing_view.UpdateBillingViewInput, options: CallOptions) !update_billing_view.UpdateBillingViewOutput {
        return update_billing_view.execute(self, allocator, input, options);
    }

    pub fn getCreditAllocationHistoryPaginator(self: *Self, params: get_credit_allocation_history.GetCreditAllocationHistoryInput) paginator.GetCreditAllocationHistoryPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBillingViewSegmentsPaginator(self: *Self, params: list_billing_view_segments.ListBillingViewSegmentsInput) paginator.ListBillingViewSegmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBillingViewsPaginator(self: *Self, params: list_billing_views.ListBillingViewsInput) paginator.ListBillingViewsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBusinessSupportAccountChargesPaginator(self: *Self, params: list_business_support_account_charges.ListBusinessSupportAccountChargesInput) paginator.ListBusinessSupportAccountChargesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBusinessSupportSubscriptionHistoryPaginator(self: *Self, params: list_business_support_subscription_history.ListBusinessSupportSubscriptionHistoryInput) paginator.ListBusinessSupportSubscriptionHistoryPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnterpriseSupportLinkedAccountChargesPaginator(self: *Self, params: list_enterprise_support_linked_account_charges.ListEnterpriseSupportLinkedAccountChargesInput) paginator.ListEnterpriseSupportLinkedAccountChargesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSourceViewsForBillingViewPaginator(self: *Self, params: list_source_views_for_billing_view.ListSourceViewsForBillingViewInput) paginator.ListSourceViewsForBillingViewPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

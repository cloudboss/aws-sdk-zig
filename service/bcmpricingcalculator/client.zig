const aws = @import("aws");
const std = @import("std");

const batch_create_bill_scenario_commitment_modification = @import("batch_create_bill_scenario_commitment_modification.zig");
const batch_create_bill_scenario_usage_modification = @import("batch_create_bill_scenario_usage_modification.zig");
const batch_create_workload_estimate_usage = @import("batch_create_workload_estimate_usage.zig");
const batch_delete_bill_scenario_commitment_modification = @import("batch_delete_bill_scenario_commitment_modification.zig");
const batch_delete_bill_scenario_usage_modification = @import("batch_delete_bill_scenario_usage_modification.zig");
const batch_delete_workload_estimate_usage = @import("batch_delete_workload_estimate_usage.zig");
const batch_update_bill_scenario_commitment_modification = @import("batch_update_bill_scenario_commitment_modification.zig");
const batch_update_bill_scenario_usage_modification = @import("batch_update_bill_scenario_usage_modification.zig");
const batch_update_workload_estimate_usage = @import("batch_update_workload_estimate_usage.zig");
const create_bill_estimate = @import("create_bill_estimate.zig");
const create_bill_scenario = @import("create_bill_scenario.zig");
const create_workload_estimate = @import("create_workload_estimate.zig");
const delete_bill_estimate = @import("delete_bill_estimate.zig");
const delete_bill_scenario = @import("delete_bill_scenario.zig");
const delete_workload_estimate = @import("delete_workload_estimate.zig");
const get_bill_estimate = @import("get_bill_estimate.zig");
const get_bill_scenario = @import("get_bill_scenario.zig");
const get_preferences = @import("get_preferences.zig");
const get_workload_estimate = @import("get_workload_estimate.zig");
const list_bill_estimate_commitments = @import("list_bill_estimate_commitments.zig");
const list_bill_estimate_input_commitment_modifications = @import("list_bill_estimate_input_commitment_modifications.zig");
const list_bill_estimate_input_usage_modifications = @import("list_bill_estimate_input_usage_modifications.zig");
const list_bill_estimate_line_items = @import("list_bill_estimate_line_items.zig");
const list_bill_estimates = @import("list_bill_estimates.zig");
const list_bill_scenario_commitment_modifications = @import("list_bill_scenario_commitment_modifications.zig");
const list_bill_scenario_usage_modifications = @import("list_bill_scenario_usage_modifications.zig");
const list_bill_scenarios = @import("list_bill_scenarios.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_workload_estimate_usage = @import("list_workload_estimate_usage.zig");
const list_workload_estimates = @import("list_workload_estimates.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_bill_estimate = @import("update_bill_estimate.zig");
const update_bill_scenario = @import("update_bill_scenario.zig");
const update_preferences = @import("update_preferences.zig");
const update_workload_estimate = @import("update_workload_estimate.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "BCM Pricing Calculator";

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

    /// Create Compute Savings Plans, EC2 Instance Savings Plans, or EC2 Reserved
    /// Instances commitments that you want to model in a Bill Scenario.
    ///
    /// The `BatchCreateBillScenarioCommitmentModification` operation doesn't have
    /// its own IAM permission. To authorize this operation for Amazon Web Services
    /// principals, include the permission
    /// `bcm-pricing-calculator:CreateBillScenarioCommitmentModification` in your
    /// policies.
    pub fn batchCreateBillScenarioCommitmentModification(self: *Self, allocator: std.mem.Allocator, input: batch_create_bill_scenario_commitment_modification.BatchCreateBillScenarioCommitmentModificationInput, options: CallOptions) !batch_create_bill_scenario_commitment_modification.BatchCreateBillScenarioCommitmentModificationOutput {
        return batch_create_bill_scenario_commitment_modification.execute(self, allocator, input, options);
    }

    /// Create Amazon Web Services service usage that you want to model in a Bill
    /// Scenario.
    ///
    /// The `BatchCreateBillScenarioUsageModification` operation doesn't have its
    /// own IAM permission. To authorize this operation for Amazon Web Services
    /// principals, include the permission
    /// `bcm-pricing-calculator:CreateBillScenarioUsageModification` in your
    /// policies.
    pub fn batchCreateBillScenarioUsageModification(self: *Self, allocator: std.mem.Allocator, input: batch_create_bill_scenario_usage_modification.BatchCreateBillScenarioUsageModificationInput, options: CallOptions) !batch_create_bill_scenario_usage_modification.BatchCreateBillScenarioUsageModificationOutput {
        return batch_create_bill_scenario_usage_modification.execute(self, allocator, input, options);
    }

    /// Create Amazon Web Services service usage that you want to model in a
    /// Workload Estimate.
    ///
    /// The `BatchCreateWorkloadEstimateUsage` operation doesn't have its own IAM
    /// permission. To authorize this operation for Amazon Web Services principals,
    /// include the permission `bcm-pricing-calculator:CreateWorkloadEstimateUsage`
    /// in your policies.
    pub fn batchCreateWorkloadEstimateUsage(self: *Self, allocator: std.mem.Allocator, input: batch_create_workload_estimate_usage.BatchCreateWorkloadEstimateUsageInput, options: CallOptions) !batch_create_workload_estimate_usage.BatchCreateWorkloadEstimateUsageOutput {
        return batch_create_workload_estimate_usage.execute(self, allocator, input, options);
    }

    /// Delete commitment that you have created in a Bill Scenario. You can only
    /// delete a commitment that you had added and cannot model deletion (or
    /// removal) of a existing commitment. If you want model deletion of an existing
    /// commitment, see the negate [
    /// BillScenarioCommitmentModificationAction](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_AWSBCMPricingCalculator_BillScenarioCommitmentModificationAction.html) of [ BatchCreateBillScenarioCommitmentModification](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_AWSBCMPricingCalculator_BatchCreateBillScenarioUsageModification.html) operation.
    ///
    /// The `BatchDeleteBillScenarioCommitmentModification` operation doesn't have
    /// its own IAM permission. To authorize this operation for Amazon Web Services
    /// principals, include the permission
    /// `bcm-pricing-calculator:DeleteBillScenarioCommitmentModification` in your
    /// policies.
    pub fn batchDeleteBillScenarioCommitmentModification(self: *Self, allocator: std.mem.Allocator, input: batch_delete_bill_scenario_commitment_modification.BatchDeleteBillScenarioCommitmentModificationInput, options: CallOptions) !batch_delete_bill_scenario_commitment_modification.BatchDeleteBillScenarioCommitmentModificationOutput {
        return batch_delete_bill_scenario_commitment_modification.execute(self, allocator, input, options);
    }

    /// Delete usage that you have created in a Bill Scenario. You can only delete
    /// usage that you had added and cannot model deletion (or removal) of a
    /// existing usage. If you want model removal of an existing usage, see [
    /// BatchUpdateBillScenarioUsageModification](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_AWSBCMPricingCalculator_BatchUpdateBillScenarioUsageModification.html).
    ///
    /// The `BatchDeleteBillScenarioUsageModification` operation doesn't have its
    /// own IAM permission. To authorize this operation for Amazon Web Services
    /// principals, include the permission
    /// `bcm-pricing-calculator:DeleteBillScenarioUsageModification` in your
    /// policies.
    pub fn batchDeleteBillScenarioUsageModification(self: *Self, allocator: std.mem.Allocator, input: batch_delete_bill_scenario_usage_modification.BatchDeleteBillScenarioUsageModificationInput, options: CallOptions) !batch_delete_bill_scenario_usage_modification.BatchDeleteBillScenarioUsageModificationOutput {
        return batch_delete_bill_scenario_usage_modification.execute(self, allocator, input, options);
    }

    /// Delete usage that you have created in a Workload estimate. You can only
    /// delete usage that you had added and cannot model deletion (or removal) of a
    /// existing usage. If you want model removal of an existing usage, see [
    /// BatchUpdateWorkloadEstimateUsage](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_AWSBCMPricingCalculator_BatchUpdateWorkloadEstimateUsage.html).
    ///
    /// The `BatchDeleteWorkloadEstimateUsage` operation doesn't have its own IAM
    /// permission. To authorize this operation for Amazon Web Services principals,
    /// include the permission `bcm-pricing-calculator:DeleteWorkloadEstimateUsage`
    /// in your policies.
    pub fn batchDeleteWorkloadEstimateUsage(self: *Self, allocator: std.mem.Allocator, input: batch_delete_workload_estimate_usage.BatchDeleteWorkloadEstimateUsageInput, options: CallOptions) !batch_delete_workload_estimate_usage.BatchDeleteWorkloadEstimateUsageOutput {
        return batch_delete_workload_estimate_usage.execute(self, allocator, input, options);
    }

    /// Update a newly added or existing commitment. You can update the commitment
    /// group based on a commitment ID and a Bill scenario ID.
    ///
    /// The `BatchUpdateBillScenarioCommitmentModification` operation doesn't have
    /// its own IAM permission. To authorize this operation for Amazon Web Services
    /// principals, include the permission
    /// `bcm-pricing-calculator:UpdateBillScenarioCommitmentModification` in your
    /// policies.
    pub fn batchUpdateBillScenarioCommitmentModification(self: *Self, allocator: std.mem.Allocator, input: batch_update_bill_scenario_commitment_modification.BatchUpdateBillScenarioCommitmentModificationInput, options: CallOptions) !batch_update_bill_scenario_commitment_modification.BatchUpdateBillScenarioCommitmentModificationOutput {
        return batch_update_bill_scenario_commitment_modification.execute(self, allocator, input, options);
    }

    /// Update a newly added or existing usage lines. You can update the usage
    /// amounts, usage hour, and usage group based on a usage ID and a Bill scenario
    /// ID.
    ///
    /// The `BatchUpdateBillScenarioUsageModification` operation doesn't have its
    /// own IAM permission. To authorize this operation for Amazon Web Services
    /// principals, include the permission
    /// `bcm-pricing-calculator:UpdateBillScenarioUsageModification` in your
    /// policies.
    pub fn batchUpdateBillScenarioUsageModification(self: *Self, allocator: std.mem.Allocator, input: batch_update_bill_scenario_usage_modification.BatchUpdateBillScenarioUsageModificationInput, options: CallOptions) !batch_update_bill_scenario_usage_modification.BatchUpdateBillScenarioUsageModificationOutput {
        return batch_update_bill_scenario_usage_modification.execute(self, allocator, input, options);
    }

    /// Update a newly added or existing usage lines. You can update the usage
    /// amounts and usage group based on a usage ID and a Workload estimate ID.
    ///
    /// The `BatchUpdateWorkloadEstimateUsage` operation doesn't have its own IAM
    /// permission. To authorize this operation for Amazon Web Services principals,
    /// include the permission `bcm-pricing-calculator:UpdateWorkloadEstimateUsage`
    /// in your policies.
    pub fn batchUpdateWorkloadEstimateUsage(self: *Self, allocator: std.mem.Allocator, input: batch_update_workload_estimate_usage.BatchUpdateWorkloadEstimateUsageInput, options: CallOptions) !batch_update_workload_estimate_usage.BatchUpdateWorkloadEstimateUsageOutput {
        return batch_update_workload_estimate_usage.execute(self, allocator, input, options);
    }

    /// Create a Bill estimate from a Bill scenario. In the Bill scenario you can
    /// model usage addition, usage changes, and usage removal. You can also model
    /// commitment addition and commitment removal. After all changes in a Bill
    /// scenario is made satisfactorily, you can call this API with a Bill scenario
    /// ID to generate the Bill estimate. Bill estimate calculates the pre-tax cost
    /// for your consolidated billing family, incorporating all modeled usage and
    /// commitments alongside existing usage and commitments from your most recent
    /// completed anniversary bill, with any applicable discounts applied.
    pub fn createBillEstimate(self: *Self, allocator: std.mem.Allocator, input: create_bill_estimate.CreateBillEstimateInput, options: CallOptions) !create_bill_estimate.CreateBillEstimateOutput {
        return create_bill_estimate.execute(self, allocator, input, options);
    }

    /// Creates a new bill scenario to model potential changes to Amazon Web
    /// Services usage and costs.
    pub fn createBillScenario(self: *Self, allocator: std.mem.Allocator, input: create_bill_scenario.CreateBillScenarioInput, options: CallOptions) !create_bill_scenario.CreateBillScenarioOutput {
        return create_bill_scenario.execute(self, allocator, input, options);
    }

    /// Creates a new workload estimate to model costs for a specific workload.
    pub fn createWorkloadEstimate(self: *Self, allocator: std.mem.Allocator, input: create_workload_estimate.CreateWorkloadEstimateInput, options: CallOptions) !create_workload_estimate.CreateWorkloadEstimateOutput {
        return create_workload_estimate.execute(self, allocator, input, options);
    }

    /// Deletes an existing bill estimate.
    pub fn deleteBillEstimate(self: *Self, allocator: std.mem.Allocator, input: delete_bill_estimate.DeleteBillEstimateInput, options: CallOptions) !delete_bill_estimate.DeleteBillEstimateOutput {
        return delete_bill_estimate.execute(self, allocator, input, options);
    }

    /// Deletes an existing bill scenario.
    pub fn deleteBillScenario(self: *Self, allocator: std.mem.Allocator, input: delete_bill_scenario.DeleteBillScenarioInput, options: CallOptions) !delete_bill_scenario.DeleteBillScenarioOutput {
        return delete_bill_scenario.execute(self, allocator, input, options);
    }

    /// Deletes an existing workload estimate.
    pub fn deleteWorkloadEstimate(self: *Self, allocator: std.mem.Allocator, input: delete_workload_estimate.DeleteWorkloadEstimateInput, options: CallOptions) !delete_workload_estimate.DeleteWorkloadEstimateOutput {
        return delete_workload_estimate.execute(self, allocator, input, options);
    }

    /// Retrieves details of a specific bill estimate.
    pub fn getBillEstimate(self: *Self, allocator: std.mem.Allocator, input: get_bill_estimate.GetBillEstimateInput, options: CallOptions) !get_bill_estimate.GetBillEstimateOutput {
        return get_bill_estimate.execute(self, allocator, input, options);
    }

    /// Retrieves details of a specific bill scenario.
    pub fn getBillScenario(self: *Self, allocator: std.mem.Allocator, input: get_bill_scenario.GetBillScenarioInput, options: CallOptions) !get_bill_scenario.GetBillScenarioOutput {
        return get_bill_scenario.execute(self, allocator, input, options);
    }

    /// Retrieves the current preferences for Pricing Calculator.
    pub fn getPreferences(self: *Self, allocator: std.mem.Allocator, input: get_preferences.GetPreferencesInput, options: CallOptions) !get_preferences.GetPreferencesOutput {
        return get_preferences.execute(self, allocator, input, options);
    }

    /// Retrieves details of a specific workload estimate.
    pub fn getWorkloadEstimate(self: *Self, allocator: std.mem.Allocator, input: get_workload_estimate.GetWorkloadEstimateInput, options: CallOptions) !get_workload_estimate.GetWorkloadEstimateOutput {
        return get_workload_estimate.execute(self, allocator, input, options);
    }

    /// Lists the commitments associated with a bill estimate.
    pub fn listBillEstimateCommitments(self: *Self, allocator: std.mem.Allocator, input: list_bill_estimate_commitments.ListBillEstimateCommitmentsInput, options: CallOptions) !list_bill_estimate_commitments.ListBillEstimateCommitmentsOutput {
        return list_bill_estimate_commitments.execute(self, allocator, input, options);
    }

    /// Lists the input commitment modifications associated with a bill estimate.
    pub fn listBillEstimateInputCommitmentModifications(self: *Self, allocator: std.mem.Allocator, input: list_bill_estimate_input_commitment_modifications.ListBillEstimateInputCommitmentModificationsInput, options: CallOptions) !list_bill_estimate_input_commitment_modifications.ListBillEstimateInputCommitmentModificationsOutput {
        return list_bill_estimate_input_commitment_modifications.execute(self, allocator, input, options);
    }

    /// Lists the input usage modifications associated with a bill estimate.
    pub fn listBillEstimateInputUsageModifications(self: *Self, allocator: std.mem.Allocator, input: list_bill_estimate_input_usage_modifications.ListBillEstimateInputUsageModificationsInput, options: CallOptions) !list_bill_estimate_input_usage_modifications.ListBillEstimateInputUsageModificationsOutput {
        return list_bill_estimate_input_usage_modifications.execute(self, allocator, input, options);
    }

    /// Lists the line items associated with a bill estimate.
    pub fn listBillEstimateLineItems(self: *Self, allocator: std.mem.Allocator, input: list_bill_estimate_line_items.ListBillEstimateLineItemsInput, options: CallOptions) !list_bill_estimate_line_items.ListBillEstimateLineItemsOutput {
        return list_bill_estimate_line_items.execute(self, allocator, input, options);
    }

    /// Lists all bill estimates for the account.
    pub fn listBillEstimates(self: *Self, allocator: std.mem.Allocator, input: list_bill_estimates.ListBillEstimatesInput, options: CallOptions) !list_bill_estimates.ListBillEstimatesOutput {
        return list_bill_estimates.execute(self, allocator, input, options);
    }

    /// Lists the commitment modifications associated with a bill scenario.
    pub fn listBillScenarioCommitmentModifications(self: *Self, allocator: std.mem.Allocator, input: list_bill_scenario_commitment_modifications.ListBillScenarioCommitmentModificationsInput, options: CallOptions) !list_bill_scenario_commitment_modifications.ListBillScenarioCommitmentModificationsOutput {
        return list_bill_scenario_commitment_modifications.execute(self, allocator, input, options);
    }

    /// Lists the usage modifications associated with a bill scenario.
    pub fn listBillScenarioUsageModifications(self: *Self, allocator: std.mem.Allocator, input: list_bill_scenario_usage_modifications.ListBillScenarioUsageModificationsInput, options: CallOptions) !list_bill_scenario_usage_modifications.ListBillScenarioUsageModificationsOutput {
        return list_bill_scenario_usage_modifications.execute(self, allocator, input, options);
    }

    /// Lists all bill scenarios for the account.
    pub fn listBillScenarios(self: *Self, allocator: std.mem.Allocator, input: list_bill_scenarios.ListBillScenariosInput, options: CallOptions) !list_bill_scenarios.ListBillScenariosOutput {
        return list_bill_scenarios.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with a specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the usage associated with a workload estimate.
    pub fn listWorkloadEstimateUsage(self: *Self, allocator: std.mem.Allocator, input: list_workload_estimate_usage.ListWorkloadEstimateUsageInput, options: CallOptions) !list_workload_estimate_usage.ListWorkloadEstimateUsageOutput {
        return list_workload_estimate_usage.execute(self, allocator, input, options);
    }

    /// Lists all workload estimates for the account.
    pub fn listWorkloadEstimates(self: *Self, allocator: std.mem.Allocator, input: list_workload_estimates.ListWorkloadEstimatesInput, options: CallOptions) !list_workload_estimates.ListWorkloadEstimatesOutput {
        return list_workload_estimates.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing bill estimate.
    pub fn updateBillEstimate(self: *Self, allocator: std.mem.Allocator, input: update_bill_estimate.UpdateBillEstimateInput, options: CallOptions) !update_bill_estimate.UpdateBillEstimateOutput {
        return update_bill_estimate.execute(self, allocator, input, options);
    }

    /// Updates an existing bill scenario.
    pub fn updateBillScenario(self: *Self, allocator: std.mem.Allocator, input: update_bill_scenario.UpdateBillScenarioInput, options: CallOptions) !update_bill_scenario.UpdateBillScenarioOutput {
        return update_bill_scenario.execute(self, allocator, input, options);
    }

    /// Updates the preferences for Pricing Calculator.
    pub fn updatePreferences(self: *Self, allocator: std.mem.Allocator, input: update_preferences.UpdatePreferencesInput, options: CallOptions) !update_preferences.UpdatePreferencesOutput {
        return update_preferences.execute(self, allocator, input, options);
    }

    /// Updates an existing workload estimate.
    pub fn updateWorkloadEstimate(self: *Self, allocator: std.mem.Allocator, input: update_workload_estimate.UpdateWorkloadEstimateInput, options: CallOptions) !update_workload_estimate.UpdateWorkloadEstimateOutput {
        return update_workload_estimate.execute(self, allocator, input, options);
    }

    pub fn listBillEstimateCommitmentsPaginator(self: *Self, params: list_bill_estimate_commitments.ListBillEstimateCommitmentsInput) paginator.ListBillEstimateCommitmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillEstimateInputCommitmentModificationsPaginator(self: *Self, params: list_bill_estimate_input_commitment_modifications.ListBillEstimateInputCommitmentModificationsInput) paginator.ListBillEstimateInputCommitmentModificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillEstimateInputUsageModificationsPaginator(self: *Self, params: list_bill_estimate_input_usage_modifications.ListBillEstimateInputUsageModificationsInput) paginator.ListBillEstimateInputUsageModificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillEstimateLineItemsPaginator(self: *Self, params: list_bill_estimate_line_items.ListBillEstimateLineItemsInput) paginator.ListBillEstimateLineItemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillEstimatesPaginator(self: *Self, params: list_bill_estimates.ListBillEstimatesInput) paginator.ListBillEstimatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillScenarioCommitmentModificationsPaginator(self: *Self, params: list_bill_scenario_commitment_modifications.ListBillScenarioCommitmentModificationsInput) paginator.ListBillScenarioCommitmentModificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillScenarioUsageModificationsPaginator(self: *Self, params: list_bill_scenario_usage_modifications.ListBillScenarioUsageModificationsInput) paginator.ListBillScenarioUsageModificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillScenariosPaginator(self: *Self, params: list_bill_scenarios.ListBillScenariosInput) paginator.ListBillScenariosPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkloadEstimateUsagePaginator(self: *Self, params: list_workload_estimate_usage.ListWorkloadEstimateUsageInput) paginator.ListWorkloadEstimateUsagePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkloadEstimatesPaginator(self: *Self, params: list_workload_estimates.ListWorkloadEstimatesInput) paginator.ListWorkloadEstimatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

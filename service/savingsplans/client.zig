const aws = @import("aws");
const std = @import("std");

const create_savings_plan = @import("create_savings_plan.zig");
const delete_queued_savings_plan = @import("delete_queued_savings_plan.zig");
const describe_savings_plan_rates = @import("describe_savings_plan_rates.zig");
const describe_savings_plans = @import("describe_savings_plans.zig");
const describe_savings_plans_offering_rates = @import("describe_savings_plans_offering_rates.zig");
const describe_savings_plans_offerings = @import("describe_savings_plans_offerings.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const return_savings_plan = @import("return_savings_plan.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "savingsplans";

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

    /// Creates a Savings Plan.
    pub fn createSavingsPlan(self: *Self, allocator: std.mem.Allocator, input: create_savings_plan.CreateSavingsPlanInput, options: CallOptions) !create_savings_plan.CreateSavingsPlanOutput {
        return create_savings_plan.execute(self, allocator, input, options);
    }

    /// Deletes the queued purchase for the specified Savings Plan.
    pub fn deleteQueuedSavingsPlan(self: *Self, allocator: std.mem.Allocator, input: delete_queued_savings_plan.DeleteQueuedSavingsPlanInput, options: CallOptions) !delete_queued_savings_plan.DeleteQueuedSavingsPlanOutput {
        return delete_queued_savings_plan.execute(self, allocator, input, options);
    }

    /// Describes the rates for a specific, existing Savings Plan.
    pub fn describeSavingsPlanRates(self: *Self, allocator: std.mem.Allocator, input: describe_savings_plan_rates.DescribeSavingsPlanRatesInput, options: CallOptions) !describe_savings_plan_rates.DescribeSavingsPlanRatesOutput {
        return describe_savings_plan_rates.execute(self, allocator, input, options);
    }

    /// Describes the specified Savings Plans.
    pub fn describeSavingsPlans(self: *Self, allocator: std.mem.Allocator, input: describe_savings_plans.DescribeSavingsPlansInput, options: CallOptions) !describe_savings_plans.DescribeSavingsPlansOutput {
        return describe_savings_plans.execute(self, allocator, input, options);
    }

    /// Describes the offering rates for Savings Plans you might want to purchase.
    pub fn describeSavingsPlansOfferingRates(self: *Self, allocator: std.mem.Allocator, input: describe_savings_plans_offering_rates.DescribeSavingsPlansOfferingRatesInput, options: CallOptions) !describe_savings_plans_offering_rates.DescribeSavingsPlansOfferingRatesOutput {
        return describe_savings_plans_offering_rates.execute(self, allocator, input, options);
    }

    /// Describes the offerings for the specified Savings Plans.
    pub fn describeSavingsPlansOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_savings_plans_offerings.DescribeSavingsPlansOfferingsInput, options: CallOptions) !describe_savings_plans_offerings.DescribeSavingsPlansOfferingsOutput {
        return describe_savings_plans_offerings.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns the specified Savings Plan.
    pub fn returnSavingsPlan(self: *Self, allocator: std.mem.Allocator, input: return_savings_plan.ReturnSavingsPlanInput, options: CallOptions) !return_savings_plan.ReturnSavingsPlanOutput {
        return return_savings_plan.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }
};

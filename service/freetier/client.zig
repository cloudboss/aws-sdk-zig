const aws = @import("aws");
const std = @import("std");

const get_account_activity = @import("get_account_activity.zig");
const get_account_plan_state = @import("get_account_plan_state.zig");
const get_free_tier_usage = @import("get_free_tier_usage.zig");
const list_account_activities = @import("list_account_activities.zig");
const upgrade_account_plan = @import("upgrade_account_plan.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "FreeTier";

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

    /// Returns a specific activity record that is available to the customer.
    pub fn getAccountActivity(self: *Self, allocator: std.mem.Allocator, input: get_account_activity.GetAccountActivityInput, options: CallOptions) !get_account_activity.GetAccountActivityOutput {
        return get_account_activity.execute(self, allocator, input, options);
    }

    /// This returns all of the information related to the state of the account plan
    /// related to Free Tier.
    pub fn getAccountPlanState(self: *Self, allocator: std.mem.Allocator, input: get_account_plan_state.GetAccountPlanStateInput, options: CallOptions) !get_account_plan_state.GetAccountPlanStateOutput {
        return get_account_plan_state.execute(self, allocator, input, options);
    }

    /// Returns a list of all Free Tier usage objects that match your filters.
    pub fn getFreeTierUsage(self: *Self, allocator: std.mem.Allocator, input: get_free_tier_usage.GetFreeTierUsageInput, options: CallOptions) !get_free_tier_usage.GetFreeTierUsageOutput {
        return get_free_tier_usage.execute(self, allocator, input, options);
    }

    /// Returns a list of activities that are available. This operation supports
    /// pagination and filtering by status.
    pub fn listAccountActivities(self: *Self, allocator: std.mem.Allocator, input: list_account_activities.ListAccountActivitiesInput, options: CallOptions) !list_account_activities.ListAccountActivitiesOutput {
        return list_account_activities.execute(self, allocator, input, options);
    }

    /// The account plan type for the Amazon Web Services account.
    pub fn upgradeAccountPlan(self: *Self, allocator: std.mem.Allocator, input: upgrade_account_plan.UpgradeAccountPlanInput, options: CallOptions) !upgrade_account_plan.UpgradeAccountPlanOutput {
        return upgrade_account_plan.execute(self, allocator, input, options);
    }

    pub fn getFreeTierUsagePaginator(self: *Self, params: get_free_tier_usage.GetFreeTierUsageInput) paginator.GetFreeTierUsagePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountActivitiesPaginator(self: *Self, params: list_account_activities.ListAccountActivitiesInput) paginator.ListAccountActivitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

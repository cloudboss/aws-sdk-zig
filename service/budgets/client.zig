const aws = @import("aws");
const std = @import("std");

const create_budget = @import("create_budget.zig");
const create_budget_action = @import("create_budget_action.zig");
const create_notification = @import("create_notification.zig");
const create_subscriber = @import("create_subscriber.zig");
const delete_budget = @import("delete_budget.zig");
const delete_budget_action = @import("delete_budget_action.zig");
const delete_notification = @import("delete_notification.zig");
const delete_subscriber = @import("delete_subscriber.zig");
const describe_budget = @import("describe_budget.zig");
const describe_budget_action = @import("describe_budget_action.zig");
const describe_budget_action_histories = @import("describe_budget_action_histories.zig");
const describe_budget_actions_for_account = @import("describe_budget_actions_for_account.zig");
const describe_budget_actions_for_budget = @import("describe_budget_actions_for_budget.zig");
const describe_budget_notifications_for_account = @import("describe_budget_notifications_for_account.zig");
const describe_budget_performance_history = @import("describe_budget_performance_history.zig");
const describe_budgets = @import("describe_budgets.zig");
const describe_notifications_for_budget = @import("describe_notifications_for_budget.zig");
const describe_subscribers_for_notification = @import("describe_subscribers_for_notification.zig");
const execute_budget_action = @import("execute_budget_action.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_budget = @import("update_budget.zig");
const update_budget_action = @import("update_budget_action.zig");
const update_notification = @import("update_notification.zig");
const update_subscriber = @import("update_subscriber.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Budgets";

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

    /// Creates a budget and, if included, notifications and subscribers.
    ///
    /// Only one of `BudgetLimit` or `PlannedBudgetLimits` can be present in
    /// the syntax at one time. Use the syntax that matches your use case. The
    /// Request Syntax
    /// section shows the `BudgetLimit` syntax. For `PlannedBudgetLimits`,
    /// see the
    /// [Examples](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_budgets_CreateBudget.html#API_CreateBudget_Examples) section.
    ///
    /// Similarly, only one set of filter and metric selections can be present in
    /// the syntax
    /// at one time. Either `FilterExpression` and `Metrics` or
    /// `CostFilters` and `CostTypes`, not both or a different
    /// combination. We recommend using `FilterExpression` and `Metrics`
    /// as they provide more flexible and powerful filtering capabilities. The
    /// Request Syntax
    /// section shows the `FilterExpression`/`Metrics` syntax.
    pub fn createBudget(self: *Self, allocator: std.mem.Allocator, input: create_budget.CreateBudgetInput, options: create_budget.Options) !create_budget.CreateBudgetOutput {
        return create_budget.execute(self, allocator, input, options);
    }

    /// Creates a budget action.
    pub fn createBudgetAction(self: *Self, allocator: std.mem.Allocator, input: create_budget_action.CreateBudgetActionInput, options: create_budget_action.Options) !create_budget_action.CreateBudgetActionOutput {
        return create_budget_action.execute(self, allocator, input, options);
    }

    /// Creates a notification. You must create the budget before you create the
    /// associated notification.
    pub fn createNotification(self: *Self, allocator: std.mem.Allocator, input: create_notification.CreateNotificationInput, options: create_notification.Options) !create_notification.CreateNotificationOutput {
        return create_notification.execute(self, allocator, input, options);
    }

    /// Creates a subscriber. You must create the associated budget and notification
    /// before you create the subscriber.
    pub fn createSubscriber(self: *Self, allocator: std.mem.Allocator, input: create_subscriber.CreateSubscriberInput, options: create_subscriber.Options) !create_subscriber.CreateSubscriberOutput {
        return create_subscriber.execute(self, allocator, input, options);
    }

    /// Deletes a budget. You can delete your budget at any time.
    ///
    /// Deleting a budget also deletes the notifications and subscribers that are
    /// associated with that budget.
    pub fn deleteBudget(self: *Self, allocator: std.mem.Allocator, input: delete_budget.DeleteBudgetInput, options: delete_budget.Options) !delete_budget.DeleteBudgetOutput {
        return delete_budget.execute(self, allocator, input, options);
    }

    /// Deletes a budget action.
    pub fn deleteBudgetAction(self: *Self, allocator: std.mem.Allocator, input: delete_budget_action.DeleteBudgetActionInput, options: delete_budget_action.Options) !delete_budget_action.DeleteBudgetActionOutput {
        return delete_budget_action.execute(self, allocator, input, options);
    }

    /// Deletes a notification.
    ///
    /// Deleting a notification also deletes the subscribers that are associated
    /// with the notification.
    pub fn deleteNotification(self: *Self, allocator: std.mem.Allocator, input: delete_notification.DeleteNotificationInput, options: delete_notification.Options) !delete_notification.DeleteNotificationOutput {
        return delete_notification.execute(self, allocator, input, options);
    }

    /// Deletes a subscriber.
    ///
    /// Deleting the last subscriber to a notification also deletes the
    /// notification.
    pub fn deleteSubscriber(self: *Self, allocator: std.mem.Allocator, input: delete_subscriber.DeleteSubscriberInput, options: delete_subscriber.Options) !delete_subscriber.DeleteSubscriberOutput {
        return delete_subscriber.execute(self, allocator, input, options);
    }

    /// Describes a budget.
    ///
    /// The Request Syntax section shows the `BudgetLimit` syntax. For
    /// `PlannedBudgetLimits`, see the
    /// [Examples](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_budgets_DescribeBudget.html#API_DescribeBudget_Examples) section.
    pub fn describeBudget(self: *Self, allocator: std.mem.Allocator, input: describe_budget.DescribeBudgetInput, options: describe_budget.Options) !describe_budget.DescribeBudgetOutput {
        return describe_budget.execute(self, allocator, input, options);
    }

    /// Describes a budget action detail.
    pub fn describeBudgetAction(self: *Self, allocator: std.mem.Allocator, input: describe_budget_action.DescribeBudgetActionInput, options: describe_budget_action.Options) !describe_budget_action.DescribeBudgetActionOutput {
        return describe_budget_action.execute(self, allocator, input, options);
    }

    /// Describes a budget action history detail.
    pub fn describeBudgetActionHistories(self: *Self, allocator: std.mem.Allocator, input: describe_budget_action_histories.DescribeBudgetActionHistoriesInput, options: describe_budget_action_histories.Options) !describe_budget_action_histories.DescribeBudgetActionHistoriesOutput {
        return describe_budget_action_histories.execute(self, allocator, input, options);
    }

    /// Describes all of the budget actions for an account.
    pub fn describeBudgetActionsForAccount(self: *Self, allocator: std.mem.Allocator, input: describe_budget_actions_for_account.DescribeBudgetActionsForAccountInput, options: describe_budget_actions_for_account.Options) !describe_budget_actions_for_account.DescribeBudgetActionsForAccountOutput {
        return describe_budget_actions_for_account.execute(self, allocator, input, options);
    }

    /// Describes all of the budget actions for a budget.
    pub fn describeBudgetActionsForBudget(self: *Self, allocator: std.mem.Allocator, input: describe_budget_actions_for_budget.DescribeBudgetActionsForBudgetInput, options: describe_budget_actions_for_budget.Options) !describe_budget_actions_for_budget.DescribeBudgetActionsForBudgetOutput {
        return describe_budget_actions_for_budget.execute(self, allocator, input, options);
    }

    /// Lists the budget names and notifications that are associated with an
    /// account.
    pub fn describeBudgetNotificationsForAccount(self: *Self, allocator: std.mem.Allocator, input: describe_budget_notifications_for_account.DescribeBudgetNotificationsForAccountInput, options: describe_budget_notifications_for_account.Options) !describe_budget_notifications_for_account.DescribeBudgetNotificationsForAccountOutput {
        return describe_budget_notifications_for_account.execute(self, allocator, input, options);
    }

    /// Describes the history for `DAILY`, `MONTHLY`, and `QUARTERLY` budgets.
    /// Budget history isn't available for `ANNUAL` budgets.
    pub fn describeBudgetPerformanceHistory(self: *Self, allocator: std.mem.Allocator, input: describe_budget_performance_history.DescribeBudgetPerformanceHistoryInput, options: describe_budget_performance_history.Options) !describe_budget_performance_history.DescribeBudgetPerformanceHistoryOutput {
        return describe_budget_performance_history.execute(self, allocator, input, options);
    }

    /// Lists the budgets that are associated with an account.
    ///
    /// The Request Syntax section shows the `BudgetLimit` syntax. For
    /// `PlannedBudgetLimits`, see the
    /// [Examples](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_budgets_DescribeBudgets.html#API_DescribeBudgets_Examples) section.
    pub fn describeBudgets(self: *Self, allocator: std.mem.Allocator, input: describe_budgets.DescribeBudgetsInput, options: describe_budgets.Options) !describe_budgets.DescribeBudgetsOutput {
        return describe_budgets.execute(self, allocator, input, options);
    }

    /// Lists the notifications that are associated with a budget.
    pub fn describeNotificationsForBudget(self: *Self, allocator: std.mem.Allocator, input: describe_notifications_for_budget.DescribeNotificationsForBudgetInput, options: describe_notifications_for_budget.Options) !describe_notifications_for_budget.DescribeNotificationsForBudgetOutput {
        return describe_notifications_for_budget.execute(self, allocator, input, options);
    }

    /// Lists the subscribers that are associated with a notification.
    pub fn describeSubscribersForNotification(self: *Self, allocator: std.mem.Allocator, input: describe_subscribers_for_notification.DescribeSubscribersForNotificationInput, options: describe_subscribers_for_notification.Options) !describe_subscribers_for_notification.DescribeSubscribersForNotificationOutput {
        return describe_subscribers_for_notification.execute(self, allocator, input, options);
    }

    /// Executes a budget action.
    pub fn executeBudgetAction(self: *Self, allocator: std.mem.Allocator, input: execute_budget_action.ExecuteBudgetActionInput, options: execute_budget_action.Options) !execute_budget_action.ExecuteBudgetActionOutput {
        return execute_budget_action.execute(self, allocator, input, options);
    }

    /// Lists tags associated with a budget or budget action resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates tags for a budget or budget action resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes tags associated with a budget or budget action resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a budget. You can change every part of a budget except for the
    /// `budgetName` and the `calculatedSpend`. When you modify a budget, the
    /// `calculatedSpend` drops to zero until Amazon Web Services has new usage data
    /// to use for forecasting.
    ///
    /// Only one of `BudgetLimit` or `PlannedBudgetLimits` can be present in
    /// the syntax at one time. Use the syntax that matches your case. The Request
    /// Syntax
    /// section shows the `BudgetLimit` syntax. For `PlannedBudgetLimits`,
    /// see the
    /// [Examples](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_budgets_UpdateBudget.html#API_UpdateBudget_Examples) section.
    ///
    /// Similarly, only one set of filter and metric selections can be present in
    /// the syntax
    /// at one time. Either `FilterExpression` and `Metrics` or
    /// `CostFilters` and `CostTypes`, not both or a different
    /// combination. We recommend using `FilterExpression` and `Metrics`
    /// as they provide more flexible and powerful filtering capabilities. The
    /// Request Syntax
    /// section shows the `FilterExpression`/`Metrics` syntax.
    pub fn updateBudget(self: *Self, allocator: std.mem.Allocator, input: update_budget.UpdateBudgetInput, options: update_budget.Options) !update_budget.UpdateBudgetOutput {
        return update_budget.execute(self, allocator, input, options);
    }

    /// Updates a budget action.
    pub fn updateBudgetAction(self: *Self, allocator: std.mem.Allocator, input: update_budget_action.UpdateBudgetActionInput, options: update_budget_action.Options) !update_budget_action.UpdateBudgetActionOutput {
        return update_budget_action.execute(self, allocator, input, options);
    }

    /// Updates a notification.
    pub fn updateNotification(self: *Self, allocator: std.mem.Allocator, input: update_notification.UpdateNotificationInput, options: update_notification.Options) !update_notification.UpdateNotificationOutput {
        return update_notification.execute(self, allocator, input, options);
    }

    /// Updates a subscriber.
    pub fn updateSubscriber(self: *Self, allocator: std.mem.Allocator, input: update_subscriber.UpdateSubscriberInput, options: update_subscriber.Options) !update_subscriber.UpdateSubscriberOutput {
        return update_subscriber.execute(self, allocator, input, options);
    }

    pub fn describeBudgetActionHistoriesPaginator(self: *Self, params: describe_budget_action_histories.DescribeBudgetActionHistoriesInput) paginator.DescribeBudgetActionHistoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeBudgetActionsForAccountPaginator(self: *Self, params: describe_budget_actions_for_account.DescribeBudgetActionsForAccountInput) paginator.DescribeBudgetActionsForAccountPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeBudgetActionsForBudgetPaginator(self: *Self, params: describe_budget_actions_for_budget.DescribeBudgetActionsForBudgetInput) paginator.DescribeBudgetActionsForBudgetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeBudgetNotificationsForAccountPaginator(self: *Self, params: describe_budget_notifications_for_account.DescribeBudgetNotificationsForAccountInput) paginator.DescribeBudgetNotificationsForAccountPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeBudgetPerformanceHistoryPaginator(self: *Self, params: describe_budget_performance_history.DescribeBudgetPerformanceHistoryInput) paginator.DescribeBudgetPerformanceHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeBudgetsPaginator(self: *Self, params: describe_budgets.DescribeBudgetsInput) paginator.DescribeBudgetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNotificationsForBudgetPaginator(self: *Self, params: describe_notifications_for_budget.DescribeNotificationsForBudgetInput) paginator.DescribeNotificationsForBudgetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSubscribersForNotificationPaginator(self: *Self, params: describe_subscribers_for_notification.DescribeSubscribersForNotificationInput) paginator.DescribeSubscribersForNotificationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

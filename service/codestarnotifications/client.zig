const aws = @import("aws");
const std = @import("std");

const create_notification_rule = @import("create_notification_rule.zig");
const delete_notification_rule = @import("delete_notification_rule.zig");
const delete_target = @import("delete_target.zig");
const describe_notification_rule = @import("describe_notification_rule.zig");
const list_event_types = @import("list_event_types.zig");
const list_notification_rules = @import("list_notification_rules.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_targets = @import("list_targets.zig");
const subscribe_ = @import("subscribe.zig");
const tag_resource = @import("tag_resource.zig");
const unsubscribe_ = @import("unsubscribe.zig");
const untag_resource = @import("untag_resource.zig");
const update_notification_rule = @import("update_notification_rule.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "codestar notifications";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a notification rule for a resource. The rule specifies the events
    /// you want
    /// notifications about and the targets (such as Amazon Q Developer in chat
    /// applications topics or Amazon Q Developer in chat applications clients
    /// configured for Slack) where you want to receive
    /// them.
    pub fn createNotificationRule(self: *Self, allocator: std.mem.Allocator, input: create_notification_rule.CreateNotificationRuleInput, options: create_notification_rule.Options) !create_notification_rule.CreateNotificationRuleOutput {
        return create_notification_rule.execute(self, allocator, input, options);
    }

    /// Deletes a notification rule for a resource.
    pub fn deleteNotificationRule(self: *Self, allocator: std.mem.Allocator, input: delete_notification_rule.DeleteNotificationRuleInput, options: delete_notification_rule.Options) !delete_notification_rule.DeleteNotificationRuleOutput {
        return delete_notification_rule.execute(self, allocator, input, options);
    }

    /// Deletes a specified target for notifications.
    pub fn deleteTarget(self: *Self, allocator: std.mem.Allocator, input: delete_target.DeleteTargetInput, options: delete_target.Options) !delete_target.DeleteTargetOutput {
        return delete_target.execute(self, allocator, input, options);
    }

    /// Returns information about a specified notification rule.
    pub fn describeNotificationRule(self: *Self, allocator: std.mem.Allocator, input: describe_notification_rule.DescribeNotificationRuleInput, options: describe_notification_rule.Options) !describe_notification_rule.DescribeNotificationRuleOutput {
        return describe_notification_rule.execute(self, allocator, input, options);
    }

    /// Returns information about the event types available for configuring
    /// notifications.
    pub fn listEventTypes(self: *Self, allocator: std.mem.Allocator, input: list_event_types.ListEventTypesInput, options: list_event_types.Options) !list_event_types.ListEventTypesOutput {
        return list_event_types.execute(self, allocator, input, options);
    }

    /// Returns a list of the notification rules for an Amazon Web Services account.
    pub fn listNotificationRules(self: *Self, allocator: std.mem.Allocator, input: list_notification_rules.ListNotificationRulesInput, options: list_notification_rules.Options) !list_notification_rules.ListNotificationRulesOutput {
        return list_notification_rules.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags associated with a notification rule.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of the notification rule targets for an Amazon Web Services
    /// account.
    pub fn listTargets(self: *Self, allocator: std.mem.Allocator, input: list_targets.ListTargetsInput, options: list_targets.Options) !list_targets.ListTargetsOutput {
        return list_targets.execute(self, allocator, input, options);
    }

    /// Creates an association between a notification rule and an Amazon Q Developer
    /// in chat applications topic or Amazon Q Developer in chat applications client
    /// so that the
    /// associated target can receive notifications when the events described in the
    /// rule are
    /// triggered.
    pub fn subscribe(self: *Self, allocator: std.mem.Allocator, input: subscribe_.SubscribeInput, options: subscribe_.Options) !subscribe_.SubscribeOutput {
        return subscribe_.execute(self, allocator, input, options);
    }

    /// Associates a set of provided tags with a notification rule.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes an association between a notification rule and an Amazon Q Developer
    /// in chat applications topic so that
    /// subscribers to that topic stop receiving notifications when the events
    /// described in the
    /// rule are triggered.
    pub fn unsubscribe(self: *Self, allocator: std.mem.Allocator, input: unsubscribe_.UnsubscribeInput, options: unsubscribe_.Options) !unsubscribe_.UnsubscribeOutput {
        return unsubscribe_.execute(self, allocator, input, options);
    }

    /// Removes the association between one or more provided tags and a notification
    /// rule.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a notification rule for a resource. You can change the events that
    /// trigger the
    /// notification rule, the status of the rule, and the targets that receive the
    /// notifications.
    ///
    /// To add or remove tags for a notification rule, you must use TagResource and
    /// UntagResource.
    pub fn updateNotificationRule(self: *Self, allocator: std.mem.Allocator, input: update_notification_rule.UpdateNotificationRuleInput, options: update_notification_rule.Options) !update_notification_rule.UpdateNotificationRuleOutput {
        return update_notification_rule.execute(self, allocator, input, options);
    }

    pub fn listEventTypesPaginator(self: *Self, params: list_event_types.ListEventTypesInput) paginator.ListEventTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotificationRulesPaginator(self: *Self, params: list_notification_rules.ListNotificationRulesInput) paginator.ListNotificationRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTargetsPaginator(self: *Self, params: list_targets.ListTargetsInput) paginator.ListTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

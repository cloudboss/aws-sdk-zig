const aws = @import("aws");
const std = @import("std");

const create_rule = @import("create_rule.zig");
const delete_rule = @import("delete_rule.zig");
const get_rule = @import("get_rule.zig");
const list_rules = @import("list_rules.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const lock_rule = @import("lock_rule.zig");
const tag_resource = @import("tag_resource.zig");
const unlock_rule = @import("unlock_rule.zig");
const untag_resource = @import("untag_resource.zig");
const update_rule = @import("update_rule.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "rbin";

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

    /// Creates a Recycle Bin retention rule. You can create two types of retention
    /// rules:
    ///
    /// * **Tag-level retention rules** - These retention rules use
    /// resource tags to identify the resources to protect. For each retention rule,
    /// you specify one or
    /// more tag key and value pairs. Resources (of the specified type) that have at
    /// least one of these
    /// tag key and value pairs are automatically retained in the Recycle Bin upon
    /// deletion. Use this
    /// type of retention rule to protect specific resources in your account based
    /// on their tags.
    ///
    /// * **Region-level retention rules** - These retention rules,
    /// by default, apply to all of the resources (of the specified type) in the
    /// Region, even if the
    /// resources are not tagged. However, you can specify exclusion tags to exclude
    /// resources that have
    /// specific tags. Use this type of retention rule to protect all resources of a
    /// specific type in a
    /// Region.
    ///
    /// For more information, see [
    /// Create Recycle Bin retention
    /// rules](https://docs.aws.amazon.com/ebs/latest/userguide/recycle-bin.html) in
    /// the *Amazon EBS User Guide*.
    pub fn createRule(self: *Self, allocator: std.mem.Allocator, input: create_rule.CreateRuleInput, options: create_rule.Options) !create_rule.CreateRuleOutput {
        return create_rule.execute(self, allocator, input, options);
    }

    /// Deletes a Recycle Bin retention rule. For more information, see [
    /// Delete Recycle Bin retention
    /// rules](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recycle-bin-working-with-rules.html#recycle-bin-delete-rule) in the *Amazon Elastic Compute Cloud User Guide*.
    pub fn deleteRule(self: *Self, allocator: std.mem.Allocator, input: delete_rule.DeleteRuleInput, options: delete_rule.Options) !delete_rule.DeleteRuleOutput {
        return delete_rule.execute(self, allocator, input, options);
    }

    /// Gets information about a Recycle Bin retention rule.
    pub fn getRule(self: *Self, allocator: std.mem.Allocator, input: get_rule.GetRuleInput, options: get_rule.Options) !get_rule.GetRuleOutput {
        return get_rule.execute(self, allocator, input, options);
    }

    /// Lists the Recycle Bin retention rules in the Region.
    pub fn listRules(self: *Self, allocator: std.mem.Allocator, input: list_rules.ListRulesInput, options: list_rules.Options) !list_rules.ListRulesOutput {
        return list_rules.execute(self, allocator, input, options);
    }

    /// Lists the tags assigned to a retention rule.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Locks a Region-level retention rule. A locked retention rule can't be
    /// modified or
    /// deleted.
    ///
    /// You can't lock tag-level retention rules, or Region-level retention rules
    /// that
    /// have exclusion tags.
    pub fn lockRule(self: *Self, allocator: std.mem.Allocator, input: lock_rule.LockRuleInput, options: lock_rule.Options) !lock_rule.LockRuleOutput {
        return lock_rule.execute(self, allocator, input, options);
    }

    /// Assigns tags to the specified retention rule.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Unlocks a retention rule. After a retention rule is unlocked, it can be
    /// modified or deleted
    /// only after the unlock delay period expires.
    pub fn unlockRule(self: *Self, allocator: std.mem.Allocator, input: unlock_rule.UnlockRuleInput, options: unlock_rule.Options) !unlock_rule.UnlockRuleOutput {
        return unlock_rule.execute(self, allocator, input, options);
    }

    /// Unassigns a tag from a retention rule.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Recycle Bin retention rule. You can update a retention
    /// rule's description,
    /// resource tags, and retention period at any time after creation. You can't
    /// update a retention rule's
    /// resource type after creation. For more information, see [
    /// Update Recycle Bin retention
    /// rules](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recycle-bin-working-with-rules.html#recycle-bin-update-rule) in the *Amazon Elastic Compute Cloud User Guide*.
    pub fn updateRule(self: *Self, allocator: std.mem.Allocator, input: update_rule.UpdateRuleInput, options: update_rule.Options) !update_rule.UpdateRuleOutput {
        return update_rule.execute(self, allocator, input, options);
    }

    pub fn listRulesPaginator(self: *Self, params: list_rules.ListRulesInput) paginator.ListRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

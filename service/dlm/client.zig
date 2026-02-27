const aws = @import("aws");
const std = @import("std");

const create_lifecycle_policy = @import("create_lifecycle_policy.zig");
const delete_lifecycle_policy = @import("delete_lifecycle_policy.zig");
const get_lifecycle_policies = @import("get_lifecycle_policies.zig");
const get_lifecycle_policy = @import("get_lifecycle_policy.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_lifecycle_policy = @import("update_lifecycle_policy.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DLM";

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

    /// Creates an Amazon Data Lifecycle Manager lifecycle policy. Amazon Data
    /// Lifecycle Manager supports the following policy types:
    ///
    /// * Custom EBS snapshot policy
    ///
    /// * Custom EBS-backed AMI policy
    ///
    /// * Cross-account copy event policy
    ///
    /// * Default policy for EBS snapshots
    ///
    /// * Default policy for EBS-backed AMIs
    ///
    /// For more information, see [
    /// Default policies vs custom
    /// policies](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/policy-differences.html).
    ///
    /// If you create a default policy, you can specify the request parameters
    /// either in
    /// the request body, or in the PolicyDetails request structure, but not both.
    pub fn createLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: create_lifecycle_policy.CreateLifecyclePolicyInput, options: create_lifecycle_policy.Options) !create_lifecycle_policy.CreateLifecyclePolicyOutput {
        return create_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified lifecycle policy and halts the automated operations
    /// that the
    /// policy specified.
    ///
    /// For more information about deleting a policy, see [Delete lifecycle
    /// policies](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/view-modify-delete.html#delete).
    pub fn deleteLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_lifecycle_policy.DeleteLifecyclePolicyInput, options: delete_lifecycle_policy.Options) !delete_lifecycle_policy.DeleteLifecyclePolicyOutput {
        return delete_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Gets summary information about all or the specified data lifecycle policies.
    ///
    /// To get complete information about a policy, use
    /// [GetLifecyclePolicy](https://docs.aws.amazon.com/dlm/latest/APIReference/API_GetLifecyclePolicy.html).
    pub fn getLifecyclePolicies(self: *Self, allocator: std.mem.Allocator, input: get_lifecycle_policies.GetLifecyclePoliciesInput, options: get_lifecycle_policies.Options) !get_lifecycle_policies.GetLifecyclePoliciesOutput {
        return get_lifecycle_policies.execute(self, allocator, input, options);
    }

    /// Gets detailed information about the specified lifecycle policy.
    pub fn getLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: get_lifecycle_policy.GetLifecyclePolicyInput, options: get_lifecycle_policy.Options) !get_lifecycle_policy.GetLifecyclePolicyOutput {
        return get_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified lifecycle policy.
    ///
    /// For more information about updating a policy, see [Modify lifecycle
    /// policies](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/view-modify-delete.html#modify).
    pub fn updateLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: update_lifecycle_policy.UpdateLifecyclePolicyInput, options: update_lifecycle_policy.Options) !update_lifecycle_policy.UpdateLifecyclePolicyOutput {
        return update_lifecycle_policy.execute(self, allocator, input, options);
    }
};

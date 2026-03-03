const aws = @import("aws");
const std = @import("std");

const create_environment_ec2 = @import("create_environment_ec2.zig");
const create_environment_membership = @import("create_environment_membership.zig");
const delete_environment = @import("delete_environment.zig");
const delete_environment_membership = @import("delete_environment_membership.zig");
const describe_environment_memberships = @import("describe_environment_memberships.zig");
const describe_environment_status = @import("describe_environment_status.zig");
const describe_environments = @import("describe_environments.zig");
const list_environments = @import("list_environments.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_environment = @import("update_environment.zig");
const update_environment_membership = @import("update_environment_membership.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Cloud9";

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

    /// Creates an Cloud9 development environment, launches an Amazon Elastic
    /// Compute Cloud (Amazon EC2) instance, and
    /// then connects from the instance to the environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn createEnvironmentEc2(self: *Self, allocator: std.mem.Allocator, input: create_environment_ec2.CreateEnvironmentEC2Input, options: create_environment_ec2.Options) !create_environment_ec2.CreateEnvironmentEC2Output {
        return create_environment_ec2.execute(self, allocator, input, options);
    }

    /// Adds an environment member to an Cloud9 development environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn createEnvironmentMembership(self: *Self, allocator: std.mem.Allocator, input: create_environment_membership.CreateEnvironmentMembershipInput, options: create_environment_membership.Options) !create_environment_membership.CreateEnvironmentMembershipOutput {
        return create_environment_membership.execute(self, allocator, input, options);
    }

    /// Deletes an Cloud9 development environment. If an Amazon EC2 instance is
    /// connected to the
    /// environment, also terminates the instance.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: delete_environment.Options) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// Deletes an environment member from a development environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn deleteEnvironmentMembership(self: *Self, allocator: std.mem.Allocator, input: delete_environment_membership.DeleteEnvironmentMembershipInput, options: delete_environment_membership.Options) !delete_environment_membership.DeleteEnvironmentMembershipOutput {
        return delete_environment_membership.execute(self, allocator, input, options);
    }

    /// Gets information about environment members for an Cloud9 development
    /// environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn describeEnvironmentMemberships(self: *Self, allocator: std.mem.Allocator, input: describe_environment_memberships.DescribeEnvironmentMembershipsInput, options: describe_environment_memberships.Options) !describe_environment_memberships.DescribeEnvironmentMembershipsOutput {
        return describe_environment_memberships.execute(self, allocator, input, options);
    }

    /// Gets status information for an Cloud9 development environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn describeEnvironmentStatus(self: *Self, allocator: std.mem.Allocator, input: describe_environment_status.DescribeEnvironmentStatusInput, options: describe_environment_status.Options) !describe_environment_status.DescribeEnvironmentStatusOutput {
        return describe_environment_status.execute(self, allocator, input, options);
    }

    /// Gets information about Cloud9 development environments.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn describeEnvironments(self: *Self, allocator: std.mem.Allocator, input: describe_environments.DescribeEnvironmentsInput, options: describe_environments.Options) !describe_environments.DescribeEnvironmentsOutput {
        return describe_environments.execute(self, allocator, input, options);
    }

    /// Gets a list of Cloud9 development environment identifiers.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: list_environments.Options) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// Gets a list of the tags associated with an Cloud9 development environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds tags to an Cloud9 development environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    ///
    /// Tags that you add to an Cloud9 environment by using this method will NOT be
    /// automatically propagated to underlying resources.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from an Cloud9 development environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Changes the settings of an existing Cloud9 development environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn updateEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_environment.UpdateEnvironmentInput, options: update_environment.Options) !update_environment.UpdateEnvironmentOutput {
        return update_environment.execute(self, allocator, input, options);
    }

    /// Changes the settings of an existing environment member for an Cloud9
    /// development
    /// environment.
    ///
    /// Cloud9 is no longer available to new customers. Existing customers of
    /// Cloud9 can continue to use the service as normal.
    /// [Learn
    /// more"](http://aws.amazon.com/blogs/devops/how-to-migrate-from-aws-cloud9-to-aws-ide-toolkits-or-aws-cloudshell/)
    pub fn updateEnvironmentMembership(self: *Self, allocator: std.mem.Allocator, input: update_environment_membership.UpdateEnvironmentMembershipInput, options: update_environment_membership.Options) !update_environment_membership.UpdateEnvironmentMembershipOutput {
        return update_environment_membership.execute(self, allocator, input, options);
    }

    pub fn describeEnvironmentMembershipsPaginator(self: *Self, params: describe_environment_memberships.DescribeEnvironmentMembershipsInput) paginator.DescribeEnvironmentMembershipsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentsPaginator(self: *Self, params: list_environments.ListEnvironmentsInput) paginator.ListEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

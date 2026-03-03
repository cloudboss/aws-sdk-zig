const aws = @import("aws");
const std = @import("std");

const create_application = @import("create_application.zig");
const create_application_version = @import("create_application_version.zig");
const create_cloud_formation_change_set = @import("create_cloud_formation_change_set.zig");
const create_cloud_formation_template = @import("create_cloud_formation_template.zig");
const delete_application = @import("delete_application.zig");
const get_application = @import("get_application.zig");
const get_application_policy = @import("get_application_policy.zig");
const get_cloud_formation_template = @import("get_cloud_formation_template.zig");
const list_application_dependencies = @import("list_application_dependencies.zig");
const list_application_versions = @import("list_application_versions.zig");
const list_applications = @import("list_applications.zig");
const put_application_policy = @import("put_application_policy.zig");
const unshare_application = @import("unshare_application.zig");
const update_application = @import("update_application.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ServerlessApplicationRepository";

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

    /// Creates an application, optionally including an AWS SAM file to create the
    /// first application version in the same call.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: CallOptions) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates an application version.
    pub fn createApplicationVersion(self: *Self, allocator: std.mem.Allocator, input: create_application_version.CreateApplicationVersionInput, options: CallOptions) !create_application_version.CreateApplicationVersionOutput {
        return create_application_version.execute(self, allocator, input, options);
    }

    /// Creates an AWS CloudFormation change set for the given application.
    pub fn createCloudFormationChangeSet(self: *Self, allocator: std.mem.Allocator, input: create_cloud_formation_change_set.CreateCloudFormationChangeSetInput, options: CallOptions) !create_cloud_formation_change_set.CreateCloudFormationChangeSetOutput {
        return create_cloud_formation_change_set.execute(self, allocator, input, options);
    }

    /// Creates an AWS CloudFormation template.
    pub fn createCloudFormationTemplate(self: *Self, allocator: std.mem.Allocator, input: create_cloud_formation_template.CreateCloudFormationTemplateInput, options: CallOptions) !create_cloud_formation_template.CreateCloudFormationTemplateOutput {
        return create_cloud_formation_template.execute(self, allocator, input, options);
    }

    /// Deletes the specified application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: CallOptions) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Gets the specified application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: CallOptions) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Retrieves the policy for the application.
    pub fn getApplicationPolicy(self: *Self, allocator: std.mem.Allocator, input: get_application_policy.GetApplicationPolicyInput, options: CallOptions) !get_application_policy.GetApplicationPolicyOutput {
        return get_application_policy.execute(self, allocator, input, options);
    }

    /// Gets the specified AWS CloudFormation template.
    pub fn getCloudFormationTemplate(self: *Self, allocator: std.mem.Allocator, input: get_cloud_formation_template.GetCloudFormationTemplateInput, options: CallOptions) !get_cloud_formation_template.GetCloudFormationTemplateOutput {
        return get_cloud_formation_template.execute(self, allocator, input, options);
    }

    /// Retrieves the list of applications nested in the containing application.
    pub fn listApplicationDependencies(self: *Self, allocator: std.mem.Allocator, input: list_application_dependencies.ListApplicationDependenciesInput, options: CallOptions) !list_application_dependencies.ListApplicationDependenciesOutput {
        return list_application_dependencies.execute(self, allocator, input, options);
    }

    /// Lists versions for the specified application.
    pub fn listApplicationVersions(self: *Self, allocator: std.mem.Allocator, input: list_application_versions.ListApplicationVersionsInput, options: CallOptions) !list_application_versions.ListApplicationVersionsOutput {
        return list_application_versions.execute(self, allocator, input, options);
    }

    /// Lists applications owned by the requester.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Sets the permission policy for an application. For the list of actions
    /// supported for this operation, see
    /// [Application
    /// Permissions](https://docs.aws.amazon.com/serverlessrepo/latest/devguide/access-control-resource-based.html#application-permissions)
    /// .
    pub fn putApplicationPolicy(self: *Self, allocator: std.mem.Allocator, input: put_application_policy.PutApplicationPolicyInput, options: CallOptions) !put_application_policy.PutApplicationPolicyOutput {
        return put_application_policy.execute(self, allocator, input, options);
    }

    /// Unshares an application from an AWS Organization.
    ///
    /// This operation can be called only from the organization's master account.
    pub fn unshareApplication(self: *Self, allocator: std.mem.Allocator, input: unshare_application.UnshareApplicationInput, options: CallOptions) !unshare_application.UnshareApplicationOutput {
        return unshare_application.execute(self, allocator, input, options);
    }

    /// Updates the specified application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: CallOptions) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    pub fn listApplicationDependenciesPaginator(self: *Self, params: list_application_dependencies.ListApplicationDependenciesInput) paginator.ListApplicationDependenciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationVersionsPaginator(self: *Self, params: list_application_versions.ListApplicationVersionsInput) paginator.ListApplicationVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

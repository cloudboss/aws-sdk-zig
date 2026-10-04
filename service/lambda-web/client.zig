const aws = @import("aws");
const std = @import("std");

const create_web_function = @import("create_web_function.zig");
const create_web_function_endpoint = @import("create_web_function_endpoint.zig");
const create_web_function_revision = @import("create_web_function_revision.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_web_function = @import("delete_web_function.zig");
const delete_web_function_endpoint = @import("delete_web_function_endpoint.zig");
const delete_web_function_revision = @import("delete_web_function_revision.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_web_account_settings = @import("get_web_account_settings.zig");
const get_web_function = @import("get_web_function.zig");
const get_web_function_endpoint = @import("get_web_function_endpoint.zig");
const get_web_function_revision = @import("get_web_function_revision.zig");
const list_tags = @import("list_tags.zig");
const list_web_function_endpoints = @import("list_web_function_endpoints.zig");
const list_web_function_revisions = @import("list_web_function_revisions.zig");
const list_web_functions = @import("list_web_functions.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_web_function_endpoint = @import("update_web_function_endpoint.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Lambda Web";

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

    /// Creates a web function with an initial revision and endpoint. To create a
    /// web function, you provide the function name, revision configuration (code
    /// and service settings), and endpoint configuration.
    ///
    /// To use this operation, you must have the `CreateWebFunction` permission on
    /// the web function. You don't need separate permissions for the initial
    /// revision or endpoint.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn createWebFunction(self: *Self, allocator: std.mem.Allocator, input: create_web_function.CreateWebFunctionInput, options: CallOptions) !create_web_function.CreateWebFunctionOutput {
        return create_web_function.execute(self, allocator, input, options);
    }

    /// Creates an endpoint for a web function. An endpoint exposes the web function
    /// over HTTPS and routes traffic to one or more revisions.
    ///
    /// To use this operation, you must have the `CreateWebFunctionEndpoint`
    /// permission on the web function, not on the endpoint being created.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn createWebFunctionEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_web_function_endpoint.CreateWebFunctionEndpointInput, options: CallOptions) !create_web_function_endpoint.CreateWebFunctionEndpointOutput {
        return create_web_function_endpoint.execute(self, allocator, input, options);
    }

    /// Creates an immutable revision for a web function. A revision represents a
    /// specific version of the function code and configuration.
    ///
    /// To use this operation, you must have the `CreateWebFunctionRevision`
    /// permission on the web function, not on the revision being created.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn createWebFunctionRevision(self: *Self, allocator: std.mem.Allocator, input: create_web_function_revision.CreateWebFunctionRevisionInput, options: CallOptions) !create_web_function_revision.CreateWebFunctionRevisionOutput {
        return create_web_function_revision.execute(self, allocator, input, options);
    }

    /// Removes the resource-based policy from a web function.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a web function and all of its associated revisions and endpoints.
    ///
    /// To use this operation, you must have the `DeleteWebFunction` permission on
    /// the web function. You don't need the `DeleteWebFunctionRevision` or
    /// `DeleteWebFunctionEndpoint` permission.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn deleteWebFunction(self: *Self, allocator: std.mem.Allocator, input: delete_web_function.DeleteWebFunctionInput, options: CallOptions) !delete_web_function.DeleteWebFunctionOutput {
        return delete_web_function.execute(self, allocator, input, options);
    }

    /// Deletes a web function endpoint.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn deleteWebFunctionEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_web_function_endpoint.DeleteWebFunctionEndpointInput, options: CallOptions) !delete_web_function_endpoint.DeleteWebFunctionEndpointOutput {
        return delete_web_function_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a web function revision. You cannot delete a revision that is
    /// currently serving traffic on an endpoint.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn deleteWebFunctionRevision(self: *Self, allocator: std.mem.Allocator, input: delete_web_function_revision.DeleteWebFunctionRevisionInput, options: CallOptions) !delete_web_function_revision.DeleteWebFunctionRevisionOutput {
        return delete_web_function_revision.execute(self, allocator, input, options);
    }

    /// Retrieves the resource-based policy attached to a web function.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Retrieves details about your AWS Lambda Web Functions account settings for
    /// the current AWS Region, including the quotas that apply to web functions and
    /// your current usage.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn getWebAccountSettings(self: *Self, allocator: std.mem.Allocator, input: get_web_account_settings.GetWebAccountSettingsInput, options: CallOptions) !get_web_account_settings.GetWebAccountSettingsOutput {
        return get_web_account_settings.execute(self, allocator, input, options);
    }

    /// Retrieves details about a web function, including its current state and
    /// configuration.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn getWebFunction(self: *Self, allocator: std.mem.Allocator, input: get_web_function.GetWebFunctionInput, options: CallOptions) !get_web_function.GetWebFunctionOutput {
        return get_web_function.execute(self, allocator, input, options);
    }

    /// Retrieves details about a web function endpoint, including its current
    /// state, configuration, and domain name.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn getWebFunctionEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_web_function_endpoint.GetWebFunctionEndpointInput, options: CallOptions) !get_web_function_endpoint.GetWebFunctionEndpointOutput {
        return get_web_function_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves details about a web function revision, including its state and
    /// configuration.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn getWebFunctionRevision(self: *Self, allocator: std.mem.Allocator, input: get_web_function_revision.GetWebFunctionRevisionInput, options: CallOptions) !get_web_function_revision.GetWebFunctionRevisionOutput {
        return get_web_function_revision.execute(self, allocator, input, options);
    }

    /// Returns a list of tags applied to a web function.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: CallOptions) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Lists endpoints for a web function. We recommend using pagination to ensure
    /// that the operation returns quickly and successfully.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn listWebFunctionEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_web_function_endpoints.ListWebFunctionEndpointsInput, options: CallOptions) !list_web_function_endpoints.ListWebFunctionEndpointsOutput {
        return list_web_function_endpoints.execute(self, allocator, input, options);
    }

    /// Lists revisions for a web function. We recommend using pagination to ensure
    /// that the operation returns quickly and successfully.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn listWebFunctionRevisions(self: *Self, allocator: std.mem.Allocator, input: list_web_function_revisions.ListWebFunctionRevisionsInput, options: CallOptions) !list_web_function_revisions.ListWebFunctionRevisionsOutput {
        return list_web_function_revisions.execute(self, allocator, input, options);
    }

    /// Lists web functions in your account. We recommend using pagination to ensure
    /// that the operation returns quickly and successfully.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn listWebFunctions(self: *Self, allocator: std.mem.Allocator, input: list_web_functions.ListWebFunctionsInput, options: CallOptions) !list_web_functions.ListWebFunctionsOutput {
        return list_web_functions.execute(self, allocator, input, options);
    }

    /// Adds or updates a resource-based policy on a web function. A resource-based
    /// policy grants permissions to other AWS accounts or services to perform
    /// actions on the web function.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Adds tags to a web function. If a tag key already exists, the existing value
    /// is overwritten with the new value.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a web function.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a web function endpoint. You can modify the
    /// authorization type, auto-deployment mode, revision weights, scaling, and
    /// throttling settings.
    ///
    /// This API is experimental and for internal AWS use only. It is not yet
    /// available to external customers.
    pub fn updateWebFunctionEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_web_function_endpoint.UpdateWebFunctionEndpointInput, options: CallOptions) !update_web_function_endpoint.UpdateWebFunctionEndpointOutput {
        return update_web_function_endpoint.execute(self, allocator, input, options);
    }

    pub fn listWebFunctionEndpointsPaginator(self: *Self, params: list_web_function_endpoints.ListWebFunctionEndpointsInput) paginator.ListWebFunctionEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWebFunctionRevisionsPaginator(self: *Self, params: list_web_function_revisions.ListWebFunctionRevisionsInput) paginator.ListWebFunctionRevisionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWebFunctionsPaginator(self: *Self, params: list_web_functions.ListWebFunctionsInput) paginator.ListWebFunctionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilWebFunctionActive(self: *Self, params: get_web_function.GetWebFunctionInput) aws.waiter.WaiterError!void {
        var w = waiters.WebFunctionActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWebFunctionDeleted(self: *Self, params: get_web_function.GetWebFunctionInput) aws.waiter.WaiterError!void {
        var w = waiters.WebFunctionDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWebFunctionEndpointActive(self: *Self, params: get_web_function_endpoint.GetWebFunctionEndpointInput) aws.waiter.WaiterError!void {
        var w = waiters.WebFunctionEndpointActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWebFunctionEndpointDeleted(self: *Self, params: get_web_function_endpoint.GetWebFunctionEndpointInput) aws.waiter.WaiterError!void {
        var w = waiters.WebFunctionEndpointDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWebFunctionEndpointUpdated(self: *Self, params: get_web_function_endpoint.GetWebFunctionEndpointInput) aws.waiter.WaiterError!void {
        var w = waiters.WebFunctionEndpointUpdatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWebFunctionRevisionActive(self: *Self, params: get_web_function_revision.GetWebFunctionRevisionInput) aws.waiter.WaiterError!void {
        var w = waiters.WebFunctionRevisionActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }
};

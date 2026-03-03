const aws = @import("aws");
const std = @import("std");

const cancel_resource_request = @import("cancel_resource_request.zig");
const create_resource = @import("create_resource.zig");
const delete_resource = @import("delete_resource.zig");
const get_resource = @import("get_resource.zig");
const get_resource_request_status = @import("get_resource_request_status.zig");
const list_resource_requests = @import("list_resource_requests.zig");
const list_resources = @import("list_resources.zig");
const update_resource = @import("update_resource.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudControl";

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

    /// Cancels the specified resource operation request. For more information, see
    /// [Canceling resource operation
    /// requests](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-manage-requests.html#resource-operations-manage-requests-cancel) in the
    /// *Amazon Web Services Cloud Control API User Guide*.
    ///
    /// Only resource operations requests with a status of `PENDING` or
    /// `IN_PROGRESS` can be canceled.
    pub fn cancelResourceRequest(self: *Self, allocator: std.mem.Allocator, input: cancel_resource_request.CancelResourceRequestInput, options: cancel_resource_request.Options) !cancel_resource_request.CancelResourceRequestOutput {
        return cancel_resource_request.execute(self, allocator, input, options);
    }

    /// Creates the specified resource. For more information, see [Creating a
    /// resource](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-create.html) in the *Amazon Web Services Cloud Control API User Guide*.
    ///
    /// After you have initiated a resource creation request, you can monitor the
    /// progress of your
    /// request by calling
    /// [GetResourceRequestStatus](https://docs.aws.amazon.com/cloudcontrolapi/latest/APIReference/API_GetResourceRequestStatus.html) using the `RequestToken` of the
    /// `ProgressEvent` type returned by `CreateResource`.
    pub fn createResource(self: *Self, allocator: std.mem.Allocator, input: create_resource.CreateResourceInput, options: create_resource.Options) !create_resource.CreateResourceOutput {
        return create_resource.execute(self, allocator, input, options);
    }

    /// Deletes the specified resource. For details, see [Deleting a
    /// resource](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-delete.html) in the *Amazon Web Services Cloud Control API User Guide*.
    ///
    /// After you have initiated a resource deletion request, you can monitor the
    /// progress of your
    /// request by calling
    /// [GetResourceRequestStatus](https://docs.aws.amazon.com/cloudcontrolapi/latest/APIReference/API_GetResourceRequestStatus.html) using the `RequestToken` of the
    /// `ProgressEvent` returned by `DeleteResource`.
    pub fn deleteResource(self: *Self, allocator: std.mem.Allocator, input: delete_resource.DeleteResourceInput, options: delete_resource.Options) !delete_resource.DeleteResourceOutput {
        return delete_resource.execute(self, allocator, input, options);
    }

    /// Returns information about the current state of the specified resource. For
    /// details, see
    /// [Reading a resource's current
    /// state](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-read.html).
    ///
    /// You can use this action to return information about an existing resource in
    /// your account
    /// and Amazon Web Services Region, whether those resources were provisioned
    /// using Cloud Control API.
    pub fn getResource(self: *Self, allocator: std.mem.Allocator, input: get_resource.GetResourceInput, options: get_resource.Options) !get_resource.GetResourceOutput {
        return get_resource.execute(self, allocator, input, options);
    }

    /// Returns the current status of a resource operation request. For more
    /// information, see
    /// [Tracking the progress of resource operation
    /// requests](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-manage-requests.html#resource-operations-manage-requests-track) in the
    /// *Amazon Web Services Cloud Control API User Guide*.
    pub fn getResourceRequestStatus(self: *Self, allocator: std.mem.Allocator, input: get_resource_request_status.GetResourceRequestStatusInput, options: get_resource_request_status.Options) !get_resource_request_status.GetResourceRequestStatusOutput {
        return get_resource_request_status.execute(self, allocator, input, options);
    }

    /// Returns existing resource operation requests. This includes requests of all
    /// status types.
    /// For more information, see [Listing active resource operation
    /// requests](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-manage-requests.html#resource-operations-manage-requests-list) in the
    /// *Amazon Web Services Cloud Control API User Guide*.
    ///
    /// Resource operation requests expire after 7 days.
    pub fn listResourceRequests(self: *Self, allocator: std.mem.Allocator, input: list_resource_requests.ListResourceRequestsInput, options: list_resource_requests.Options) !list_resource_requests.ListResourceRequestsOutput {
        return list_resource_requests.execute(self, allocator, input, options);
    }

    /// Returns information about the specified resources. For more information, see
    /// [Discovering
    /// resources](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-list.html) in the *Amazon Web Services Cloud Control API User Guide*.
    ///
    /// You can use this action to return information about existing resources in
    /// your account and
    /// Amazon Web Services Region, whether those resources were provisioned using
    /// Cloud Control API.
    pub fn listResources(self: *Self, allocator: std.mem.Allocator, input: list_resources.ListResourcesInput, options: list_resources.Options) !list_resources.ListResourcesOutput {
        return list_resources.execute(self, allocator, input, options);
    }

    /// Updates the specified property values in the resource.
    ///
    /// You specify your resource property updates as a list of patch operations
    /// contained in a
    /// JSON patch document that adheres to the [
    /// *RFC 6902 - JavaScript Object
    /// Notation (JSON) Patch*
    /// ](https://datatracker.ietf.org/doc/html/rfc6902) standard.
    ///
    /// For details on how Cloud Control API performs resource update operations,
    /// see [Updating a
    /// resource](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-update.html) in the *Amazon Web Services Cloud Control API User Guide*.
    ///
    /// After you have initiated a resource update request, you can monitor the
    /// progress of your
    /// request by calling
    /// [GetResourceRequestStatus](https://docs.aws.amazon.com/cloudcontrolapi/latest/APIReference/API_GetResourceRequestStatus.html) using the `RequestToken` of the
    /// `ProgressEvent` returned by `UpdateResource`.
    ///
    /// For more information about the properties of a specific resource, refer to
    /// the related
    /// topic for the resource in the [Resource and property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *CloudFormation Users Guide*.
    pub fn updateResource(self: *Self, allocator: std.mem.Allocator, input: update_resource.UpdateResourceInput, options: update_resource.Options) !update_resource.UpdateResourceOutput {
        return update_resource.execute(self, allocator, input, options);
    }

    pub fn listResourceRequestsPaginator(self: *Self, params: list_resource_requests.ListResourceRequestsInput) paginator.ListResourceRequestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourcesPaginator(self: *Self, params: list_resources.ListResourcesInput) paginator.ListResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilResourceRequestSuccess(self: *Self, params: get_resource_request_status.GetResourceRequestStatusInput) aws.waiter.WaiterError!void {
        var w = waiters.ResourceRequestSuccessWaiter{ .client = self, .params = params };
        return w.wait();
    }
};

const aws = @import("aws");
const std = @import("std");

const create_application = @import("create_application.zig");
const create_entitlement = @import("create_entitlement.zig");
const delete_application = @import("delete_application.zig");
const delete_entitlement = @import("delete_entitlement.zig");
const get_application = @import("get_application.zig");
const get_entitlement = @import("get_entitlement.zig");
const list_applications = @import("list_applications.zig");
const list_entitlements = @import("list_entitlements.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Account Access";

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

    /// Creates an account access manager instance and its Amazon Web Services
    /// account access application in the associated IAM Identity Center instance.
    /// This operation is idempotent; calling it multiple times with the same
    /// parameters returns the existing application.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: CallOptions) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates an entitlement (assignment) in account access manager. An
    /// entitlement (assignment) grants a principal (IAM Identity Center user or
    /// group) permission to assume a specified IAM role in an Amazon Web Services
    /// account. This operation is idempotent.
    pub fn createEntitlement(self: *Self, allocator: std.mem.Allocator, input: create_entitlement.CreateEntitlementInput, options: CallOptions) !create_entitlement.CreateEntitlementOutput {
        return create_entitlement.execute(self, allocator, input, options);
    }

    /// Deletes an account access manager application. This operation is idempotent;
    /// deleting an application that has already been deleted does not return an
    /// error.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: CallOptions) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes an entitlement from an account access manager application. This
    /// operation is idempotent; deleting an entitlement that has already been
    /// deleted does not return an error.
    pub fn deleteEntitlement(self: *Self, allocator: std.mem.Allocator, input: delete_entitlement.DeleteEntitlementInput, options: CallOptions) !delete_entitlement.DeleteEntitlementOutput {
        return delete_entitlement.execute(self, allocator, input, options);
    }

    /// Retrieves details about an account access manager application, including its
    /// status, identity source, and tags.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: CallOptions) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific entitlement for an account access manager
    /// application, including the principal, IAM role, and target account.
    pub fn getEntitlement(self: *Self, allocator: std.mem.Allocator, input: get_entitlement.GetEntitlementInput, options: CallOptions) !get_entitlement.GetEntitlementOutput {
        return get_entitlement.execute(self, allocator, input, options);
    }

    /// Lists the account access manager applications in your account. Use
    /// pagination to ensure that the operation returns quickly and successfully.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists the entitlements for a specified account access manager application.
    /// You can filter results by principal, IAM role, or account. Use pagination to
    /// ensure that the operation returns quickly and successfully.
    pub fn listEntitlements(self: *Self, allocator: std.mem.Allocator, input: list_entitlements.ListEntitlementsInput, options: CallOptions) !list_entitlements.ListEntitlementsOutput {
        return list_entitlements.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with an account access manager resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds tags to an account access manager resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from an account access manager resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEntitlementsPaginator(self: *Self, params: list_entitlements.ListEntitlementsInput) paginator.ListEntitlementsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilApplicationActive(self: *Self, params: get_application.GetApplicationInput) aws.waiter.WaiterError!void {
        var w = waiters.ApplicationActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }
};

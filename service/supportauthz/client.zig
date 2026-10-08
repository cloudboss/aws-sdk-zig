const aws = @import("aws");
const std = @import("std");

const create_support_permit = @import("create_support_permit.zig");
const delete_support_permit = @import("delete_support_permit.zig");
const get_action = @import("get_action.zig");
const get_support_permit = @import("get_support_permit.zig");
const list_actions = @import("list_actions.zig");
const list_support_permit_requests = @import("list_support_permit_requests.zig");
const list_support_permits = @import("list_support_permits.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reject_support_permit_request = @import("reject_support_permit_request.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "SupportAuthZ";

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

    /// Creates a support permit that authorizes an AWS support operator to perform
    /// specified actions on specified resources. The permit is cryptographically
    /// signed using a customer-managed AWS KMS key (ECC_NIST_P384, SIGN_VERIFY) to
    /// ensure non-repudiation.
    pub fn createSupportPermit(self: *Self, allocator: std.mem.Allocator, input: create_support_permit.CreateSupportPermitInput, options: CallOptions) !create_support_permit.CreateSupportPermitOutput {
        return create_support_permit.execute(self, allocator, input, options);
    }

    /// Deletes a support permit, revoking the authorization previously granted to
    /// the AWS support operator.
    pub fn deleteSupportPermit(self: *Self, allocator: std.mem.Allocator, input: delete_support_permit.DeleteSupportPermitInput, options: CallOptions) !delete_support_permit.DeleteSupportPermitOutput {
        return delete_support_permit.execute(self, allocator, input, options);
    }

    /// Retrieves the description of a specific support action.
    pub fn getAction(self: *Self, allocator: std.mem.Allocator, input: get_action.GetActionInput, options: CallOptions) !get_action.GetActionOutput {
        return get_action.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a support permit by its ARN or name.
    pub fn getSupportPermit(self: *Self, allocator: std.mem.Allocator, input: get_support_permit.GetSupportPermitInput, options: CallOptions) !get_support_permit.GetSupportPermitOutput {
        return get_support_permit.execute(self, allocator, input, options);
    }

    /// Lists available support actions for a specified AWS service. Use pagination
    /// to ensure that the operation returns quickly and successfully.
    pub fn listActions(self: *Self, allocator: std.mem.Allocator, input: list_actions.ListActionsInput, options: CallOptions) !list_actions.ListActionsOutput {
        return list_actions.execute(self, allocator, input, options);
    }

    /// Lists permit requests from AWS support operators. Use pagination to ensure
    /// that the operation returns quickly and successfully.
    pub fn listSupportPermitRequests(self: *Self, allocator: std.mem.Allocator, input: list_support_permit_requests.ListSupportPermitRequestsInput, options: CallOptions) !list_support_permit_requests.ListSupportPermitRequestsOutput {
        return list_support_permit_requests.execute(self, allocator, input, options);
    }

    /// Lists all support permits in the caller's account. Use pagination to ensure
    /// that the operation returns quickly and successfully.
    pub fn listSupportPermits(self: *Self, allocator: std.mem.Allocator, input: list_support_permits.ListSupportPermitsInput, options: CallOptions) !list_support_permits.ListSupportPermitsOutput {
        return list_support_permits.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with a support permit resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Rejects a permit request from an AWS support operator. The operator cannot
    /// proceed with the requested action.
    pub fn rejectSupportPermitRequest(self: *Self, allocator: std.mem.Allocator, input: reject_support_permit_request.RejectSupportPermitRequestInput, options: CallOptions) !reject_support_permit_request.RejectSupportPermitRequestOutput {
        return reject_support_permit_request.execute(self, allocator, input, options);
    }

    /// Adds or overwrites one or more tags for a support permit resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a support permit resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listActionsPaginator(self: *Self, params: list_actions.ListActionsInput) paginator.ListActionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSupportPermitRequestsPaginator(self: *Self, params: list_support_permit_requests.ListSupportPermitRequestsInput) paginator.ListSupportPermitRequestsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSupportPermitsPaginator(self: *Self, params: list_support_permits.ListSupportPermitsInput) paginator.ListSupportPermitsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};

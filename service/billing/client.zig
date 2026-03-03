const aws = @import("aws");
const std = @import("std");

const associate_source_views = @import("associate_source_views.zig");
const create_billing_view = @import("create_billing_view.zig");
const delete_billing_view = @import("delete_billing_view.zig");
const disassociate_source_views = @import("disassociate_source_views.zig");
const get_billing_view = @import("get_billing_view.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const list_billing_views = @import("list_billing_views.zig");
const list_source_views_for_billing_view = @import("list_source_views_for_billing_view.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_billing_view = @import("update_billing_view.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Billing";

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

    /// Associates one or more source billing views with an existing billing view.
    /// This allows creating aggregate billing views that combine data from multiple
    /// sources.
    pub fn associateSourceViews(self: *Self, allocator: std.mem.Allocator, input: associate_source_views.AssociateSourceViewsInput, options: CallOptions) !associate_source_views.AssociateSourceViewsOutput {
        return associate_source_views.execute(self, allocator, input, options);
    }

    /// Creates a billing view with the specified billing view attributes.
    pub fn createBillingView(self: *Self, allocator: std.mem.Allocator, input: create_billing_view.CreateBillingViewInput, options: CallOptions) !create_billing_view.CreateBillingViewOutput {
        return create_billing_view.execute(self, allocator, input, options);
    }

    /// Deletes the specified billing view.
    pub fn deleteBillingView(self: *Self, allocator: std.mem.Allocator, input: delete_billing_view.DeleteBillingViewInput, options: CallOptions) !delete_billing_view.DeleteBillingViewOutput {
        return delete_billing_view.execute(self, allocator, input, options);
    }

    /// Removes the association between one or more source billing views and an
    /// existing billing view. This allows modifying the composition of aggregate
    /// billing views.
    pub fn disassociateSourceViews(self: *Self, allocator: std.mem.Allocator, input: disassociate_source_views.DisassociateSourceViewsInput, options: CallOptions) !disassociate_source_views.DisassociateSourceViewsOutput {
        return disassociate_source_views.execute(self, allocator, input, options);
    }

    /// Returns the metadata associated to the specified billing view ARN.
    pub fn getBillingView(self: *Self, allocator: std.mem.Allocator, input: get_billing_view.GetBillingViewInput, options: CallOptions) !get_billing_view.GetBillingViewOutput {
        return get_billing_view.execute(self, allocator, input, options);
    }

    /// Returns the resource-based policy document attached to the resource in
    /// `JSON` format.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Lists the billing views available for a given time period.
    ///
    /// Every Amazon Web Services account has a unique `PRIMARY` billing view that
    /// represents the billing data available by default. Accounts that use Billing
    /// Conductor also have `BILLING_GROUP` billing views representing pro forma
    /// costs associated with each created billing group.
    pub fn listBillingViews(self: *Self, allocator: std.mem.Allocator, input: list_billing_views.ListBillingViewsInput, options: CallOptions) !list_billing_views.ListBillingViewsOutput {
        return list_billing_views.execute(self, allocator, input, options);
    }

    /// Lists the source views (managed Amazon Web Services billing views)
    /// associated with the billing view.
    pub fn listSourceViewsForBillingView(self: *Self, allocator: std.mem.Allocator, input: list_source_views_for_billing_view.ListSourceViewsForBillingViewInput, options: CallOptions) !list_source_views_for_billing_view.ListSourceViewsForBillingViewOutput {
        return list_source_views_for_billing_view.execute(self, allocator, input, options);
    }

    /// Lists tags associated with the billing view resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// An API operation for adding one or more tags (key-value pairs) to a
    /// resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a resource. Specify only tag keys in your
    /// request. Don't specify the value.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// An API to update the attributes of the billing view.
    pub fn updateBillingView(self: *Self, allocator: std.mem.Allocator, input: update_billing_view.UpdateBillingViewInput, options: CallOptions) !update_billing_view.UpdateBillingViewOutput {
        return update_billing_view.execute(self, allocator, input, options);
    }

    pub fn listBillingViewsPaginator(self: *Self, params: list_billing_views.ListBillingViewsInput) paginator.ListBillingViewsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSourceViewsForBillingViewPaginator(self: *Self, params: list_source_views_for_billing_view.ListSourceViewsForBillingViewInput) paginator.ListSourceViewsForBillingViewPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

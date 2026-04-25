const aws = @import("aws");
const std = @import("std");

const accept_link = @import("accept_link.zig");
const create_inbound_external_link = @import("create_inbound_external_link.zig");
const create_link = @import("create_link.zig");
const create_outbound_external_link = @import("create_outbound_external_link.zig");
const create_requester_gateway = @import("create_requester_gateway.zig");
const create_responder_gateway = @import("create_responder_gateway.zig");
const delete_inbound_external_link = @import("delete_inbound_external_link.zig");
const delete_link = @import("delete_link.zig");
const delete_outbound_external_link = @import("delete_outbound_external_link.zig");
const delete_requester_gateway = @import("delete_requester_gateway.zig");
const delete_responder_gateway = @import("delete_responder_gateway.zig");
const get_inbound_external_link = @import("get_inbound_external_link.zig");
const get_link = @import("get_link.zig");
const get_outbound_external_link = @import("get_outbound_external_link.zig");
const get_requester_gateway = @import("get_requester_gateway.zig");
const get_responder_gateway = @import("get_responder_gateway.zig");
const list_links = @import("list_links.zig");
const list_requester_gateways = @import("list_requester_gateways.zig");
const list_responder_gateways = @import("list_responder_gateways.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reject_link = @import("reject_link.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_link = @import("update_link.zig");
const update_link_module_flow = @import("update_link_module_flow.zig");
const update_requester_gateway = @import("update_requester_gateway.zig");
const update_responder_gateway = @import("update_responder_gateway.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "RTBFabric";

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

    /// Accepts a link request between gateways.
    ///
    /// When a requester gateway requests to link with a responder gateway, the
    /// responder can use this operation to accept the link request and establish
    /// the connection.
    pub fn acceptLink(self: *Self, allocator: std.mem.Allocator, input: accept_link.AcceptLinkInput, options: CallOptions) !accept_link.AcceptLinkOutput {
        return accept_link.execute(self, allocator, input, options);
    }

    /// Creates an inbound external link.
    pub fn createInboundExternalLink(self: *Self, allocator: std.mem.Allocator, input: create_inbound_external_link.CreateInboundExternalLinkInput, options: CallOptions) !create_inbound_external_link.CreateInboundExternalLinkOutput {
        return create_inbound_external_link.execute(self, allocator, input, options);
    }

    /// Creates a new link between gateways.
    ///
    /// Establishes a connection that allows gateways to communicate and exchange
    /// bid requests and responses.
    pub fn createLink(self: *Self, allocator: std.mem.Allocator, input: create_link.CreateLinkInput, options: CallOptions) !create_link.CreateLinkOutput {
        return create_link.execute(self, allocator, input, options);
    }

    /// Creates an outbound external link.
    pub fn createOutboundExternalLink(self: *Self, allocator: std.mem.Allocator, input: create_outbound_external_link.CreateOutboundExternalLinkInput, options: CallOptions) !create_outbound_external_link.CreateOutboundExternalLinkOutput {
        return create_outbound_external_link.execute(self, allocator, input, options);
    }

    /// Creates a requester gateway.
    pub fn createRequesterGateway(self: *Self, allocator: std.mem.Allocator, input: create_requester_gateway.CreateRequesterGatewayInput, options: CallOptions) !create_requester_gateway.CreateRequesterGatewayOutput {
        return create_requester_gateway.execute(self, allocator, input, options);
    }

    /// Creates a responder gateway.
    ///
    /// A domain name or managed endpoint is required.
    pub fn createResponderGateway(self: *Self, allocator: std.mem.Allocator, input: create_responder_gateway.CreateResponderGatewayInput, options: CallOptions) !create_responder_gateway.CreateResponderGatewayOutput {
        return create_responder_gateway.execute(self, allocator, input, options);
    }

    /// Deletes an inbound external link.
    pub fn deleteInboundExternalLink(self: *Self, allocator: std.mem.Allocator, input: delete_inbound_external_link.DeleteInboundExternalLinkInput, options: CallOptions) !delete_inbound_external_link.DeleteInboundExternalLinkOutput {
        return delete_inbound_external_link.execute(self, allocator, input, options);
    }

    /// Deletes a link between gateways.
    ///
    /// Permanently removes the connection between gateways. This action cannot be
    /// undone.
    pub fn deleteLink(self: *Self, allocator: std.mem.Allocator, input: delete_link.DeleteLinkInput, options: CallOptions) !delete_link.DeleteLinkOutput {
        return delete_link.execute(self, allocator, input, options);
    }

    /// Deletes an outbound external link.
    pub fn deleteOutboundExternalLink(self: *Self, allocator: std.mem.Allocator, input: delete_outbound_external_link.DeleteOutboundExternalLinkInput, options: CallOptions) !delete_outbound_external_link.DeleteOutboundExternalLinkOutput {
        return delete_outbound_external_link.execute(self, allocator, input, options);
    }

    /// Deletes a requester gateway.
    pub fn deleteRequesterGateway(self: *Self, allocator: std.mem.Allocator, input: delete_requester_gateway.DeleteRequesterGatewayInput, options: CallOptions) !delete_requester_gateway.DeleteRequesterGatewayOutput {
        return delete_requester_gateway.execute(self, allocator, input, options);
    }

    /// Deletes a responder gateway.
    pub fn deleteResponderGateway(self: *Self, allocator: std.mem.Allocator, input: delete_responder_gateway.DeleteResponderGatewayInput, options: CallOptions) !delete_responder_gateway.DeleteResponderGatewayOutput {
        return delete_responder_gateway.execute(self, allocator, input, options);
    }

    /// Retrieves information about an inbound external link.
    pub fn getInboundExternalLink(self: *Self, allocator: std.mem.Allocator, input: get_inbound_external_link.GetInboundExternalLinkInput, options: CallOptions) !get_inbound_external_link.GetInboundExternalLinkOutput {
        return get_inbound_external_link.execute(self, allocator, input, options);
    }

    /// Retrieves information about a link between gateways.
    ///
    /// Returns detailed information about the link configuration, status, and
    /// associated gateways.
    pub fn getLink(self: *Self, allocator: std.mem.Allocator, input: get_link.GetLinkInput, options: CallOptions) !get_link.GetLinkOutput {
        return get_link.execute(self, allocator, input, options);
    }

    /// Retrieves information about an outbound external link.
    pub fn getOutboundExternalLink(self: *Self, allocator: std.mem.Allocator, input: get_outbound_external_link.GetOutboundExternalLinkInput, options: CallOptions) !get_outbound_external_link.GetOutboundExternalLinkOutput {
        return get_outbound_external_link.execute(self, allocator, input, options);
    }

    /// Retrieves information about a requester gateway.
    pub fn getRequesterGateway(self: *Self, allocator: std.mem.Allocator, input: get_requester_gateway.GetRequesterGatewayInput, options: CallOptions) !get_requester_gateway.GetRequesterGatewayOutput {
        return get_requester_gateway.execute(self, allocator, input, options);
    }

    /// Retrieves information about a responder gateway.
    pub fn getResponderGateway(self: *Self, allocator: std.mem.Allocator, input: get_responder_gateway.GetResponderGatewayInput, options: CallOptions) !get_responder_gateway.GetResponderGatewayOutput {
        return get_responder_gateway.execute(self, allocator, input, options);
    }

    /// Lists links associated with gateways.
    ///
    /// Returns a list of all links for the specified gateways, including their
    /// status and configuration details.
    pub fn listLinks(self: *Self, allocator: std.mem.Allocator, input: list_links.ListLinksInput, options: CallOptions) !list_links.ListLinksOutput {
        return list_links.execute(self, allocator, input, options);
    }

    /// Lists requester gateways.
    pub fn listRequesterGateways(self: *Self, allocator: std.mem.Allocator, input: list_requester_gateways.ListRequesterGatewaysInput, options: CallOptions) !list_requester_gateways.ListRequesterGatewaysOutput {
        return list_requester_gateways.execute(self, allocator, input, options);
    }

    /// Lists reponder gateways.
    pub fn listResponderGateways(self: *Self, allocator: std.mem.Allocator, input: list_responder_gateways.ListResponderGatewaysInput, options: CallOptions) !list_responder_gateways.ListResponderGatewaysOutput {
        return list_responder_gateways.execute(self, allocator, input, options);
    }

    /// Lists tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Rejects a link request between gateways.
    ///
    /// When a requester gateway requests to link with a responder gateway, the
    /// responder can use this operation to decline the link request.
    pub fn rejectLink(self: *Self, allocator: std.mem.Allocator, input: reject_link.RejectLinkInput, options: CallOptions) !reject_link.RejectLinkOutput {
        return reject_link.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a link between gateways.
    ///
    /// Allows you to modify settings and parameters for an existing link.
    pub fn updateLink(self: *Self, allocator: std.mem.Allocator, input: update_link.UpdateLinkInput, options: CallOptions) !update_link.UpdateLinkOutput {
        return update_link.execute(self, allocator, input, options);
    }

    /// Updates a link module flow.
    pub fn updateLinkModuleFlow(self: *Self, allocator: std.mem.Allocator, input: update_link_module_flow.UpdateLinkModuleFlowInput, options: CallOptions) !update_link_module_flow.UpdateLinkModuleFlowOutput {
        return update_link_module_flow.execute(self, allocator, input, options);
    }

    /// Updates a requester gateway.
    pub fn updateRequesterGateway(self: *Self, allocator: std.mem.Allocator, input: update_requester_gateway.UpdateRequesterGatewayInput, options: CallOptions) !update_requester_gateway.UpdateRequesterGatewayOutput {
        return update_requester_gateway.execute(self, allocator, input, options);
    }

    /// Updates a responder gateway.
    pub fn updateResponderGateway(self: *Self, allocator: std.mem.Allocator, input: update_responder_gateway.UpdateResponderGatewayInput, options: CallOptions) !update_responder_gateway.UpdateResponderGatewayOutput {
        return update_responder_gateway.execute(self, allocator, input, options);
    }

    pub fn listLinksPaginator(self: *Self, params: list_links.ListLinksInput) paginator.ListLinksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRequesterGatewaysPaginator(self: *Self, params: list_requester_gateways.ListRequesterGatewaysInput) paginator.ListRequesterGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResponderGatewaysPaginator(self: *Self, params: list_responder_gateways.ListResponderGatewaysInput) paginator.ListResponderGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilInboundExternalLinkActive(self: *Self, params: get_inbound_external_link.GetInboundExternalLinkInput) aws.waiter.WaiterError!void {
        var w = waiters.InboundExternalLinkActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInboundExternalLinkDeleted(self: *Self, params: get_inbound_external_link.GetInboundExternalLinkInput) aws.waiter.WaiterError!void {
        var w = waiters.InboundExternalLinkDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilLinkAccepted(self: *Self, params: get_link.GetLinkInput) aws.waiter.WaiterError!void {
        var w = waiters.LinkAcceptedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilLinkActive(self: *Self, params: get_link.GetLinkInput) aws.waiter.WaiterError!void {
        var w = waiters.LinkActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilLinkDeleted(self: *Self, params: get_link.GetLinkInput) aws.waiter.WaiterError!void {
        var w = waiters.LinkDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilOutboundExternalLinkActive(self: *Self, params: get_outbound_external_link.GetOutboundExternalLinkInput) aws.waiter.WaiterError!void {
        var w = waiters.OutboundExternalLinkActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilOutboundExternalLinkDeleted(self: *Self, params: get_outbound_external_link.GetOutboundExternalLinkInput) aws.waiter.WaiterError!void {
        var w = waiters.OutboundExternalLinkDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilRequesterGatewayActive(self: *Self, params: get_requester_gateway.GetRequesterGatewayInput) aws.waiter.WaiterError!void {
        var w = waiters.RequesterGatewayActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilRequesterGatewayDeleted(self: *Self, params: get_requester_gateway.GetRequesterGatewayInput) aws.waiter.WaiterError!void {
        var w = waiters.RequesterGatewayDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilResponderGatewayActive(self: *Self, params: get_responder_gateway.GetResponderGatewayInput) aws.waiter.WaiterError!void {
        var w = waiters.ResponderGatewayActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilResponderGatewayDeleted(self: *Self, params: get_responder_gateway.GetResponderGatewayInput) aws.waiter.WaiterError!void {
        var w = waiters.ResponderGatewayDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};

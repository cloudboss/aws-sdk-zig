const aws = @import("aws");
const std = @import("std");

const accept_connection_proposal = @import("accept_connection_proposal.zig");
const create_connection = @import("create_connection.zig");
const delete_connection = @import("delete_connection.zig");
const describe_connection_proposal = @import("describe_connection_proposal.zig");
const get_connection = @import("get_connection.zig");
const get_environment = @import("get_environment.zig");
const list_attach_points = @import("list_attach_points.zig");
const list_connections = @import("list_connections.zig");
const list_environments = @import("list_environments.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_connection = @import("update_connection.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Interconnect";

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

    /// Accepts a connection proposal which was generated at a supported partner's
    /// portal.
    ///
    /// The proposal contains the Environment and bandwidth that were chosen on the
    /// partner's portal and cannot be modified.
    ///
    /// Upon accepting the proposal a connection will be made between the AWS
    /// network as accessed via the selected Attach Point and the network previously
    /// selected network on the partner's portal.
    pub fn acceptConnectionProposal(self: *Self, allocator: std.mem.Allocator, input: accept_connection_proposal.AcceptConnectionProposalInput, options: CallOptions) !accept_connection_proposal.AcceptConnectionProposalOutput {
        return accept_connection_proposal.execute(self, allocator, input, options);
    }

    /// Initiates the process to create a Connection across the specified
    /// Environment.
    ///
    /// The Environment dictates the specified partner and location to which the
    /// other end of the connection should attach. You can see a list of the
    /// available Environments by calling ListEnvironments
    ///
    /// The Attach Point specifies where within the AWS Network your connection will
    /// logically connect.
    ///
    /// After a successful call to this method, the resulting Connection will return
    /// an Activation Key which will need to be brought to the specific partner's
    /// portal to confirm the Connection on both sides. (See
    /// Environment$activationPageUrl for a direct link to the partner portal).
    pub fn createConnection(self: *Self, allocator: std.mem.Allocator, input: create_connection.CreateConnectionInput, options: CallOptions) !create_connection.CreateConnectionOutput {
        return create_connection.execute(self, allocator, input, options);
    }

    /// Deletes an existing Connection with the supplied identifier.
    ///
    /// This operation will also inform the remote partner of your intention to
    /// delete your connection. Note, the partner may still require you to delete to
    /// fully clean up resources, but the network connectivity provided by the
    /// Connection will cease to exist.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: CallOptions) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Describes the details of a connection proposal generated at a partner's
    /// portal.
    pub fn describeConnectionProposal(self: *Self, allocator: std.mem.Allocator, input: describe_connection_proposal.DescribeConnectionProposalInput, options: CallOptions) !describe_connection_proposal.DescribeConnectionProposalOutput {
        return describe_connection_proposal.execute(self, allocator, input, options);
    }

    /// Describes the current state of a Connection resource as specified by the
    /// identifier.
    pub fn getConnection(self: *Self, allocator: std.mem.Allocator, input: get_connection.GetConnectionInput, options: CallOptions) !get_connection.GetConnectionOutput {
        return get_connection.execute(self, allocator, input, options);
    }

    /// Describes a specific Environment
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: CallOptions) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// Lists all Attach Points the caller has access to that are valid for the
    /// specified Environment.
    pub fn listAttachPoints(self: *Self, allocator: std.mem.Allocator, input: list_attach_points.ListAttachPointsInput, options: CallOptions) !list_attach_points.ListAttachPointsOutput {
        return list_attach_points.execute(self, allocator, input, options);
    }

    /// Lists all connection objects to which the caller has access.
    ///
    /// Allows for optional filtering by the following properties:
    ///
    /// * `state`
    /// * `environmentId`
    /// * `provider`
    /// * `attach point`
    ///
    /// Only Connection objects matching all filters will be returned.
    pub fn listConnections(self: *Self, allocator: std.mem.Allocator, input: list_connections.ListConnectionsInput, options: CallOptions) !list_connections.ListConnectionsOutput {
        return list_connections.execute(self, allocator, input, options);
    }

    /// Lists all of the environments that can produce connections that will land in
    /// the called AWS region.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: CallOptions) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// List all current tags on the specified resource. Currently this supports
    /// Connection resources.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Add new tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies an existing connection. Currently we support modifications to the
    /// connection's description and/or bandwidth.
    pub fn updateConnection(self: *Self, allocator: std.mem.Allocator, input: update_connection.UpdateConnectionInput, options: CallOptions) !update_connection.UpdateConnectionOutput {
        return update_connection.execute(self, allocator, input, options);
    }

    pub fn listAttachPointsPaginator(self: *Self, params: list_attach_points.ListAttachPointsInput) paginator.ListAttachPointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConnectionsPaginator(self: *Self, params: list_connections.ListConnectionsInput) paginator.ListConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnvironmentsPaginator(self: *Self, params: list_environments.ListEnvironmentsInput) paginator.ListEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilConnectionAvailable(self: *Self, params: get_connection.GetConnectionInput) aws.waiter.WaiterError!void {
        var w = waiters.ConnectionAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilConnectionDeleted(self: *Self, params: get_connection.GetConnectionInput) aws.waiter.WaiterError!void {
        var w = waiters.ConnectionDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};

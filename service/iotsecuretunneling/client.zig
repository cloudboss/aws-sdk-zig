const aws = @import("aws");
const std = @import("std");

const close_tunnel = @import("close_tunnel.zig");
const describe_tunnel = @import("describe_tunnel.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tunnels = @import("list_tunnels.zig");
const open_tunnel = @import("open_tunnel.zig");
const rotate_tunnel_access_token = @import("rotate_tunnel_access_token.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoTSecureTunneling";

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

    /// Closes a tunnel identified by the unique tunnel id. When a `CloseTunnel`
    /// request is received, we close the WebSocket connections between the client
    /// and proxy
    /// server so no data can be transmitted.
    ///
    /// Requires permission to access the
    /// [CloseTunnel](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn closeTunnel(self: *Self, allocator: std.mem.Allocator, input: close_tunnel.CloseTunnelInput, options: close_tunnel.Options) !close_tunnel.CloseTunnelOutput {
        return close_tunnel.execute(self, allocator, input, options);
    }

    /// Gets information about a tunnel identified by the unique tunnel id.
    ///
    /// Requires permission to access the
    /// [DescribeTunnel](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeTunnel(self: *Self, allocator: std.mem.Allocator, input: describe_tunnel.DescribeTunnelInput, options: describe_tunnel.Options) !describe_tunnel.DescribeTunnelOutput {
        return describe_tunnel.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List all tunnels for an Amazon Web Services account. Tunnels are listed by
    /// creation time in
    /// descending order, newer tunnels will be listed before older tunnels.
    ///
    /// Requires permission to access the
    /// [ListTunnels](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listTunnels(self: *Self, allocator: std.mem.Allocator, input: list_tunnels.ListTunnelsInput, options: list_tunnels.Options) !list_tunnels.ListTunnelsOutput {
        return list_tunnels.execute(self, allocator, input, options);
    }

    /// Creates a new tunnel, and returns two client access tokens for clients to
    /// use to
    /// connect to the IoT Secure Tunneling proxy server.
    ///
    /// Requires permission to access the
    /// [OpenTunnel](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn openTunnel(self: *Self, allocator: std.mem.Allocator, input: open_tunnel.OpenTunnelInput, options: open_tunnel.Options) !open_tunnel.OpenTunnelOutput {
        return open_tunnel.execute(self, allocator, input, options);
    }

    /// Revokes the current client access token (CAT) and returns new CAT for
    /// clients to
    /// use when reconnecting to secure tunneling to access the same tunnel.
    ///
    /// Requires permission to access the
    /// [RotateTunnelAccessToken](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// Rotating the CAT doesn't extend the tunnel duration. For example, say the
    /// tunnel
    /// duration is 12 hours and the tunnel has already been open for 4 hours. When
    /// you
    /// rotate the access tokens, the new tokens that are generated can only be used
    /// for the
    /// remaining 8 hours.
    pub fn rotateTunnelAccessToken(self: *Self, allocator: std.mem.Allocator, input: rotate_tunnel_access_token.RotateTunnelAccessTokenInput, options: rotate_tunnel_access_token.Options) !rotate_tunnel_access_token.RotateTunnelAccessTokenOutput {
        return rotate_tunnel_access_token.execute(self, allocator, input, options);
    }

    /// A resource tag.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listTunnelsPaginator(self: *Self, params: list_tunnels.ListTunnelsInput) paginator.ListTunnelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NodeCategory = @import("node_category.zig").NodeCategory;
const NodeInterface = @import("node_interface.zig").NodeInterface;

pub const DescribeNodeInput = struct {
    /// The node's ID.
    node_id: []const u8,

    /// The account ID of the node's owner.
    owner_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .node_id = "NodeId",
        .owner_account = "OwnerAccount",
    };
};

pub const DescribeNodeOutput = struct {
    /// The node's asset name.
    asset_name: ?[]const u8 = null,

    /// The node's category.
    category: NodeCategory,

    /// When the node was created.
    created_time: i64,

    /// The node's description.
    description: []const u8,

    /// When the node was updated.
    last_updated_time: i64,

    /// The node's name.
    name: []const u8,

    /// The node's ID.
    node_id: []const u8,

    /// The node's interface.
    node_interface: ?NodeInterface = null,

    /// The account ID of the node's owner.
    owner_account: []const u8,

    /// The node's ARN.
    package_arn: ?[]const u8 = null,

    /// The node's package ID.
    package_id: []const u8,

    /// The node's package name.
    package_name: []const u8,

    /// The node's package version.
    package_version: []const u8,

    /// The node's patch version.
    patch_version: []const u8,

    pub const json_field_names = .{
        .asset_name = "AssetName",
        .category = "Category",
        .created_time = "CreatedTime",
        .description = "Description",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .node_id = "NodeId",
        .node_interface = "NodeInterface",
        .owner_account = "OwnerAccount",
        .package_arn = "PackageArn",
        .package_id = "PackageId",
        .package_name = "PackageName",
        .package_version = "PackageVersion",
        .patch_version = "PatchVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeNodeInput, options: CallOptions) !DescribeNodeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeNodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/nodes/");
    try path_buf.appendSlice(allocator, input.node_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.owner_account) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "OwnerAccount=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeNodeOutput {
    var result: DescribeNodeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeNodeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

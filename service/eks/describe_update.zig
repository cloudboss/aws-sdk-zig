const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Update = @import("update.zig").Update;

pub const DescribeUpdateInput = struct {
    /// The name of the add-on. The name must match one of the names returned by [
    /// `ListAddons`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_ListAddons.html).
    /// This parameter is required if the update is an add-on update.
    addon_name: ?[]const u8 = null,

    /// The name of the capability for which you want to describe updates.
    capability_name: ?[]const u8 = null,

    /// The name of the Amazon EKS cluster associated with the update.
    name: []const u8,

    /// The name of the Amazon EKS node group associated with the update. This
    /// parameter is
    /// required if the update is a node group update.
    nodegroup_name: ?[]const u8 = null,

    /// The ID of the update to describe.
    update_id: []const u8,

    pub const json_field_names = .{
        .addon_name = "addonName",
        .capability_name = "capabilityName",
        .name = "name",
        .nodegroup_name = "nodegroupName",
        .update_id = "updateId",
    };
};

pub const DescribeUpdateOutput = struct {
    /// The full description of the specified update.
    update: ?Update = null,

    pub const json_field_names = .{
        .update = "update",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUpdateInput, options: CallOptions) !DescribeUpdateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUpdateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/updates/");
    try path_buf.appendSlice(allocator, input.update_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.addon_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "addonName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.capability_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "capabilityName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.nodegroup_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nodegroupName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUpdateOutput {
    var result: DescribeUpdateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeUpdateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

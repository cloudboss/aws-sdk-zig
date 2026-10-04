const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Addon = @import("addon.zig").Addon;

pub const DeleteAddonInput = struct {
    /// The name of the add-on. The name must match one of the names returned by [
    /// `ListAddons`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_ListAddons.html).
    addon_name: []const u8,

    /// The name of your cluster.
    cluster_name: []const u8,

    /// Specifying this option preserves the add-on software on your cluster but
    /// Amazon EKS stops
    /// managing any settings for the add-on. If an IAM account is associated with
    /// the add-on,
    /// it isn't removed.
    preserve: ?bool = null,

    pub const json_field_names = .{
        .addon_name = "addonName",
        .cluster_name = "clusterName",
        .preserve = "preserve",
    };
};

pub const DeleteAddonOutput = struct {
    addon: ?Addon = null,

    pub const json_field_names = .{
        .addon = "addon",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAddonInput, options: CallOptions) !DeleteAddonOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAddonInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/addons/");
    try path_buf.appendSlice(allocator, input.addon_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.preserve) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "preserve=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAddonOutput {
    var result: DeleteAddonOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteAddonOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

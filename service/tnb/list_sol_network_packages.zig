const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListSolNetworkPackageInfo = @import("list_sol_network_package_info.zig").ListSolNetworkPackageInfo;

pub const ListSolNetworkPackagesInput = struct {
    /// The maximum number of results to include in the response.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListSolNetworkPackagesOutput = struct {
    /// Network packages. A network package is a .zip file in CSAR (Cloud Service
    /// Archive) format defines the function packages you want to deploy and the
    /// Amazon Web Services infrastructure you want to deploy them on.
    network_packages: ?[]const ListSolNetworkPackageInfo = null,

    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .network_packages = "networkPackages",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSolNetworkPackagesInput, options: CallOptions) !ListSolNetworkPackagesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tnb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSolNetworkPackagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sol/nsd/v1/ns_descriptors";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max_results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextpage_opaque_marker=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSolNetworkPackagesOutput {
    var result: ListSolNetworkPackagesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSolNetworkPackagesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

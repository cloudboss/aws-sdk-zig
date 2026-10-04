const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Architecture = @import("architecture.zig").Architecture;
const Runtime = @import("runtime.zig").Runtime;
const LayerVersionsListItem = @import("layer_versions_list_item.zig").LayerVersionsListItem;

pub const ListLayerVersionsInput = struct {
    /// The compatible [instruction set
    /// architecture](https://docs.aws.amazon.com/lambda/latest/dg/foundation-arch.html).
    compatible_architecture: ?Architecture = null,

    /// A runtime identifier.
    ///
    /// The following list includes deprecated runtimes. For more information, see
    /// [Runtime use after
    /// deprecation](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtime-deprecation-levels).
    ///
    /// For a list of all currently supported runtimes, see [Supported
    /// runtimes](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtimes-supported).
    compatible_runtime: ?Runtime = null,

    /// The name or Amazon Resource Name (ARN) of the layer.
    layer_name: []const u8,

    /// A pagination token returned by a previous call.
    marker: ?[]const u8 = null,

    /// The maximum number of versions to return.
    max_items: ?i32 = null,

    pub const json_field_names = .{
        .compatible_architecture = "CompatibleArchitecture",
        .compatible_runtime = "CompatibleRuntime",
        .layer_name = "LayerName",
        .marker = "Marker",
        .max_items = "MaxItems",
    };
};

pub const ListLayerVersionsOutput = struct {
    /// A list of versions.
    layer_versions: ?[]const LayerVersionsListItem = null,

    /// A pagination token returned when the response doesn't contain all versions.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .layer_versions = "LayerVersions",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLayerVersionsInput, options: CallOptions) !ListLayerVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLayerVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2018-10-31/layers/");
    try path_buf.appendSlice(allocator, input.layer_name);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.compatible_architecture) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "CompatibleArchitecture=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.compatible_runtime) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "CompatibleRuntime=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLayerVersionsOutput {
    const result: ListLayerVersionsOutput = try aws.json.parseJsonObject(
        ListLayerVersionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StorageConfigurationSummary = @import("storage_configuration_summary.zig").StorageConfigurationSummary;

pub const ListStorageConfigurationsInput = struct {
    /// Maximum number of storage configurations to return. Default: your service
    /// quota or 100,
    /// whichever is smaller.
    max_results: ?i32 = null,

    /// The first storage configuration to retrieve. This is used for pagination;
    /// see the `nextToken` response field.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListStorageConfigurationsOutput = struct {
    /// If there are more storage configurations than `maxResults`, use `nextToken`
    /// in the request to get the next set.
    next_token: ?[]const u8 = null,

    /// List of the matching storage configurations.
    storage_configurations: ?[]const StorageConfigurationSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .storage_configurations = "storageConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStorageConfigurationsInput, options: CallOptions) !ListStorageConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStorageConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListStorageConfigurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStorageConfigurationsOutput {
    var result: ListStorageConfigurationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListStorageConfigurationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Architecture = @import("architecture.zig").Architecture;
const Chipset = @import("chipset.zig").Chipset;
const MicrovmImageBuildSummary = @import("microvm_image_build_summary.zig").MicrovmImageBuildSummary;

pub const ListMicrovmImageBuildsInput = struct {
    /// Filters builds by target CPU architecture.
    architecture: ?Architecture = null,

    /// Filters builds by target chipset.
    chipset: ?Chipset = null,

    /// Filters builds by target chipset generation.
    chipset_generation: ?[]const u8 = null,

    /// The unique identifier (ARN or ID) of the MicroVM image.
    image_identifier: []const u8,

    /// The version of the MicroVM image to list builds for.
    image_version: []const u8,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The pagination token from a previous call. Use this token to retrieve the
    /// next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .architecture = "architecture",
        .chipset = "chipset",
        .chipset_generation = "chipsetGeneration",
        .image_identifier = "imageIdentifier",
        .image_version = "imageVersion",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListMicrovmImageBuildsOutput = struct {
    /// The list of MicroVM image builds.
    items: ?[]const MicrovmImageBuildSummary = null,

    /// The pagination token to use in a subsequent request to retrieve the next
    /// page of results. This value is null when there are no more results to
    /// return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMicrovmImageBuildsInput, options: CallOptions) !ListMicrovmImageBuildsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMicrovmImageBuildsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Microvms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-09-09/microvm-images/");
    try path_buf.appendSlice(allocator, input.image_identifier);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.image_version);
    try path_buf.appendSlice(allocator, "/builds");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.architecture) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "architecture=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.chipset) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "chipset=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.chipset_generation) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "chipsetGeneration=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMicrovmImageBuildsOutput {
    const result: ListMicrovmImageBuildsOutput = try aws.json.parseJsonObject(
        ListMicrovmImageBuildsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

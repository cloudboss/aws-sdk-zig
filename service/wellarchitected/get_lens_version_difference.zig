const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VersionDifferences = @import("version_differences.zig").VersionDifferences;

pub const GetLensVersionDifferenceInput = struct {
    /// The base version of the lens.
    base_lens_version: ?[]const u8 = null,

    lens_alias: []const u8,

    /// The lens version to target a difference for.
    target_lens_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_lens_version = "BaseLensVersion",
        .lens_alias = "LensAlias",
        .target_lens_version = "TargetLensVersion",
    };
};

pub const GetLensVersionDifferenceOutput = struct {
    /// The base version of the lens.
    base_lens_version: ?[]const u8 = null,

    /// The latest version of the lens.
    latest_lens_version: ?[]const u8 = null,

    lens_alias: ?[]const u8 = null,

    /// The ARN for the lens.
    lens_arn: ?[]const u8 = null,

    /// The target lens version for the lens.
    target_lens_version: ?[]const u8 = null,

    version_differences: ?VersionDifferences = null,

    pub const json_field_names = .{
        .base_lens_version = "BaseLensVersion",
        .latest_lens_version = "LatestLensVersion",
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
        .target_lens_version = "TargetLensVersion",
        .version_differences = "VersionDifferences",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLensVersionDifferenceInput, options: CallOptions) !GetLensVersionDifferenceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLensVersionDifferenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/lenses/");
    try path_buf.appendSlice(allocator, input.lens_alias);
    try path_buf.appendSlice(allocator, "/versionDifference");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.base_lens_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "BaseLensVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.target_lens_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "TargetLensVersion=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLensVersionDifferenceOutput {
    var result: GetLensVersionDifferenceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetLensVersionDifferenceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

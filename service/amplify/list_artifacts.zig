const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Artifact = @import("artifact.zig").Artifact;

pub const ListArtifactsInput = struct {
    /// The unique ID for an Amplify app.
    app_id: []const u8,

    /// The name of a branch that is part of an Amplify app.
    branch_name: []const u8,

    /// The unique ID for a job.
    job_id: []const u8,

    /// The maximum number of records to list in a single response.
    max_results: ?i32 = null,

    /// A pagination token. Set to null to start listing artifacts from start. If a
    /// non-null
    /// pagination token is returned in a result, pass its value in here to list
    /// more artifacts.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .branch_name = "branchName",
        .job_id = "jobId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListArtifactsOutput = struct {
    /// A list of artifacts.
    artifacts: ?[]const Artifact = null,

    /// A pagination token. If a non-null pagination token is returned in a result,
    /// pass its
    /// value in another request to retrieve more entries.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifacts = "artifacts",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListArtifactsInput, options: CallOptions) !ListArtifactsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplify", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListArtifactsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplify", "Amplify", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/apps/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/branches/");
    try path_buf.appendSlice(allocator, input.branch_name);
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    try path_buf.appendSlice(allocator, "/artifacts");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListArtifactsOutput {
    var result: ListArtifactsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListArtifactsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

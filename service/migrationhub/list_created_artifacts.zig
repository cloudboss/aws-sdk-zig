const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreatedArtifact = @import("created_artifact.zig").CreatedArtifact;

pub const ListCreatedArtifactsInput = struct {
    /// Maximum number of results to be returned per page.
    max_results: ?i32 = null,

    /// Unique identifier that references the migration task. *Do not store personal
    /// data in this field.*
    migration_task_name: []const u8,

    /// If a `NextToken` was returned by a previous call, there are more results
    /// available. To retrieve the next page of results, make the call again using
    /// the returned
    /// token in `NextToken`.
    next_token: ?[]const u8 = null,

    /// The name of the ProgressUpdateStream.
    progress_update_stream: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .migration_task_name = "MigrationTaskName",
        .next_token = "NextToken",
        .progress_update_stream = "ProgressUpdateStream",
    };
};

pub const ListCreatedArtifactsOutput = struct {
    /// List of created artifacts up to the maximum number of results specified in
    /// the
    /// request.
    created_artifact_list: ?[]const CreatedArtifact = null,

    /// If there are more created artifacts than the max result, return the next
    /// token to be
    /// passed to the next call as a bookmark of where to start from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_artifact_list = "CreatedArtifactList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCreatedArtifactsInput, options: CallOptions) !ListCreatedArtifactsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgh", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCreatedArtifactsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgh", "Migration Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHub.ListCreatedArtifacts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCreatedArtifactsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCreatedArtifactsOutput, body, allocator);
}

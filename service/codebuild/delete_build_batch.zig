const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BuildNotDeleted = @import("build_not_deleted.zig").BuildNotDeleted;

pub const DeleteBuildBatchInput = struct {
    /// The identifier of the batch build to delete.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const DeleteBuildBatchOutput = struct {
    /// An array of strings that contain the identifiers of the builds that were
    /// deleted.
    builds_deleted: ?[]const []const u8 = null,

    /// An array of `BuildNotDeleted` objects that specify the builds that could not
    /// be
    /// deleted.
    builds_not_deleted: ?[]const BuildNotDeleted = null,

    /// The status code.
    status_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .builds_deleted = "buildsDeleted",
        .builds_not_deleted = "buildsNotDeleted",
        .status_code = "statusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBuildBatchInput, options: CallOptions) !DeleteBuildBatchOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBuildBatchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.DeleteBuildBatch");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBuildBatchOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteBuildBatchOutput, body, allocator);
}

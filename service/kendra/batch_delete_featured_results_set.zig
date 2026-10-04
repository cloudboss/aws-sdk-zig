const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDeleteFeaturedResultsSetError = @import("batch_delete_featured_results_set_error.zig").BatchDeleteFeaturedResultsSetError;

pub const BatchDeleteFeaturedResultsSetInput = struct {
    /// The identifiers of the featured results sets that you want to delete.
    featured_results_set_ids: []const []const u8,

    /// The identifier of the index used for featuring results.
    index_id: []const u8,

    pub const json_field_names = .{
        .featured_results_set_ids = "FeaturedResultsSetIds",
        .index_id = "IndexId",
    };
};

pub const BatchDeleteFeaturedResultsSetOutput = struct {
    /// The list of errors for the featured results set IDs, explaining why they
    /// couldn't be removed from the index.
    errors: ?[]const BatchDeleteFeaturedResultsSetError = null,

    pub const json_field_names = .{
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteFeaturedResultsSetInput, options: CallOptions) !BatchDeleteFeaturedResultsSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteFeaturedResultsSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.BatchDeleteFeaturedResultsSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteFeaturedResultsSetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(BatchDeleteFeaturedResultsSetOutput, body, allocator);
}

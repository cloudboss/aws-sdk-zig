const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3TableIntegrationSource = @import("s3_table_integration_source.zig").S3TableIntegrationSource;

pub const ListSourcesForS3TableIntegrationInput = struct {
    /// The Amazon Resource Name (ARN) of the S3 Table Integration to list
    /// associations
    /// for.
    integration_arn: []const u8,

    /// The maximum number of associations to return in a single call. Valid range
    /// is 1 to
    /// 100.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .integration_arn = "integrationArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListSourcesForS3TableIntegrationOutput = struct {
    next_token: ?[]const u8 = null,

    /// The list of data source associations for the specified S3 Table Integration.
    sources: ?[]const S3TableIntegrationSource = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .sources = "sources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSourcesForS3TableIntegrationInput, options: CallOptions) !ListSourcesForS3TableIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSourcesForS3TableIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.ListSourcesForS3TableIntegration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSourcesForS3TableIntegrationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSourcesForS3TableIntegrationOutput, body, allocator);
}

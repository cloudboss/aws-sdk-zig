const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GenerateQueryInput = struct {
    /// The ARN (or ID suffix of the ARN) of the event data store
    /// that you want to query. You can only specify one event data store.
    event_data_stores: []const []const u8,

    /// The prompt that you want to use to generate the query. The prompt must be in
    /// English. For example prompts, see
    /// [Example
    /// prompts](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/lake-query-generator.html#lake-query-generator-examples)
    /// in the *CloudTrail * user guide.
    prompt: []const u8,

    pub const json_field_names = .{
        .event_data_stores = "EventDataStores",
        .prompt = "Prompt",
    };
};

pub const GenerateQueryOutput = struct {
    /// The account ID of the event data store owner.
    event_data_store_owner_account_id: ?[]const u8 = null,

    /// An alias that identifies the prompt. When you run the `StartQuery`
    /// operation, you can pass in either the `QueryAlias` or
    /// `QueryStatement` parameter.
    query_alias: ?[]const u8 = null,

    /// The SQL query statement generated from the prompt.
    query_statement: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_data_store_owner_account_id = "EventDataStoreOwnerAccountId",
        .query_alias = "QueryAlias",
        .query_statement = "QueryStatement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateQueryInput, options: CallOptions) !GenerateQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.GenerateQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateQueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GenerateQueryOutput, body, allocator);
}

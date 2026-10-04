const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartQueryInput = struct {
    /// The URI for the S3 bucket where CloudTrail delivers the query results.
    delivery_s3_uri: ?[]const u8 = null,

    /// The account ID of the event data store owner.
    event_data_store_owner_account_id: ?[]const u8 = null,

    /// The alias that identifies a query template.
    query_alias: ?[]const u8 = null,

    /// The query parameters for the specified `QueryAlias`.
    query_parameters: ?[]const []const u8 = null,

    /// The SQL code of your query.
    query_statement: ?[]const u8 = null,

    pub const json_field_names = .{
        .delivery_s3_uri = "DeliveryS3Uri",
        .event_data_store_owner_account_id = "EventDataStoreOwnerAccountId",
        .query_alias = "QueryAlias",
        .query_parameters = "QueryParameters",
        .query_statement = "QueryStatement",
    };
};

pub const StartQueryOutput = struct {
    /// The account ID of the event data store owner.
    event_data_store_owner_account_id: ?[]const u8 = null,

    /// The ID of the started query.
    query_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_data_store_owner_account_id = "EventDataStoreOwnerAccountId",
        .query_id = "QueryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQueryInput, options: CallOptions) !StartQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQueryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.StartQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartQueryOutput, body, allocator);
}

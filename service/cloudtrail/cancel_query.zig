const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryStatus = @import("query_status.zig").QueryStatus;

pub const CancelQueryInput = struct {
    /// The ARN (or the ID suffix of the ARN) of an event data store on which the
    /// specified
    /// query is running.
    event_data_store: ?[]const u8 = null,

    /// The account ID of the event data store owner.
    event_data_store_owner_account_id: ?[]const u8 = null,

    /// The ID of the query that you want to cancel. The `QueryId` comes from the
    /// response of a `StartQuery` operation.
    query_id: []const u8,

    pub const json_field_names = .{
        .event_data_store = "EventDataStore",
        .event_data_store_owner_account_id = "EventDataStoreOwnerAccountId",
        .query_id = "QueryId",
    };
};

pub const CancelQueryOutput = struct {
    /// The account ID of the event data store owner.
    event_data_store_owner_account_id: ?[]const u8 = null,

    /// The ID of the canceled query.
    query_id: []const u8,

    /// Shows the status of a query after a `CancelQuery` request. Typically, the
    /// values shown are either `RUNNING` or `CANCELLED`.
    query_status: QueryStatus,

    pub const json_field_names = .{
        .event_data_store_owner_account_id = "EventDataStoreOwnerAccountId",
        .query_id = "QueryId",
        .query_status = "QueryStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelQueryInput, options: CallOptions) !CancelQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelQueryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.CancelQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelQueryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CancelQueryOutput, body, allocator);
}

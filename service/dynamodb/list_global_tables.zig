const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalTable = @import("global_table.zig").GlobalTable;

pub const ListGlobalTablesInput = struct {
    /// The first global table name that this operation will evaluate.
    exclusive_start_global_table_name: ?[]const u8 = null,

    /// The maximum number of table names to return, if the parameter is not
    /// specified
    /// DynamoDB defaults to 100.
    ///
    /// If the number of global tables DynamoDB finds reaches this limit, it stops
    /// the
    /// operation and returns the table names collected up to that point, with a
    /// table name in
    /// the `LastEvaluatedGlobalTableName` to apply in a subsequent operation to the
    /// `ExclusiveStartGlobalTableName` parameter.
    limit: ?i32 = null,

    /// Lists the global tables in a specific Region.
    region_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .exclusive_start_global_table_name = "ExclusiveStartGlobalTableName",
        .limit = "Limit",
        .region_name = "RegionName",
    };
};

pub const ListGlobalTablesOutput = struct {
    /// List of global table names.
    global_tables: ?[]const GlobalTable = null,

    /// Last evaluated global table name.
    last_evaluated_global_table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .global_tables = "GlobalTables",
        .last_evaluated_global_table_name = "LastEvaluatedGlobalTableName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGlobalTablesInput, options: CallOptions) !ListGlobalTablesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGlobalTablesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.ListGlobalTables");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGlobalTablesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListGlobalTablesOutput, body, allocator);
}

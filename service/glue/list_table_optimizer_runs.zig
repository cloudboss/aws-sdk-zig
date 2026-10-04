const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableOptimizerType = @import("table_optimizer_type.zig").TableOptimizerType;
const TableOptimizerRun = @import("table_optimizer_run.zig").TableOptimizerRun;

pub const ListTableOptimizerRunsInput = struct {
    /// The Catalog ID of the table.
    catalog_id: []const u8,

    /// The name of the database in the catalog in which the table resides.
    database_name: []const u8,

    /// The maximum number of optimizer runs to return on each call.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// The name of the table.
    table_name: []const u8,

    /// The type of table optimizer.
    @"type": TableOptimizerType,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .table_name = "TableName",
        .@"type" = "Type",
    };
};

pub const ListTableOptimizerRunsOutput = struct {
    /// The Catalog ID of the table.
    catalog_id: ?[]const u8 = null,

    /// The name of the database in the catalog in which the table resides.
    database_name: ?[]const u8 = null,

    /// A continuation token for paginating the returned list of optimizer runs,
    /// returned if the current segment of the list is not the last.
    next_token: ?[]const u8 = null,

    /// The name of the table.
    table_name: ?[]const u8 = null,

    /// A list of the optimizer runs associated with a table.
    table_optimizer_runs: ?[]const TableOptimizerRun = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .next_token = "NextToken",
        .table_name = "TableName",
        .table_optimizer_runs = "TableOptimizerRuns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTableOptimizerRunsInput, options: CallOptions) !ListTableOptimizerRunsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTableOptimizerRunsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListTableOptimizerRuns");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTableOptimizerRunsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTableOptimizerRunsOutput, body, allocator);
}

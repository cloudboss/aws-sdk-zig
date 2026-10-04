const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Database = @import("database.zig").Database;

pub const GetDatabaseInput = struct {
    /// The name of the data catalog that contains the database to return.
    catalog_name: []const u8,

    /// The name of the database to return.
    database_name: []const u8,

    /// The name of the workgroup for which the metadata is being fetched. Required
    /// if
    /// requesting an IAM Identity Center enabled Glue Data Catalog.
    work_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_name = "CatalogName",
        .database_name = "DatabaseName",
        .work_group = "WorkGroup",
    };
};

pub const GetDatabaseOutput = struct {
    /// The database returned.
    database: ?Database = null,

    pub const json_field_names = .{
        .database = "Database",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDatabaseInput, options: CallOptions) !GetDatabaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDatabaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.GetDatabase");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDatabaseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDatabaseOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserDefinedFunction = @import("user_defined_function.zig").UserDefinedFunction;

pub const GetUserDefinedFunctionInput = struct {
    /// The ID of the Data Catalog where the function to be retrieved is located. If
    /// none is
    /// provided, the Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The name of the catalog database where the function is located.
    database_name: []const u8,

    /// The name of the function.
    function_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .function_name = "FunctionName",
    };
};

pub const GetUserDefinedFunctionOutput = struct {
    /// The requested function definition.
    user_defined_function: ?UserDefinedFunction = null,

    pub const json_field_names = .{
        .user_defined_function = "UserDefinedFunction",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserDefinedFunctionInput, options: CallOptions) !GetUserDefinedFunctionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserDefinedFunctionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetUserDefinedFunction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserDefinedFunctionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetUserDefinedFunctionOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionType = @import("function_type.zig").FunctionType;
const UserDefinedFunction = @import("user_defined_function.zig").UserDefinedFunction;

pub const GetUserDefinedFunctionsInput = struct {
    /// The ID of the Data Catalog where the functions to be retrieved are located.
    /// If none is
    /// provided, the Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The name of the catalog database where the functions are located. If none is
    /// provided, functions from all the
    /// databases across the catalog will be returned.
    database_name: ?[]const u8 = null,

    /// An optional function-type pattern string that filters the function
    /// definitions returned from Amazon Redshift Federated Permissions Catalog.
    ///
    /// Specify a value of `REGULAR_FUNCTION` or `STORED_PROCEDURE`.
    /// The `STORED_PROCEDURE` function type is only compatible with
    /// Amazon Redshift Federated Permissions Catalog.
    function_type: ?FunctionType = null,

    /// The maximum number of functions to return in one response.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// An optional function-name pattern string that filters the function
    /// definitions returned.
    pattern: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .function_type = "FunctionType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .pattern = "Pattern",
    };
};

pub const GetUserDefinedFunctionsOutput = struct {
    /// A continuation token, if the list of functions returned does
    /// not include the last requested function.
    next_token: ?[]const u8 = null,

    /// A list of requested function definitions.
    user_defined_functions: ?[]const UserDefinedFunction = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .user_defined_functions = "UserDefinedFunctions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserDefinedFunctionsInput, options: CallOptions) !GetUserDefinedFunctionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserDefinedFunctionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetUserDefinedFunctions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserDefinedFunctionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetUserDefinedFunctionsOutput, body, allocator);
}

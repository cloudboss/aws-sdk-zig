const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutGraphqlApiEnvironmentVariablesInput = struct {
    /// The ID of the API to which the environmental variable list will be written.
    api_id: []const u8,

    /// The list of environmental variables to add to the API.
    ///
    /// When creating an environmental variable key-value pair, it must follow the
    /// additional
    /// constraints below:
    ///
    /// * Keys must begin with a letter.
    ///
    /// * Keys must be at least two characters long.
    ///
    /// * Keys can only contain letters, numbers, and the underscore character
    /// (_).
    ///
    /// * Values can be up to 512 characters long.
    ///
    /// * You can configure up to 50 key-value pairs in a GraphQL API.
    ///
    /// You can create a list of environmental variables by adding it to the
    /// `environmentVariables` payload as a list in the format
    /// `{"key1":"value1","key2":"value2", …}`. Note that each call of the
    /// `PutGraphqlApiEnvironmentVariables` action will result in the overwriting of
    /// the existing environmental variable list of that API. This means the
    /// existing environmental
    /// variables will be lost. To avoid this, you must include all existing and new
    /// environmental
    /// variables in the list each time you call this action.
    environment_variables: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .api_id = "apiId",
        .environment_variables = "environmentVariables",
    };
};

pub const PutGraphqlApiEnvironmentVariablesOutput = struct {
    /// The payload containing each environmental variable in the `"key" : "value"`
    /// format.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .environment_variables = "environmentVariables",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutGraphqlApiEnvironmentVariablesInput, options: CallOptions) !PutGraphqlApiEnvironmentVariablesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appsync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutGraphqlApiEnvironmentVariablesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/environmentVariables");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"environmentVariables\":");
    try aws.json.writeValue(@TypeOf(input.environment_variables), input.environment_variables, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutGraphqlApiEnvironmentVariablesOutput {
    var result: PutGraphqlApiEnvironmentVariablesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutGraphqlApiEnvironmentVariablesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

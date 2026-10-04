const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SelectColumn = @import("select_column.zig").SelectColumn;
const ParameterMapping = @import("parameter_mapping.zig").ParameterMapping;

pub const PrepareQueryInput = struct {
    /// The Timestream query string that you want to use as a prepared statement.
    /// Parameter
    /// names can be specified in the query string `@` character followed by an
    /// identifier.
    query_string: []const u8,

    /// By setting this value to `true`, Timestream will only validate that the
    /// query string is a valid Timestream query, and not store the prepared query
    /// for later
    /// use.
    validate_only: ?bool = null,

    pub const json_field_names = .{
        .query_string = "QueryString",
        .validate_only = "ValidateOnly",
    };
};

pub const PrepareQueryOutput = struct {
    /// A list of SELECT clause columns of the submitted query string.
    columns: ?[]const SelectColumn = null,

    /// A list of parameters used in the submitted query string.
    parameters: ?[]const ParameterMapping = null,

    /// The query string that you want prepare.
    query_string: []const u8,

    pub const json_field_names = .{
        .columns = "Columns",
        .parameters = "Parameters",
        .query_string = "QueryString",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PrepareQueryInput, options: CallOptions) !PrepareQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PrepareQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("query.timestream", "Timestream Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.PrepareQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PrepareQueryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PrepareQueryOutput, body, allocator);
}

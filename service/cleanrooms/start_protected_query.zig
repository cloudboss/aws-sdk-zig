const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;
const ProtectedQueryResultConfiguration = @import("protected_query_result_configuration.zig").ProtectedQueryResultConfiguration;
const ProtectedQuerySQLParameters = @import("protected_query_sql_parameters.zig").ProtectedQuerySQLParameters;
const ProtectedQueryType = @import("protected_query_type.zig").ProtectedQueryType;
const ProtectedQuery = @import("protected_query.zig").ProtectedQuery;

pub const StartProtectedQueryInput = struct {
    /// The compute configuration for the protected query.
    compute_configuration: ?ComputeConfiguration = null,

    /// A unique identifier for the membership to run this query against. Currently
    /// accepts a membership ID.
    membership_identifier: []const u8,

    /// The details needed to write the query results.
    result_configuration: ?ProtectedQueryResultConfiguration = null,

    /// The protected SQL query parameters.
    sql_parameters: ProtectedQuerySQLParameters,

    /// The type of the protected query to be started.
    @"type": ProtectedQueryType,

    pub const json_field_names = .{
        .compute_configuration = "computeConfiguration",
        .membership_identifier = "membershipIdentifier",
        .result_configuration = "resultConfiguration",
        .sql_parameters = "sqlParameters",
        .@"type" = "type",
    };
};

pub const StartProtectedQueryOutput = struct {
    /// The protected query.
    protected_query: ?ProtectedQuery = null,

    pub const json_field_names = .{
        .protected_query = "protectedQuery",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartProtectedQueryInput, options: CallOptions) !StartProtectedQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartProtectedQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/protectedQueries");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.compute_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"computeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.result_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resultConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sqlParameters\":");
    try aws.json.writeValue(@TypeOf(input.sql_parameters), input.sql_parameters, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartProtectedQueryOutput {
    var result: StartProtectedQueryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartProtectedQueryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationCheckOperation = @import("configuration_check_operation.zig").ConfigurationCheckOperation;

pub const GetConfigurationCheckOperationInput = struct {
    /// The ID of the configuration check operation.
    operation_id: []const u8,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub const GetConfigurationCheckOperationOutput = struct {
    /// Returns the details of a configuration check operation.
    configuration_check_operation: ?ConfigurationCheckOperation = null,

    pub const json_field_names = .{
        .configuration_check_operation = "ConfigurationCheckOperation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfigurationCheckOperationInput, options: CallOptions) !GetConfigurationCheckOperationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-sap", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfigurationCheckOperationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-sap", "Ssm Sap", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-configuration-check-operation";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OperationId\":");
    try aws.json.writeValue(@TypeOf(input.operation_id), input.operation_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigurationCheckOperationOutput {
    var result: GetConfigurationCheckOperationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConfigurationCheckOperationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

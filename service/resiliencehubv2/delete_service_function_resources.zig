const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteServiceFunctionResourcesInput = struct {
    /// The list of resources to remove from the service function.
    resources: []const []const u8,

    service_arn: []const u8,

    /// The identifier of the service function to remove resources from.
    service_function_id: []const u8,

    pub const json_field_names = .{
        .resources = "resources",
        .service_arn = "serviceArn",
        .service_function_id = "serviceFunctionId",
    };
};

pub const DeleteServiceFunctionResourcesOutput = struct {
    /// The list of resources that were removed.
    resources: ?[]const []const u8 = null,

    service_arn: ?[]const u8 = null,

    /// The identifier of the service function.
    service_function_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resources = "resources",
        .service_arn = "serviceArn",
        .service_function_id = "serviceFunctionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteServiceFunctionResourcesInput, options: CallOptions) !DeleteServiceFunctionResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteServiceFunctionResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/delete-service-function-resources";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resources\":");
    try aws.json.writeValue(@TypeOf(input.resources), input.resources, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceArn\":");
    try aws.json.writeValue(@TypeOf(input.service_arn), input.service_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceFunctionId\":");
    try aws.json.writeValue(@TypeOf(input.service_function_id), input.service_function_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteServiceFunctionResourcesOutput {
    const result: DeleteServiceFunctionResourcesOutput = try aws.json.parseJsonObject(
        DeleteServiceFunctionResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

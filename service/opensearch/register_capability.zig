const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapabilityBaseRequestConfig = @import("capability_base_request_config.zig").CapabilityBaseRequestConfig;
const CapabilityBaseResponseConfig = @import("capability_base_response_config.zig").CapabilityBaseResponseConfig;
const CapabilityStatus = @import("capability_status.zig").CapabilityStatus;

pub const RegisterCapabilityInput = struct {
    /// The unique identifier of the OpenSearch UI application to register the
    /// capability for.
    application_id: []const u8,

    /// The configuration settings for the capability being registered. This
    /// includes capability-specific settings such as AI configuration.
    capability_config: CapabilityBaseRequestConfig,

    /// The name of the capability to register. Must be between 3 and 30 characters
    /// and contain only alphanumeric characters and hyphens. This identifies the
    /// type of capability being enabled for the application. For registering AI
    /// Assistant capability, use `ai-capability`
    capability_name: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .capability_config = "capabilityConfig",
        .capability_name = "capabilityName",
    };
};

pub const RegisterCapabilityOutput = struct {
    /// The unique identifier of the OpenSearch UI application.
    application_id: ?[]const u8 = null,

    /// The configuration settings for the registered capability.
    capability_config: ?CapabilityBaseResponseConfig = null,

    /// The name of the registered capability.
    capability_name: ?[]const u8 = null,

    /// The current status of the capability. Possible values: `creating`,
    /// `create_failed`, `active`, `updating`, `update_failed`, `deleting`,
    /// `delete_failed`.
    status: ?CapabilityStatus = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .capability_config = "capabilityConfig",
        .capability_name = "capabilityName",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterCapabilityInput, options: CallOptions) !RegisterCapabilityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterCapabilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/application/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/capability/register");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"capabilityConfig\":");
    try aws.json.writeValue(@TypeOf(input.capability_config), input.capability_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"capabilityName\":");
    try aws.json.writeValue(@TypeOf(input.capability_name), input.capability_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterCapabilityOutput {
    var result: RegisterCapabilityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterCapabilityOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapabilityConfiguration = @import("capability_configuration.zig").CapabilityConfiguration;
const ServiceConfiguration = @import("service_configuration.zig").ServiceConfiguration;
const Association = @import("association.zig").Association;
const GenericWebhook = @import("generic_webhook.zig").GenericWebhook;

pub const AssociateServiceInput = struct {
    /// The unique identifier of the AgentSpace
    agent_space_id: []const u8,

    /// Enabled capabilities for this association.
    capabilities: ?[]const aws.map.MapEntry(CapabilityConfiguration) = null,

    /// The configuration that directs how AgentSpace interacts with the given
    /// service.
    configuration: ServiceConfiguration,

    /// The unique identifier of the service.
    service_id: []const u8,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .capabilities = "capabilities",
        .configuration = "configuration",
        .service_id = "serviceId",
    };
};

pub const AssociateServiceOutput = struct {
    association: ?Association = null,

    /// Generic webhook configuration
    webhook: ?GenericWebhook = null,

    pub const json_field_names = .{
        .association = "association",
        .webhook = "webhook",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateServiceInput, options: CallOptions) !AssociateServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/agentspaces/");
    try path_buf.appendSlice(allocator, input.agent_space_id);
    try path_buf.appendSlice(allocator, "/associations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceId\":");
    try aws.json.writeValue(@TypeOf(input.service_id), input.service_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateServiceOutput {
    const result: AssociateServiceOutput = try aws.json.parseJsonObject(
        AssociateServiceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

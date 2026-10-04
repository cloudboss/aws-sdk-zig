const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapabilityExtendedResponseConfig = @import("capability_extended_response_config.zig").CapabilityExtendedResponseConfig;
const CapabilityFailure = @import("capability_failure.zig").CapabilityFailure;
const CapabilityStatus = @import("capability_status.zig").CapabilityStatus;

pub const GetCapabilityInput = struct {
    /// The unique identifier of the OpenSearch UI application.
    application_id: []const u8,

    /// The name of the capability to retrieve information about.
    capability_name: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .capability_name = "capabilityName",
    };
};

pub const GetCapabilityOutput = struct {
    /// The unique identifier of the OpenSearch UI application.
    application_id: ?[]const u8 = null,

    /// The configuration settings for the capability, including capability-specific
    /// settings such as AI configuration.
    capability_config: ?CapabilityExtendedResponseConfig = null,

    /// The name of the capability.
    capability_name: ?[]const u8 = null,

    /// A list of failures associated with the capability, if any. Each failure
    /// includes a reason and details about what went wrong.
    failures: ?[]const CapabilityFailure = null,

    /// The current status of the capability. Possible values: `creating`,
    /// `create_failed`, `active`, `updating`, `update_failed`, `deleting`,
    /// `delete_failed`.
    status: ?CapabilityStatus = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .capability_config = "capabilityConfig",
        .capability_name = "capabilityName",
        .failures = "failures",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCapabilityInput, options: CallOptions) !GetCapabilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCapabilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/application/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/capability/");
    try path_buf.appendSlice(allocator, input.capability_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCapabilityOutput {
    const result: GetCapabilityOutput = try aws.json.parseJsonObject(
        GetCapabilityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

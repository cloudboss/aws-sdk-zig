const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ManifestOverridesPayload = @import("manifest_overrides_payload.zig").ManifestOverridesPayload;
const ManifestPayload = @import("manifest_payload.zig").ManifestPayload;

pub const DescribeApplicationInstanceDetailsInput = struct {
    /// The application instance's ID.
    application_instance_id: []const u8,

    pub const json_field_names = .{
        .application_instance_id = "ApplicationInstanceId",
    };
};

pub const DescribeApplicationInstanceDetailsOutput = struct {
    /// The application instance's ID.
    application_instance_id: ?[]const u8 = null,

    /// The ID of the application instance that this instance replaced.
    application_instance_id_to_replace: ?[]const u8 = null,

    /// When the application instance was created.
    created_time: ?i64 = null,

    /// The application instance's default runtime context device.
    default_runtime_context_device: ?[]const u8 = null,

    /// The application instance's description.
    description: ?[]const u8 = null,

    /// Parameter overrides for the configuration manifest.
    manifest_overrides_payload: ?ManifestOverridesPayload = null,

    /// The application instance's configuration manifest.
    manifest_payload: ?ManifestPayload = null,

    /// The application instance's name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_instance_id = "ApplicationInstanceId",
        .application_instance_id_to_replace = "ApplicationInstanceIdToReplace",
        .created_time = "CreatedTime",
        .default_runtime_context_device = "DefaultRuntimeContextDevice",
        .description = "Description",
        .manifest_overrides_payload = "ManifestOverridesPayload",
        .manifest_payload = "ManifestPayload",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeApplicationInstanceDetailsInput, options: CallOptions) !DescribeApplicationInstanceDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeApplicationInstanceDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/application-instances/");
    try path_buf.appendSlice(allocator, input.application_instance_id);
    try path_buf.appendSlice(allocator, "/details");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeApplicationInstanceDetailsOutput {
    var result: DescribeApplicationInstanceDetailsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeApplicationInstanceDetailsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

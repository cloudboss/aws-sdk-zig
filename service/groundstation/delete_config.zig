const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigCapabilityType = @import("config_capability_type.zig").ConfigCapabilityType;

pub const DeleteConfigInput = struct {
    /// UUID of a `Config`.
    config_id: []const u8,

    /// Type of a `Config`.
    config_type: ConfigCapabilityType,

    pub const json_field_names = .{
        .config_id = "configId",
        .config_type = "configType",
    };
};

pub const DeleteConfigOutput = struct {
    /// ARN of a `Config`.
    config_arn: ?[]const u8 = null,

    /// UUID of a `Config`.
    config_id: ?[]const u8 = null,

    /// Type of a `Config`.
    config_type: ?ConfigCapabilityType = null,

    pub const json_field_names = .{
        .config_arn = "configArn",
        .config_id = "configId",
        .config_type = "configType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteConfigInput, options: CallOptions) !DeleteConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/config/");
    try path_buf.appendSlice(allocator, input.config_type);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.config_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteConfigOutput {
    const result: DeleteConfigOutput = try aws.json.parseJsonObject(
        DeleteConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigCapabilityType = @import("config_capability_type.zig").ConfigCapabilityType;
const ConfigTypeData = @import("config_type_data.zig").ConfigTypeData;

pub const GetConfigInput = struct {
    /// UUID of a `Config`.
    config_id: []const u8,

    /// Type of a `Config`.
    config_type: ConfigCapabilityType,

    pub const json_field_names = .{
        .config_id = "configId",
        .config_type = "configType",
    };
};

pub const GetConfigOutput = struct {
    /// ARN of a `Config`
    config_arn: []const u8,

    /// Data elements in a `Config`.
    config_data: ?ConfigTypeData = null,

    /// UUID of a `Config`.
    config_id: []const u8,

    /// Type of a `Config`.
    config_type: ?ConfigCapabilityType = null,

    /// Name of a `Config`.
    name: []const u8,

    /// Tags assigned to a `Config`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .config_arn = "configArn",
        .config_data = "configData",
        .config_id = "configId",
        .config_type = "configType",
        .name = "name",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfigInput, options: CallOptions) !GetConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/config/");
    try path_buf.appendSlice(allocator, input.config_type.wireName());
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.config_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigOutput {
    const result: GetConfigOutput = try aws.json.parseJsonObject(
        GetConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

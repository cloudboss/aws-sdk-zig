const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Authorization = @import("authorization.zig").Authorization;
const CmafPackage = @import("cmaf_package.zig").CmafPackage;
const DashPackage = @import("dash_package.zig").DashPackage;
const HlsPackage = @import("hls_package.zig").HlsPackage;
const MssPackage = @import("mss_package.zig").MssPackage;
const Origination = @import("origination.zig").Origination;

pub const DescribeOriginEndpointInput = struct {
    /// The ID of the OriginEndpoint.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const DescribeOriginEndpointOutput = struct {
    /// The Amazon Resource Name (ARN) assigned to the OriginEndpoint.
    arn: ?[]const u8 = null,

    authorization: ?Authorization = null,

    /// The ID of the Channel the OriginEndpoint is associated with.
    channel_id: ?[]const u8 = null,

    cmaf_package: ?CmafPackage = null,

    /// The date and time the OriginEndpoint was created.
    created_at: ?[]const u8 = null,

    dash_package: ?DashPackage = null,

    /// A short text description of the OriginEndpoint.
    description: ?[]const u8 = null,

    hls_package: ?HlsPackage = null,

    /// The ID of the OriginEndpoint.
    id: ?[]const u8 = null,

    /// A short string appended to the end of the OriginEndpoint URL.
    manifest_name: ?[]const u8 = null,

    mss_package: ?MssPackage = null,

    /// Control whether origination of video is allowed for this OriginEndpoint. If
    /// set to ALLOW, the OriginEndpoint
    /// may by requested, pursuant to any other form of access control. If set to
    /// DENY, the OriginEndpoint may not be
    /// requested. This can be helpful for Live to VOD harvesting, or for
    /// temporarily disabling origination
    origination: ?Origination = null,

    /// Maximum duration (seconds) of content to retain for startover playback.
    /// If not specified, startover playback will be disabled for the
    /// OriginEndpoint.
    startover_window_seconds: ?i32 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    /// Amount of delay (seconds) to enforce on the playback of live content.
    /// If not specified, there will be no time delay in effect for the
    /// OriginEndpoint.
    time_delay_seconds: ?i32 = null,

    /// The URL of the packaged OriginEndpoint for consumption.
    url: ?[]const u8 = null,

    /// A list of source IP CIDR blocks that will be allowed to access the
    /// OriginEndpoint.
    whitelist: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .authorization = "Authorization",
        .channel_id = "ChannelId",
        .cmaf_package = "CmafPackage",
        .created_at = "CreatedAt",
        .dash_package = "DashPackage",
        .description = "Description",
        .hls_package = "HlsPackage",
        .id = "Id",
        .manifest_name = "ManifestName",
        .mss_package = "MssPackage",
        .origination = "Origination",
        .startover_window_seconds = "StartoverWindowSeconds",
        .tags = "Tags",
        .time_delay_seconds = "TimeDelaySeconds",
        .url = "Url",
        .whitelist = "Whitelist",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOriginEndpointInput, options: CallOptions) !DescribeOriginEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediapackage");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOriginEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackage", "MediaPackage", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/origin_endpoints/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOriginEndpointOutput {
    var result: DescribeOriginEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeOriginEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

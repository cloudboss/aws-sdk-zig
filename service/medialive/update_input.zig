const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InputDestinationRequest = @import("input_destination_request.zig").InputDestinationRequest;
const InputDeviceRequest = @import("input_device_request.zig").InputDeviceRequest;
const MediaConnectFlowRequest = @import("media_connect_flow_request.zig").MediaConnectFlowRequest;
const MulticastSettingsUpdateRequest = @import("multicast_settings_update_request.zig").MulticastSettingsUpdateRequest;
const Smpte2110ReceiverGroupSettings = @import("smpte_2110_receiver_group_settings.zig").Smpte2110ReceiverGroupSettings;
const InputSourceRequest = @import("input_source_request.zig").InputSourceRequest;
const SpecialRouterSettings = @import("special_router_settings.zig").SpecialRouterSettings;
const SrtSettingsRequest = @import("srt_settings_request.zig").SrtSettingsRequest;
const Input = @import("input.zig").Input;

pub const UpdateInputInput = struct {
    /// Destination settings for PUSH type inputs.
    destinations: ?[]const InputDestinationRequest = null,

    /// Settings for the devices.
    input_devices: ?[]const InputDeviceRequest = null,

    /// Unique ID of the input.
    input_id: []const u8,

    /// A list of security groups referenced by IDs to attach to the input.
    input_security_groups: ?[]const []const u8 = null,

    /// A list of the MediaConnect Flow ARNs that you want to use as the source of
    /// the input. You can specify as few as one
    /// Flow and presently, as many as two. The only requirement is when you have
    /// more than one is that each Flow is in a
    /// separate Availability Zone as this ensures your EML input is redundant to AZ
    /// issues.
    media_connect_flows: ?[]const MediaConnectFlowRequest = null,

    /// Multicast Input settings.
    multicast_settings: ?MulticastSettingsUpdateRequest = null,

    /// Name of the input.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the role this input assumes during and
    /// after creation.
    role_arn: ?[]const u8 = null,

    sdi_sources: ?[]const []const u8 = null,

    /// Include this parameter if the input is a SMPTE 2110 input, to identify the
    /// stream sources for this input.
    smpte_2110_receiver_group_settings: ?Smpte2110ReceiverGroupSettings = null,

    /// The source URLs for a PULL-type input. Every PULL type input needs
    /// exactly two source URLs for redundancy.
    /// Only specify sources for PULL type Inputs. Leave Destinations empty.
    sources: ?[]const InputSourceRequest = null,

    /// When using MediaConnect Router as the source of a MediaLive input there's a
    /// special handoff that occurs when a router output
    /// is created. This group of settings is set on your behalf by the MediaConnect
    /// Router service using this set of settings. This
    /// setting object can only by used by that service.
    special_router_settings: ?SpecialRouterSettings = null,

    /// The settings associated with an SRT input.
    srt_settings: ?SrtSettingsRequest = null,

    pub const json_field_names = .{
        .destinations = "Destinations",
        .input_devices = "InputDevices",
        .input_id = "InputId",
        .input_security_groups = "InputSecurityGroups",
        .media_connect_flows = "MediaConnectFlows",
        .multicast_settings = "MulticastSettings",
        .name = "Name",
        .role_arn = "RoleArn",
        .sdi_sources = "SdiSources",
        .smpte_2110_receiver_group_settings = "Smpte2110ReceiverGroupSettings",
        .sources = "Sources",
        .special_router_settings = "SpecialRouterSettings",
        .srt_settings = "SrtSettings",
    };
};

pub const UpdateInputOutput = struct {
    input: ?Input = null,

    pub const json_field_names = .{
        .input = "Input",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInputInput, options: Options) !UpdateInputOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medialive");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateInputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/prod/inputs/");
    try path_buf.appendSlice(alloc, input.input_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.destinations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Destinations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.input_devices) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"InputDevices\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.input_security_groups) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"InputSecurityGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.media_connect_flows) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MediaConnectFlows\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.multicast_settings) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MulticastSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"RoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sdi_sources) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SdiSources\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.smpte_2110_receiver_group_settings) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Smpte2110ReceiverGroupSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sources) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Sources\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.special_router_settings) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SpecialRouterSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.srt_settings) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SrtSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateInputOutput {
    var result: UpdateInputOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateInputOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GatewayTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .gateway_timeout_exception = .{
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

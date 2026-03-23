const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InputDestination = @import("input_destination.zig").InputDestination;
const InputClass = @import("input_class.zig").InputClass;
const InputDeviceSettings = @import("input_device_settings.zig").InputDeviceSettings;
const InputNetworkLocation = @import("input_network_location.zig").InputNetworkLocation;
const InputSourceType = @import("input_source_type.zig").InputSourceType;
const MediaConnectFlow = @import("media_connect_flow.zig").MediaConnectFlow;
const MulticastSettings = @import("multicast_settings.zig").MulticastSettings;
const RouterInputSettings = @import("router_input_settings.zig").RouterInputSettings;
const Smpte2110ReceiverGroupSettings = @import("smpte_2110_receiver_group_settings.zig").Smpte2110ReceiverGroupSettings;
const InputSource = @import("input_source.zig").InputSource;
const SrtSettings = @import("srt_settings.zig").SrtSettings;
const InputState = @import("input_state.zig").InputState;
const InputType = @import("input_type.zig").InputType;

pub const DescribeInputInput = struct {
    /// Unique ID of the input
    input_id: []const u8,

    pub const json_field_names = .{
        .input_id = "InputId",
    };
};

pub const DescribeInputOutput = struct {
    /// The Unique ARN of the input (generated, immutable).
    arn: ?[]const u8 = null,

    /// A list of channel IDs that that input is attached to (currently an input can
    /// only be attached to one channel).
    attached_channels: ?[]const []const u8 = null,

    /// A list of the destinations of the input (PUSH-type).
    destinations: ?[]const InputDestination = null,

    /// The generated ID of the input (unique for user account, immutable).
    id: ?[]const u8 = null,

    /// STANDARD - MediaLive expects two sources to be connected to this input. If
    /// the channel is also STANDARD, both sources will be ingested. If the channel
    /// is SINGLE_PIPELINE, only the first source will be ingested; the second
    /// source will always be ignored, even if the first source fails.
    /// SINGLE_PIPELINE - You can connect only one source to this input. If the
    /// ChannelClass is also SINGLE_PIPELINE, this value is valid. If the
    /// ChannelClass is STANDARD, this value is not valid because the channel
    /// requires two sources in the input.
    input_class: ?InputClass = null,

    /// Settings for the input devices.
    input_devices: ?[]const InputDeviceSettings = null,

    /// The location of this input. AWS, for an input existing in the AWS Cloud,
    /// On-Prem for
    /// an input in a customer network.
    input_network_location: ?InputNetworkLocation = null,

    /// A list of IDs for all Inputs which are partners of this one.
    input_partner_ids: ?[]const []const u8 = null,

    /// Certain pull input sources can be dynamic, meaning that they can have their
    /// URL's dynamically changes
    /// during input switch actions. Presently, this functionality only works with
    /// MP4_FILE and TS_FILE inputs.
    input_source_type: ?InputSourceType = null,

    /// A list of MediaConnect Flows for this input.
    media_connect_flows: ?[]const MediaConnectFlow = null,

    /// Multicast Input settings.
    multicast_settings: ?MulticastSettings = null,

    /// The user-assigned name (This is a mutable value).
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the role this input assumes during and
    /// after creation.
    role_arn: ?[]const u8 = null,

    /// Information about any MediaConnect router association with this input.
    router_settings: ?RouterInputSettings = null,

    sdi_sources: ?[]const []const u8 = null,

    /// A list of IDs for all the Input Security Groups attached to the input.
    security_groups: ?[]const []const u8 = null,

    /// Include this parameter if the input is a SMPTE 2110 input, to identify the
    /// stream sources for this input.
    smpte_2110_receiver_group_settings: ?Smpte2110ReceiverGroupSettings = null,

    /// A list of the sources of the input (PULL-type).
    sources: ?[]const InputSource = null,

    /// The settings associated with an SRT input.
    srt_settings: ?SrtSettings = null,

    state: ?InputState = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    @"type": ?InputType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .attached_channels = "AttachedChannels",
        .destinations = "Destinations",
        .id = "Id",
        .input_class = "InputClass",
        .input_devices = "InputDevices",
        .input_network_location = "InputNetworkLocation",
        .input_partner_ids = "InputPartnerIds",
        .input_source_type = "InputSourceType",
        .media_connect_flows = "MediaConnectFlows",
        .multicast_settings = "MulticastSettings",
        .name = "Name",
        .role_arn = "RoleArn",
        .router_settings = "RouterSettings",
        .sdi_sources = "SdiSources",
        .security_groups = "SecurityGroups",
        .smpte_2110_receiver_group_settings = "Smpte2110ReceiverGroupSettings",
        .sources = "Sources",
        .srt_settings = "SrtSettings",
        .state = "State",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInputInput, options: CallOptions) !DescribeInputOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medialive");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/prod/inputs/");
    try path_buf.appendSlice(allocator, input.input_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInputOutput {
    var result: DescribeInputOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeInputOutput, body, allocator);
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

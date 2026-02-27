const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DescribeAnywhereSettings = @import("describe_anywhere_settings.zig").DescribeAnywhereSettings;
const CdiInputSpecification = @import("cdi_input_specification.zig").CdiInputSpecification;
const ChannelClass = @import("channel_class.zig").ChannelClass;
const ChannelEngineVersionResponse = @import("channel_engine_version_response.zig").ChannelEngineVersionResponse;
const OutputDestination = @import("output_destination.zig").OutputDestination;
const ChannelEgressEndpoint = @import("channel_egress_endpoint.zig").ChannelEgressEndpoint;
const EncoderSettings = @import("encoder_settings.zig").EncoderSettings;
const InputAttachment = @import("input_attachment.zig").InputAttachment;
const InputSpecification = @import("input_specification.zig").InputSpecification;
const DescribeLinkedChannelSettings = @import("describe_linked_channel_settings.zig").DescribeLinkedChannelSettings;
const LogLevel = @import("log_level.zig").LogLevel;
const MaintenanceStatus = @import("maintenance_status.zig").MaintenanceStatus;
const PipelineDetail = @import("pipeline_detail.zig").PipelineDetail;
const ChannelState = @import("channel_state.zig").ChannelState;
const VpcOutputSettingsDescription = @import("vpc_output_settings_description.zig").VpcOutputSettingsDescription;

pub const StartChannelInput = struct {
    /// A request to start a channel
    channel_id: []const u8,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
    };
};

pub const StartChannelOutput = struct {
    /// Anywhere settings for this channel.
    anywhere_settings: ?DescribeAnywhereSettings = null,

    /// The unique arn of the channel.
    arn: ?[]const u8 = null,

    /// Specification of CDI inputs for this channel
    cdi_input_specification: ?CdiInputSpecification = null,

    /// The class for this channel. STANDARD for a channel with two pipelines or
    /// SINGLE_PIPELINE for a channel with one pipeline.
    channel_class: ?ChannelClass = null,

    /// Requested engine version for this channel.
    channel_engine_version: ?ChannelEngineVersionResponse = null,

    /// A list of IDs for all the Input Security Groups attached to the channel.
    channel_security_groups: ?[]const []const u8 = null,

    /// A list of destinations of the channel. For UDP outputs, there is one
    /// destination per output. For other types (HLS, for example), there is
    /// one destination per packager.
    destinations: ?[]const OutputDestination = null,

    /// The endpoints where outgoing connections initiate from
    egress_endpoints: ?[]const ChannelEgressEndpoint = null,

    encoder_settings: ?EncoderSettings = null,

    /// The unique id of the channel.
    id: ?[]const u8 = null,

    /// List of input attachments for channel.
    input_attachments: ?[]const InputAttachment = null,

    /// Specification of network and file inputs for this channel
    input_specification: ?InputSpecification = null,

    /// Linked Channel Settings for this channel.
    linked_channel_settings: ?DescribeLinkedChannelSettings = null,

    /// The log level being written to CloudWatch Logs.
    log_level: ?LogLevel = null,

    /// Maintenance settings for this channel.
    maintenance: ?MaintenanceStatus = null,

    /// The name of the channel. (user-mutable)
    name: ?[]const u8 = null,

    /// Runtime details for the pipelines of a running channel.
    pipeline_details: ?[]const PipelineDetail = null,

    /// The number of currently healthy pipelines.
    pipelines_running_count: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the role assumed when running the Channel.
    role_arn: ?[]const u8 = null,

    state: ?ChannelState = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Settings for VPC output
    vpc: ?VpcOutputSettingsDescription = null,

    pub const json_field_names = .{
        .anywhere_settings = "AnywhereSettings",
        .arn = "Arn",
        .cdi_input_specification = "CdiInputSpecification",
        .channel_class = "ChannelClass",
        .channel_engine_version = "ChannelEngineVersion",
        .channel_security_groups = "ChannelSecurityGroups",
        .destinations = "Destinations",
        .egress_endpoints = "EgressEndpoints",
        .encoder_settings = "EncoderSettings",
        .id = "Id",
        .input_attachments = "InputAttachments",
        .input_specification = "InputSpecification",
        .linked_channel_settings = "LinkedChannelSettings",
        .log_level = "LogLevel",
        .maintenance = "Maintenance",
        .name = "Name",
        .pipeline_details = "PipelineDetails",
        .pipelines_running_count = "PipelinesRunningCount",
        .role_arn = "RoleArn",
        .state = "State",
        .tags = "Tags",
        .vpc = "Vpc",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartChannelInput, options: Options) !StartChannelOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: StartChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/prod/channels/");
    try path_buf.appendSlice(alloc, input.channel_id);
    try path_buf.appendSlice(alloc, "/start");
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartChannelOutput {
    var result: StartChannelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartChannelOutput, body, alloc);
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

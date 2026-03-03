const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EncodingConfig = @import("encoding_config.zig").EncodingConfig;
const GrantEntitlementRequest = @import("grant_entitlement_request.zig").GrantEntitlementRequest;
const FlowSize = @import("flow_size.zig").FlowSize;
const AddMaintenance = @import("add_maintenance.zig").AddMaintenance;
const AddMediaStreamRequest = @import("add_media_stream_request.zig").AddMediaStreamRequest;
const NdiConfig = @import("ndi_config.zig").NdiConfig;
const AddOutputRequest = @import("add_output_request.zig").AddOutputRequest;
const SetSourceRequest = @import("set_source_request.zig").SetSourceRequest;
const FailoverConfig = @import("failover_config.zig").FailoverConfig;
const MonitoringConfig = @import("monitoring_config.zig").MonitoringConfig;
const VpcInterfaceRequest = @import("vpc_interface_request.zig").VpcInterfaceRequest;
const Flow = @import("flow.zig").Flow;

pub const CreateFlowInput = struct {
    /// The Availability Zone that you want to create the flow in. These options are
    /// limited to the Availability Zones within the current Amazon Web Services
    /// Region.
    availability_zone: ?[]const u8 = null,

    encoding_config: ?EncodingConfig = null,

    /// The entitlements that you want to grant on a flow.
    entitlements: ?[]const GrantEntitlementRequest = null,

    /// Determines the processing capacity and feature set of the flow. Set this
    /// optional parameter to `LARGE` if you want to enable NDI sources or outputs
    /// on the flow.
    flow_size: ?FlowSize = null,

    /// The key-value pairs that can be used to tag and organize the flow.
    flow_tags: ?[]const aws.map.StringMapEntry = null,

    /// The maintenance settings you want to use for the flow.
    maintenance: ?AddMaintenance = null,

    /// The media streams that you want to add to the flow. You can associate these
    /// media streams with sources and outputs on the flow.
    media_streams: ?[]const AddMediaStreamRequest = null,

    /// The name of the flow.
    name: []const u8,

    /// Specifies the configuration settings for a flow's NDI source or output.
    /// Required when the flow includes an NDI source or output.
    ndi_config: ?NdiConfig = null,

    /// The outputs that you want to add to this flow.
    outputs: ?[]const AddOutputRequest = null,

    /// The settings for the source that you want to use for the new flow.
    source: ?SetSourceRequest = null,

    /// The settings for source failover.
    source_failover_config: ?FailoverConfig = null,

    /// The settings for source monitoring.
    source_monitoring_config: ?MonitoringConfig = null,

    /// The sources that are assigned to the flow.
    sources: ?[]const SetSourceRequest = null,

    /// The VPC interfaces you want on the flow.
    vpc_interfaces: ?[]const VpcInterfaceRequest = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .encoding_config = "EncodingConfig",
        .entitlements = "Entitlements",
        .flow_size = "FlowSize",
        .flow_tags = "FlowTags",
        .maintenance = "Maintenance",
        .media_streams = "MediaStreams",
        .name = "Name",
        .ndi_config = "NdiConfig",
        .outputs = "Outputs",
        .source = "Source",
        .source_failover_config = "SourceFailoverConfig",
        .source_monitoring_config = "SourceMonitoringConfig",
        .sources = "Sources",
        .vpc_interfaces = "VpcInterfaces",
    };
};

pub const CreateFlowOutput = struct {
    /// The flow that you created.
    flow: ?Flow = null,

    pub const json_field_names = .{
        .flow = "Flow",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFlowInput, options: Options) !CreateFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediaconnect");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/flows";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.availability_zone) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AvailabilityZone\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encoding_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncodingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entitlements) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Entitlements\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.flow_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FlowSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.flow_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FlowTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maintenance) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Maintenance\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.media_streams) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MediaStreams\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.ndi_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NdiConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.outputs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Outputs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Source\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_failover_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceFailoverConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_monitoring_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceMonitoringConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Sources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_interfaces) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcInterfaces\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFlowOutput {
    var result: CreateFlowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFlowOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AddFlowOutputs420Exception")) {
        return .{ .arena = arena, .kind = .{ .add_flow_outputs_420_exception = .{
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
    if (std.mem.eql(u8, error_code, "CreateBridge420Exception")) {
        return .{ .arena = arena, .kind = .{ .create_bridge_420_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreateFlow420Exception")) {
        return .{ .arena = arena, .kind = .{ .create_flow_420_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreateGateway420Exception")) {
        return .{ .arena = arena, .kind = .{ .create_gateway_420_exception = .{
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
    if (std.mem.eql(u8, error_code, "GrantFlowEntitlements420Exception")) {
        return .{ .arena = arena, .kind = .{ .grant_flow_entitlements_420_exception = .{
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
    if (std.mem.eql(u8, error_code, "RouterInputServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .router_input_service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RouterNetworkInterfaceServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .router_network_interface_service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RouterOutputServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .router_output_service_quota_exceeded_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const UpdateEncryption = @import("update_encryption.zig").UpdateEncryption;
const MediaStreamOutputConfigurationRequest = @import("media_stream_output_configuration_request.zig").MediaStreamOutputConfigurationRequest;
const OutputStatus = @import("output_status.zig").OutputStatus;
const Protocol = @import("protocol.zig").Protocol;
const State = @import("state.zig").State;
const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;
const VpcInterfaceAttachment = @import("vpc_interface_attachment.zig").VpcInterfaceAttachment;
const Output = @import("output.zig").Output;

pub const UpdateFlowOutputInput = struct {
    /// The range of IP addresses that should be allowed to initiate output requests
    /// to this flow. These IP addresses should be in the form of a Classless
    /// Inter-Domain Routing (CIDR) block; for example, 10.0.0.0/16.
    cidr_allow_list: ?[]const []const u8 = null,

    /// A description of the output. This description appears only on the
    /// MediaConnect console and will not be seen by the end user.
    description: ?[]const u8 = null,

    /// The IP address where you want to send the output.
    destination: ?[]const u8 = null,

    /// The type of key used for the encryption. If no `keyType` is provided, the
    /// service will use the default setting (static-key). Allowable encryption
    /// types: static-key.
    encryption: ?UpdateEncryption = null,

    /// The Amazon Resource Name (ARN) of the flow that is associated with the
    /// output that you want to update.
    flow_arn: []const u8,

    /// The maximum latency in milliseconds. This parameter applies only to
    /// RIST-based and Zixi-based streams.
    max_latency: ?i32 = null,

    /// The media streams that are associated with the output, and the parameters
    /// for those associations.
    media_stream_output_configurations: ?[]const MediaStreamOutputConfigurationRequest = null,

    /// The minimum latency in milliseconds for SRT-based streams. In streams that
    /// use the SRT protocol, this value that you set on your MediaConnect source or
    /// output represents the minimal potential latency of that connection. The
    /// latency of the stream is set to the highest number between the sender’s
    /// minimum latency and the receiver’s minimum latency.
    min_latency: ?i32 = null,

    /// A suffix for the name of the NDI® sender that the flow creates. If a custom
    /// name isn't specified, MediaConnect uses the output name.
    ndi_program_name: ?[]const u8 = null,

    /// A quality setting for the NDI Speed HQ encoder.
    ndi_speed_hq_quality: ?i32 = null,

    /// The ARN of the output that you want to update.
    output_arn: []const u8,

    /// An indication of whether the output should transmit data or not. If you
    /// don't specify the `outputStatus` field in your request, MediaConnect leaves
    /// the value unchanged.
    output_status: ?OutputStatus = null,

    /// The port to use when content is distributed to this output.
    port: ?i32 = null,

    /// The protocol to use for the output.
    ///
    /// Elemental MediaConnect no longer supports the Fujitsu QoS protocol. This
    /// reference is maintained for legacy purposes only.
    protocol: ?Protocol = null,

    /// The remote ID for the Zixi-pull stream.
    remote_id: ?[]const u8 = null,

    /// Indicates whether to enable or disable router integration for this flow
    /// output.
    router_integration_state: ?State = null,

    router_integration_transit_encryption: ?FlowTransitEncryption = null,

    /// The port that the flow uses to send outbound requests to initiate connection
    /// with the sender.
    sender_control_port: ?i32 = null,

    /// The IP address that the flow communicates with to initiate connection with
    /// the sender.
    sender_ip_address: ?[]const u8 = null,

    /// The smoothing latency in milliseconds for RIST, RTP, and RTP-FEC streams.
    smoothing_latency: ?i32 = null,

    /// The stream ID that you want to use for this transport. This parameter
    /// applies only to Zixi and SRT caller-based streams.
    stream_id: ?[]const u8 = null,

    /// The name of the VPC interface attachment to use for this output.
    vpc_interface_attachment: ?VpcInterfaceAttachment = null,

    pub const json_field_names = .{
        .cidr_allow_list = "CidrAllowList",
        .description = "Description",
        .destination = "Destination",
        .encryption = "Encryption",
        .flow_arn = "FlowArn",
        .max_latency = "MaxLatency",
        .media_stream_output_configurations = "MediaStreamOutputConfigurations",
        .min_latency = "MinLatency",
        .ndi_program_name = "NdiProgramName",
        .ndi_speed_hq_quality = "NdiSpeedHqQuality",
        .output_arn = "OutputArn",
        .output_status = "OutputStatus",
        .port = "Port",
        .protocol = "Protocol",
        .remote_id = "RemoteId",
        .router_integration_state = "RouterIntegrationState",
        .router_integration_transit_encryption = "RouterIntegrationTransitEncryption",
        .sender_control_port = "SenderControlPort",
        .sender_ip_address = "SenderIpAddress",
        .smoothing_latency = "SmoothingLatency",
        .stream_id = "StreamId",
        .vpc_interface_attachment = "VpcInterfaceAttachment",
    };
};

pub const UpdateFlowOutputOutput = struct {
    /// The ARN of the flow that is associated with the updated output.
    flow_arn: ?[]const u8 = null,

    /// The new settings of the output that you updated.
    output: ?Output = null,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .output = "Output",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFlowOutputInput, options: Options) !UpdateFlowOutputOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFlowOutputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v1/flows/");
    try path_buf.appendSlice(allocator, input.flow_arn);
    try path_buf.appendSlice(allocator, "/outputs/");
    try path_buf.appendSlice(allocator, input.output_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cidr_allow_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CidrAllowList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Destination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Encryption\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_latency) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxLatency\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.media_stream_output_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MediaStreamOutputConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.min_latency) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MinLatency\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ndi_program_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NdiProgramName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ndi_speed_hq_quality) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NdiSpeedHqQuality\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.output_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OutputStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.port) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Port\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.protocol) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Protocol\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remote_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RemoteId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.router_integration_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RouterIntegrationState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.router_integration_transit_encryption) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RouterIntegrationTransitEncryption\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sender_control_port) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SenderControlPort\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sender_ip_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SenderIpAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.smoothing_latency) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SmoothingLatency\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_interface_attachment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcInterfaceAttachment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFlowOutputOutput {
    var result: UpdateFlowOutputOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFlowOutputOutput, body, allocator);
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

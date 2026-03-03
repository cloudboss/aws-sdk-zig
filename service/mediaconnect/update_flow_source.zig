const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UpdateEncryption = @import("update_encryption.zig").UpdateEncryption;
const UpdateGatewayBridgeSourceRequest = @import("update_gateway_bridge_source_request.zig").UpdateGatewayBridgeSourceRequest;
const MediaStreamSourceConfigurationRequest = @import("media_stream_source_configuration_request.zig").MediaStreamSourceConfigurationRequest;
const NdiSourceSettings = @import("ndi_source_settings.zig").NdiSourceSettings;
const Protocol = @import("protocol.zig").Protocol;
const State = @import("state.zig").State;
const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;
const Source = @import("source.zig").Source;

pub const UpdateFlowSourceInput = struct {
    /// The type of encryption that is used on the content ingested from the source.
    decryption: ?UpdateEncryption = null,

    /// A description of the source. This description is not visible outside of the
    /// current Amazon Web Services account.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the entitlement that allows you to
    /// subscribe to the flow. The entitlement is set by the content originator, and
    /// the ARN is generated as part of the originator's flow.
    entitlement_arn: ?[]const u8 = null,

    /// The ARN of the flow that you want to update.
    flow_arn: []const u8,

    /// The source configuration for cloud flows receiving a stream from a bridge.
    gateway_bridge_source: ?UpdateGatewayBridgeSourceRequest = null,

    /// The port that the flow listens on for incoming content. If the protocol of
    /// the source is Zixi, the port must be set to 2088.
    ingest_port: ?i32 = null,

    /// The maximum bitrate for RIST, RTP, and RTP-FEC streams.
    max_bitrate: ?i32 = null,

    /// The maximum latency in milliseconds. This parameter applies only to
    /// RIST-based and Zixi-based streams.
    max_latency: ?i32 = null,

    /// The size of the buffer (in milliseconds) to use to sync incoming source
    /// data.
    max_sync_buffer: ?i32 = null,

    /// The media stream that is associated with the source, and the parameters for
    /// that association.
    media_stream_source_configurations: ?[]const MediaStreamSourceConfigurationRequest = null,

    /// The minimum latency in milliseconds for SRT-based streams. In streams that
    /// use the SRT protocol, this value that you set on your MediaConnect source or
    /// output represents the minimal potential latency of that connection. The
    /// latency of the stream is set to the highest number between the sender’s
    /// minimum latency and the receiver’s minimum latency.
    min_latency: ?i32 = null,

    /// The settings for the NDI source. This includes the exact name of the
    /// upstream NDI sender that you want to connect to your source.
    ndi_source_settings: ?NdiSourceSettings = null,

    /// The protocol that the source uses to deliver the content to MediaConnect.
    ///
    /// Elemental MediaConnect no longer supports the Fujitsu QoS protocol. This
    /// reference is maintained for legacy purposes only.
    protocol: ?Protocol = null,

    /// Indicates whether to enable or disable router integration for this flow
    /// source.
    router_integration_state: ?State = null,

    /// The encryption configuration for the flow source when router integration is
    /// enabled.
    router_integration_transit_decryption: ?FlowTransitEncryption = null,

    /// The port that the flow uses to send outbound requests to initiate connection
    /// with the sender.
    sender_control_port: ?i32 = null,

    /// The IP address that the flow communicates with to initiate connection with
    /// the sender.
    sender_ip_address: ?[]const u8 = null,

    /// The ARN of the source that you want to update.
    source_arn: []const u8,

    /// The source IP or domain name for SRT-caller protocol.
    source_listener_address: ?[]const u8 = null,

    /// Source port for SRT-caller protocol.
    source_listener_port: ?i32 = null,

    /// The stream ID that you want to use for this transport. This parameter
    /// applies only to Zixi and SRT caller-based streams.
    stream_id: ?[]const u8 = null,

    /// The name of the VPC interface that you want to send your output to.
    vpc_interface_name: ?[]const u8 = null,

    /// The range of IP addresses that are allowed to contribute content to your
    /// source. Format the IP addresses as a Classless Inter-Domain Routing (CIDR)
    /// block; for example, 10.0.0.0/16.
    whitelist_cidr: ?[]const u8 = null,

    pub const json_field_names = .{
        .decryption = "Decryption",
        .description = "Description",
        .entitlement_arn = "EntitlementArn",
        .flow_arn = "FlowArn",
        .gateway_bridge_source = "GatewayBridgeSource",
        .ingest_port = "IngestPort",
        .max_bitrate = "MaxBitrate",
        .max_latency = "MaxLatency",
        .max_sync_buffer = "MaxSyncBuffer",
        .media_stream_source_configurations = "MediaStreamSourceConfigurations",
        .min_latency = "MinLatency",
        .ndi_source_settings = "NdiSourceSettings",
        .protocol = "Protocol",
        .router_integration_state = "RouterIntegrationState",
        .router_integration_transit_decryption = "RouterIntegrationTransitDecryption",
        .sender_control_port = "SenderControlPort",
        .sender_ip_address = "SenderIpAddress",
        .source_arn = "SourceArn",
        .source_listener_address = "SourceListenerAddress",
        .source_listener_port = "SourceListenerPort",
        .stream_id = "StreamId",
        .vpc_interface_name = "VpcInterfaceName",
        .whitelist_cidr = "WhitelistCidr",
    };
};

pub const UpdateFlowSourceOutput = struct {
    /// The ARN of the flow that you updated.
    flow_arn: ?[]const u8 = null,

    /// The details of the sources that are assigned to the flow.
    source: ?Source = null,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .source = "Source",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFlowSourceInput, options: CallOptions) !UpdateFlowSourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFlowSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v1/flows/");
    try path_buf.appendSlice(allocator, input.flow_arn);
    try path_buf.appendSlice(allocator, "/source/");
    try path_buf.appendSlice(allocator, input.source_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.decryption) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Decryption\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entitlement_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EntitlementArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.gateway_bridge_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GatewayBridgeSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ingest_port) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IngestPort\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_bitrate) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxBitrate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_latency) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxLatency\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_sync_buffer) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxSyncBuffer\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.media_stream_source_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MediaStreamSourceConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.min_latency) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MinLatency\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ndi_source_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NdiSourceSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.protocol) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Protocol\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.router_integration_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RouterIntegrationState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.router_integration_transit_decryption) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RouterIntegrationTransitDecryption\":");
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
    if (input.source_listener_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceListenerAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_listener_port) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceListenerPort\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_interface_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcInterfaceName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.whitelist_cidr) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WhitelistCidr\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFlowSourceOutput {
    var result: UpdateFlowSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFlowSourceOutput, body, allocator);
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

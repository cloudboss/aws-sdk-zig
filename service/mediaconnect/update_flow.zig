const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncodingConfig = @import("encoding_config.zig").EncodingConfig;
const FlowSize = @import("flow_size.zig").FlowSize;
const UpdateMaintenance = @import("update_maintenance.zig").UpdateMaintenance;
const NdiConfig = @import("ndi_config.zig").NdiConfig;
const UpdateFailoverConfig = @import("update_failover_config.zig").UpdateFailoverConfig;
const MonitoringConfig = @import("monitoring_config.zig").MonitoringConfig;
const Flow = @import("flow.zig").Flow;

pub const UpdateFlowInput = struct {
    encoding_config: ?EncodingConfig = null,

    /// The Amazon Resource Name (ARN) of the flow that you want to update.
    flow_arn: []const u8,

    /// Determines the processing capacity and feature set of the flow.
    flow_size: ?FlowSize = null,

    /// The maintenance setting of the flow.
    maintenance: ?UpdateMaintenance = null,

    /// Specifies the configuration settings for a flow's NDI source or output.
    /// Required when the flow includes an NDI source or output.
    ndi_config: ?NdiConfig = null,

    /// The settings for source failover.
    source_failover_config: ?UpdateFailoverConfig = null,

    /// The settings for source monitoring.
    source_monitoring_config: ?MonitoringConfig = null,

    pub const json_field_names = .{
        .encoding_config = "EncodingConfig",
        .flow_arn = "FlowArn",
        .flow_size = "FlowSize",
        .maintenance = "Maintenance",
        .ndi_config = "NdiConfig",
        .source_failover_config = "SourceFailoverConfig",
        .source_monitoring_config = "SourceMonitoringConfig",
    };
};

pub const UpdateFlowOutput = @import("update_flow_response.zig").UpdateFlowResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFlowInput, options: CallOptions) !UpdateFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/flows/");
    try path_buf.appendSlice(allocator, input.flow_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.encoding_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncodingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.flow_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FlowSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maintenance) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Maintenance\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ndi_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NdiConfig\":");
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

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFlowOutput {
    const result: UpdateFlowOutput = try aws.json.parseJsonObject(
        UpdateFlowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

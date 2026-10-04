const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribeAnywhereSettings = @import("describe_anywhere_settings.zig").DescribeAnywhereSettings;
const CdiInputSpecification = @import("cdi_input_specification.zig").CdiInputSpecification;
const ChannelClass = @import("channel_class.zig").ChannelClass;
const ChannelEngineVersionResponse = @import("channel_engine_version_response.zig").ChannelEngineVersionResponse;
const OutputDestination = @import("output_destination.zig").OutputDestination;
const ChannelEgressEndpoint = @import("channel_egress_endpoint.zig").ChannelEgressEndpoint;
const EncoderSettings = @import("encoder_settings.zig").EncoderSettings;
const DescribeInferenceSettings = @import("describe_inference_settings.zig").DescribeInferenceSettings;
const InputAttachment = @import("input_attachment.zig").InputAttachment;
const InputSpecification = @import("input_specification.zig").InputSpecification;
const DescribeLinkedChannelSettings = @import("describe_linked_channel_settings.zig").DescribeLinkedChannelSettings;
const LogLevel = @import("log_level.zig").LogLevel;
const MaintenanceStatus = @import("maintenance_status.zig").MaintenanceStatus;
const PipelineDetail = @import("pipeline_detail.zig").PipelineDetail;
const ChannelState = @import("channel_state.zig").ChannelState;
const VpcOutputSettingsDescription = @import("vpc_output_settings_description.zig").VpcOutputSettingsDescription;

pub const DescribeChannelInput = @import("describe_channel_request.zig").DescribeChannelRequest;

pub const DescribeChannelOutput = @import("describe_channel_response.zig").DescribeChannelResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeChannelInput, options: CallOptions) !DescribeChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/channels/");
    try path_buf.appendSlice(allocator, input.channel_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeChannelOutput {
    const result: DescribeChannelOutput = try aws.json.parseJsonObject(
        DescribeChannelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

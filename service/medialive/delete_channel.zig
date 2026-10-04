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

pub const DeleteChannelInput = @import("delete_channel_request.zig").DeleteChannelRequest;

pub const DeleteChannelOutput = struct {
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

    /// Include this setting to include Elemental Inference features in this
    /// channel.
    inference_settings: ?DescribeInferenceSettings = null,

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
        .inference_settings = "InferenceSettings",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteChannelInput, options: CallOptions) !DeleteChannelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/channels/");
    try path_buf.appendSlice(allocator, input.channel_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteChannelOutput {
    const result: DeleteChannelOutput = try aws.json.parseJsonObject(
        DeleteChannelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

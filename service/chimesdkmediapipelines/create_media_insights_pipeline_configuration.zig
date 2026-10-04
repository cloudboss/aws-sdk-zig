const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaInsightsPipelineConfigurationElement = @import("media_insights_pipeline_configuration_element.zig").MediaInsightsPipelineConfigurationElement;
const RealTimeAlertConfiguration = @import("real_time_alert_configuration.zig").RealTimeAlertConfiguration;
const Tag = @import("tag.zig").Tag;
const MediaInsightsPipelineConfiguration = @import("media_insights_pipeline_configuration.zig").MediaInsightsPipelineConfiguration;

pub const CreateMediaInsightsPipelineConfigurationInput = struct {
    /// The unique identifier for the media insights pipeline configuration request.
    client_request_token: ?[]const u8 = null,

    /// The elements in the request, such as a processor for Amazon Transcribe or a
    /// sink for a Kinesis Data Stream.
    elements: []const MediaInsightsPipelineConfigurationElement,

    /// The name of the media insights pipeline configuration.
    media_insights_pipeline_configuration_name: []const u8,

    /// The configuration settings for the real-time alerts in a media insights
    /// pipeline configuration.
    real_time_alert_configuration: ?RealTimeAlertConfiguration = null,

    /// The ARN of the role used by the service to access Amazon Web Services
    /// resources,
    /// including `Transcribe` and `Transcribe Call Analytics`, on the
    /// caller’s behalf.
    resource_access_role_arn: []const u8,

    /// The tags assigned to the media insights pipeline configuration.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .elements = "Elements",
        .media_insights_pipeline_configuration_name = "MediaInsightsPipelineConfigurationName",
        .real_time_alert_configuration = "RealTimeAlertConfiguration",
        .resource_access_role_arn = "ResourceAccessRoleArn",
        .tags = "Tags",
    };
};

pub const CreateMediaInsightsPipelineConfigurationOutput = struct {
    /// The configuration settings for the media insights pipeline.
    media_insights_pipeline_configuration: ?MediaInsightsPipelineConfiguration = null,

    pub const json_field_names = .{
        .media_insights_pipeline_configuration = "MediaInsightsPipelineConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMediaInsightsPipelineConfigurationInput, options: CallOptions) !CreateMediaInsightsPipelineConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMediaInsightsPipelineConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("media-pipelines-chime", "Chime SDK Media Pipelines", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/media-insights-pipeline-configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Elements\":");
    try aws.json.writeValue(@TypeOf(input.elements), input.elements, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MediaInsightsPipelineConfigurationName\":");
    try aws.json.writeValue(@TypeOf(input.media_insights_pipeline_configuration_name), input.media_insights_pipeline_configuration_name, allocator, &body_buf);
    has_prev = true;
    if (input.real_time_alert_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RealTimeAlertConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceAccessRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_access_role_arn), input.resource_access_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMediaInsightsPipelineConfigurationOutput {
    const result: CreateMediaInsightsPipelineConfigurationOutput = try aws.json.parseJsonObject(
        CreateMediaInsightsPipelineConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

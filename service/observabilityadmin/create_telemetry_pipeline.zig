const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TelemetryPipelineConfiguration = @import("telemetry_pipeline_configuration.zig").TelemetryPipelineConfiguration;

pub const CreateTelemetryPipelineInput = struct {
    /// The configuration that defines how the telemetry pipeline processes data,
    /// including sources, processors, and destinations. For more information about
    /// pipeline components, see the [Amazon CloudWatch User
    /// Guide](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/pipeline-components-reference.html)
    configuration: TelemetryPipelineConfiguration,

    /// The name of the telemetry pipeline to create. The name must be unique within
    /// your account.
    name: []const u8,

    /// The key-value pairs to associate with the telemetry pipeline resource for
    /// categorization and management purposes.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateTelemetryPipelineOutput = struct {
    /// The Amazon Resource Name (ARN) of the created telemetry pipeline.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTelemetryPipelineInput, options: CallOptions) !CreateTelemetryPipelineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "observabilityadmin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTelemetryPipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateTelemetryPipeline";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTelemetryPipelineOutput {
    var result: CreateTelemetryPipelineOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateTelemetryPipelineOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

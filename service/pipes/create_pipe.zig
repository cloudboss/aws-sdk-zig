const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RequestedPipeState = @import("requested_pipe_state.zig").RequestedPipeState;
const PipeEnrichmentParameters = @import("pipe_enrichment_parameters.zig").PipeEnrichmentParameters;
const PipeLogConfigurationParameters = @import("pipe_log_configuration_parameters.zig").PipeLogConfigurationParameters;
const PipeSourceParameters = @import("pipe_source_parameters.zig").PipeSourceParameters;
const PipeTargetParameters = @import("pipe_target_parameters.zig").PipeTargetParameters;
const PipeState = @import("pipe_state.zig").PipeState;

pub const CreatePipeInput = struct {
    /// A description of the pipe.
    description: ?[]const u8 = null,

    /// The state the pipe should be in.
    desired_state: ?RequestedPipeState = null,

    /// The ARN of the enrichment resource.
    enrichment: ?[]const u8 = null,

    /// The parameters required to set up enrichment on your pipe.
    enrichment_parameters: ?PipeEnrichmentParameters = null,

    /// The identifier of the KMS
    /// customer managed key for EventBridge to use, if you choose to use a customer
    /// managed key to encrypt pipe data. The identifier can be the key
    /// Amazon Resource Name (ARN), KeyId, key alias, or key alias ARN.
    ///
    /// If you do not specify a customer managed key identifier, EventBridge uses an
    /// Amazon Web Services owned key to encrypt pipe data.
    ///
    /// For more information, see [Managing
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/getting-started.html) in the *Key Management Service
    /// Developer Guide*.
    kms_key_identifier: ?[]const u8 = null,

    /// The logging configuration settings for the pipe.
    log_configuration: ?PipeLogConfigurationParameters = null,

    /// The name of the pipe.
    name: []const u8,

    /// The ARN of the role that allows the pipe to send data to the target.
    role_arn: []const u8,

    /// The ARN of the source resource.
    source: []const u8,

    /// The parameters required to set up a source for your pipe.
    source_parameters: ?PipeSourceParameters = null,

    /// The list of key-value pairs to associate with the pipe.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the target resource.
    target: []const u8,

    /// The parameters required to set up a target for your pipe.
    ///
    /// For more information about pipe target parameters, including how to use
    /// dynamic path parameters, see [Target
    /// parameters](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes-event-target.html) in the *Amazon EventBridge User Guide*.
    target_parameters: ?PipeTargetParameters = null,

    pub const json_field_names = .{
        .description = "Description",
        .desired_state = "DesiredState",
        .enrichment = "Enrichment",
        .enrichment_parameters = "EnrichmentParameters",
        .kms_key_identifier = "KmsKeyIdentifier",
        .log_configuration = "LogConfiguration",
        .name = "Name",
        .role_arn = "RoleArn",
        .source = "Source",
        .source_parameters = "SourceParameters",
        .tags = "Tags",
        .target = "Target",
        .target_parameters = "TargetParameters",
    };
};

pub const CreatePipeOutput = struct {
    /// The ARN of the pipe.
    arn: ?[]const u8 = null,

    /// The time the pipe was created.
    creation_time: ?i64 = null,

    /// The state the pipe is in.
    current_state: ?PipeState = null,

    /// The state the pipe should be in.
    desired_state: ?RequestedPipeState = null,

    /// When the pipe was last updated, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    last_modified_time: ?i64 = null,

    /// The name of the pipe.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .current_state = "CurrentState",
        .desired_state = "DesiredState",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePipeInput, options: CallOptions) !CreatePipeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pipes", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePipeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pipes", "Pipes", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/pipes/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.desired_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DesiredState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enrichment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Enrichment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enrichment_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EnrichmentParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
    has_prev = true;
    if (input.source_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, allocator, &body_buf);
    has_prev = true;
    if (input.target_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetParameters\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePipeOutput {
    var result: CreatePipeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePipeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

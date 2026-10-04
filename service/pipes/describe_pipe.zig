const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipeState = @import("pipe_state.zig").PipeState;
const RequestedPipeStateDescribeResponse = @import("requested_pipe_state_describe_response.zig").RequestedPipeStateDescribeResponse;
const PipeEnrichmentParameters = @import("pipe_enrichment_parameters.zig").PipeEnrichmentParameters;
const PipeLogConfiguration = @import("pipe_log_configuration.zig").PipeLogConfiguration;
const PipeSourceParameters = @import("pipe_source_parameters.zig").PipeSourceParameters;
const PipeTargetParameters = @import("pipe_target_parameters.zig").PipeTargetParameters;

pub const DescribePipeInput = struct {
    /// The name of the pipe.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribePipeOutput = struct {
    /// The ARN of the pipe.
    arn: ?[]const u8 = null,

    /// The time the pipe was created.
    creation_time: ?i64 = null,

    /// The state the pipe is in.
    current_state: ?PipeState = null,

    /// A description of the pipe.
    description: ?[]const u8 = null,

    /// The state the pipe should be in.
    desired_state: ?RequestedPipeStateDescribeResponse = null,

    /// The ARN of the enrichment resource.
    enrichment: ?[]const u8 = null,

    /// The parameters required to set up enrichment on your pipe.
    enrichment_parameters: ?PipeEnrichmentParameters = null,

    /// The identifier of the KMS
    /// customer managed key for EventBridge to use to encrypt pipe data, if one has
    /// been specified.
    ///
    /// For more information, see [Data encryption in
    /// EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-encryption.html) in the *Amazon EventBridge User Guide*.
    kms_key_identifier: ?[]const u8 = null,

    /// When the pipe was last updated, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    last_modified_time: ?i64 = null,

    /// The logging configuration settings for the pipe.
    log_configuration: ?PipeLogConfiguration = null,

    /// The name of the pipe.
    name: ?[]const u8 = null,

    /// The ARN of the role that allows the pipe to send data to the target.
    role_arn: ?[]const u8 = null,

    /// The ARN of the source resource.
    source: ?[]const u8 = null,

    /// The parameters required to set up a source for your pipe.
    source_parameters: ?PipeSourceParameters = null,

    /// The reason the pipe is in its current state.
    state_reason: ?[]const u8 = null,

    /// The list of key-value pairs to associate with the pipe.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the target resource.
    target: ?[]const u8 = null,

    /// The parameters required to set up a target for your pipe.
    ///
    /// For more information about pipe target parameters, including how to use
    /// dynamic path parameters, see [Target
    /// parameters](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes-event-target.html) in the *Amazon EventBridge User Guide*.
    target_parameters: ?PipeTargetParameters = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .current_state = "CurrentState",
        .description = "Description",
        .desired_state = "DesiredState",
        .enrichment = "Enrichment",
        .enrichment_parameters = "EnrichmentParameters",
        .kms_key_identifier = "KmsKeyIdentifier",
        .last_modified_time = "LastModifiedTime",
        .log_configuration = "LogConfiguration",
        .name = "Name",
        .role_arn = "RoleArn",
        .source = "Source",
        .source_parameters = "SourceParameters",
        .state_reason = "StateReason",
        .tags = "Tags",
        .target = "Target",
        .target_parameters = "TargetParameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePipeInput, options: CallOptions) !DescribePipeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePipeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pipes", "Pipes", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/pipes/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePipeOutput {
    var result: DescribePipeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribePipeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

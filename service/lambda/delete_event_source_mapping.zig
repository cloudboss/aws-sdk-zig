const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AmazonManagedKafkaEventSourceConfig = @import("amazon_managed_kafka_event_source_config.zig").AmazonManagedKafkaEventSourceConfig;
const DestinationConfig = @import("destination_config.zig").DestinationConfig;
const DocumentDBEventSourceConfig = @import("document_db_event_source_config.zig").DocumentDBEventSourceConfig;
const FilterCriteria = @import("filter_criteria.zig").FilterCriteria;
const FilterCriteriaError = @import("filter_criteria_error.zig").FilterCriteriaError;
const FunctionResponseType = @import("function_response_type.zig").FunctionResponseType;
const EventSourceMappingLoggingConfig = @import("event_source_mapping_logging_config.zig").EventSourceMappingLoggingConfig;
const EventSourceMappingMetricsConfig = @import("event_source_mapping_metrics_config.zig").EventSourceMappingMetricsConfig;
const ProvisionedPollerConfig = @import("provisioned_poller_config.zig").ProvisionedPollerConfig;
const ScalingConfig = @import("scaling_config.zig").ScalingConfig;
const SelfManagedEventSource = @import("self_managed_event_source.zig").SelfManagedEventSource;
const SelfManagedKafkaEventSourceConfig = @import("self_managed_kafka_event_source_config.zig").SelfManagedKafkaEventSourceConfig;
const SourceAccessConfiguration = @import("source_access_configuration.zig").SourceAccessConfiguration;
const EventSourcePosition = @import("event_source_position.zig").EventSourcePosition;

pub const DeleteEventSourceMappingInput = struct {
    /// The identifier of the event source mapping.
    uuid: []const u8,

    pub const json_field_names = .{
        .uuid = "UUID",
    };
};

pub const DeleteEventSourceMappingOutput = @import("event_source_mapping_configuration.zig").EventSourceMappingConfiguration;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteEventSourceMappingInput, options: CallOptions) !DeleteEventSourceMappingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteEventSourceMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-03-31/event-source-mappings/");
    try path_buf.appendSlice(allocator, input.uuid);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteEventSourceMappingOutput {
    const result: DeleteEventSourceMappingOutput = try aws.json.parseJsonObject(
        DeleteEventSourceMappingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

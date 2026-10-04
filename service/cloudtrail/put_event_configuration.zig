const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AggregationConfiguration = @import("aggregation_configuration.zig").AggregationConfiguration;
const ContextKeySelector = @import("context_key_selector.zig").ContextKeySelector;
const MaxEventSize = @import("max_event_size.zig").MaxEventSize;

pub const PutEventConfigurationInput = struct {
    /// The list of aggregation configurations that you want to configure for the
    /// trail.
    aggregation_configurations: ?[]const AggregationConfiguration = null,

    /// A list of context key selectors that will be included to provide enriched
    /// event data.
    context_key_selectors: ?[]const ContextKeySelector = null,

    /// The Amazon Resource Name (ARN) or ID suffix of the ARN of the event data
    /// store for which event configuration settings are updated.
    event_data_store: ?[]const u8 = null,

    /// The maximum allowed size for events to be stored in the specified event data
    /// store. If you are using context key selectors, MaxEventSize must be set to
    /// Large.
    max_event_size: ?MaxEventSize = null,

    /// The name of the trail for which you want to update event configuration
    /// settings.
    trail_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregation_configurations = "AggregationConfigurations",
        .context_key_selectors = "ContextKeySelectors",
        .event_data_store = "EventDataStore",
        .max_event_size = "MaxEventSize",
        .trail_name = "TrailName",
    };
};

pub const PutEventConfigurationOutput = struct {
    /// A list of aggregation configurations that are configured for the trail.
    aggregation_configurations: ?[]const AggregationConfiguration = null,

    /// The list of context key selectors that are configured for the event data
    /// store.
    context_key_selectors: ?[]const ContextKeySelector = null,

    /// The Amazon Resource Name (ARN) or ID suffix of the ARN of the event data
    /// store for which the event configuration settings were updated.
    event_data_store_arn: ?[]const u8 = null,

    /// The maximum allowed size for events stored in the specified event data
    /// store.
    max_event_size: ?MaxEventSize = null,

    /// The Amazon Resource Name (ARN) of the trail that has aggregation enabled.
    trail_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregation_configurations = "AggregationConfigurations",
        .context_key_selectors = "ContextKeySelectors",
        .event_data_store_arn = "EventDataStoreArn",
        .max_event_size = "MaxEventSize",
        .trail_arn = "TrailARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutEventConfigurationInput, options: CallOptions) !PutEventConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutEventConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.PutEventConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutEventConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutEventConfigurationOutput, body, allocator);
}

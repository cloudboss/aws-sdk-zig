const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeatureDefinition = @import("feature_definition.zig").FeatureDefinition;
const OnlineStoreConfigUpdate = @import("online_store_config_update.zig").OnlineStoreConfigUpdate;
const ThroughputConfigUpdate = @import("throughput_config_update.zig").ThroughputConfigUpdate;

pub const UpdateFeatureGroupInput = struct {
    /// Updates the feature group. Updating a feature group is an asynchronous
    /// operation. When you get an HTTP 200 response, you've made a valid request.
    /// It takes some time after you've made a valid request for Feature Store to
    /// update the feature group.
    feature_additions: ?[]const FeatureDefinition = null,

    /// The name or Amazon Resource Name (ARN) of the feature group that you're
    /// updating.
    feature_group_name: []const u8,

    /// Updates the feature group online store configuration.
    online_store_config: ?OnlineStoreConfigUpdate = null,

    throughput_config: ?ThroughputConfigUpdate = null,

    pub const json_field_names = .{
        .feature_additions = "FeatureAdditions",
        .feature_group_name = "FeatureGroupName",
        .online_store_config = "OnlineStoreConfig",
        .throughput_config = "ThroughputConfig",
    };
};

pub const UpdateFeatureGroupOutput = struct {
    /// The Amazon Resource Number (ARN) of the feature group that you're updating.
    feature_group_arn: []const u8,

    pub const json_field_names = .{
        .feature_group_arn = "FeatureGroupArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFeatureGroupInput, options: CallOptions) !UpdateFeatureGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFeatureGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateFeatureGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFeatureGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateFeatureGroupOutput, body, allocator);
}

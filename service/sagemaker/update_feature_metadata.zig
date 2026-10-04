const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeatureParameter = @import("feature_parameter.zig").FeatureParameter;

pub const UpdateFeatureMetadataInput = struct {
    /// A description that you can write to better describe the feature.
    description: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) of the feature group containing the
    /// feature that you're updating.
    feature_group_name: []const u8,

    /// The name of the feature that you're updating.
    feature_name: []const u8,

    /// A list of key-value pairs that you can add to better describe the feature.
    parameter_additions: ?[]const FeatureParameter = null,

    /// A list of parameter keys that you can specify to remove parameters that
    /// describe your feature.
    parameter_removals: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .feature_group_name = "FeatureGroupName",
        .feature_name = "FeatureName",
        .parameter_additions = "ParameterAdditions",
        .parameter_removals = "ParameterRemovals",
    };
};

pub const UpdateFeatureMetadataOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFeatureMetadataInput, options: CallOptions) !UpdateFeatureMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFeatureMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateFeatureMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFeatureMetadataOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

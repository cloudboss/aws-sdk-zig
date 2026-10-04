const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeatureType = @import("feature_type.zig").FeatureType;
const FeatureParameter = @import("feature_parameter.zig").FeatureParameter;

pub const DescribeFeatureMetadataInput = struct {
    /// The name or Amazon Resource Name (ARN) of the feature group containing the
    /// feature.
    feature_group_name: []const u8,

    /// The name of the feature.
    feature_name: []const u8,

    pub const json_field_names = .{
        .feature_group_name = "FeatureGroupName",
        .feature_name = "FeatureName",
    };
};

pub const DescribeFeatureMetadataOutput = struct {
    /// A timestamp indicating when the feature was created.
    creation_time: i64,

    /// The description you added to describe the feature.
    description: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the feature group that contains the
    /// feature.
    feature_group_arn: []const u8,

    /// The name of the feature group that you've specified.
    feature_group_name: []const u8,

    /// The name of the feature that you've specified.
    feature_name: []const u8,

    /// The data type of the feature.
    feature_type: FeatureType,

    /// A timestamp indicating when the metadata for the feature group was modified.
    /// For example, if you add a parameter describing the feature, the timestamp
    /// changes to reflect the last time you
    last_modified_time: i64,

    /// The key-value pairs that you added to describe the feature.
    parameters: ?[]const FeatureParameter = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .feature_group_arn = "FeatureGroupArn",
        .feature_group_name = "FeatureGroupName",
        .feature_name = "FeatureName",
        .feature_type = "FeatureType",
        .last_modified_time = "LastModifiedTime",
        .parameters = "Parameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFeatureMetadataInput, options: CallOptions) !DescribeFeatureMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFeatureMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeFeatureMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFeatureMetadataOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeFeatureMetadataOutput, body, allocator);
}

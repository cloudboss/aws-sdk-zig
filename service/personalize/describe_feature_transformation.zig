const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeatureTransformation = @import("feature_transformation.zig").FeatureTransformation;

pub const DescribeFeatureTransformationInput = struct {
    /// The Amazon Resource Name (ARN) of the feature transformation to describe.
    feature_transformation_arn: []const u8,

    pub const json_field_names = .{
        .feature_transformation_arn = "featureTransformationArn",
    };
};

pub const DescribeFeatureTransformationOutput = struct {
    /// A listing of the FeatureTransformation properties.
    feature_transformation: ?FeatureTransformation = null,

    pub const json_field_names = .{
        .feature_transformation = "featureTransformation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFeatureTransformationInput, options: CallOptions) !DescribeFeatureTransformationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFeatureTransformationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.DescribeFeatureTransformation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFeatureTransformationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFeatureTransformationOutput, body, allocator);
}

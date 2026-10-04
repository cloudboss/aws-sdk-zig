const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateEndpointInput = struct {
    /// An idempotency token provided by the customer. If this token matches a
    /// previous endpoint
    /// creation request, Amazon Comprehend will not return a
    /// `ResourceInUseException`.
    client_request_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to trained custom models encrypted with
    /// a customer
    /// managed key (ModelKmsKeyId).
    data_access_role_arn: ?[]const u8 = null,

    /// The desired number of inference units to be used by the model using this
    /// endpoint.
    ///
    /// Each inference unit represents of a throughput of 100 characters per second.
    desired_inference_units: i32,

    /// This is the descriptive suffix that becomes part of the `EndpointArn` used
    /// for
    /// all subsequent requests to this resource.
    endpoint_name: []const u8,

    /// The Amazon Resource Number (ARN) of the flywheel to which the endpoint will
    /// be
    /// attached.
    flywheel_arn: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the model to which the endpoint will be
    /// attached.
    model_arn: ?[]const u8 = null,

    /// Tags to associate with the endpoint. A tag is a key-value pair that adds
    /// metadata to the endpoint. For example, a tag with "Sales" as the key might
    /// be added to an
    /// endpoint to indicate its use by the sales department.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .desired_inference_units = "DesiredInferenceUnits",
        .endpoint_name = "EndpointName",
        .flywheel_arn = "FlywheelArn",
        .model_arn = "ModelArn",
        .tags = "Tags",
    };
};

pub const CreateEndpointOutput = struct {
    /// The Amazon Resource Number (ARN) of the endpoint being created.
    endpoint_arn: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the model to which the endpoint is
    /// attached.
    model_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_arn = "EndpointArn",
        .model_arn = "ModelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEndpointInput, options: CallOptions) !CreateEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.CreateEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEndpointOutput, body, allocator);
}

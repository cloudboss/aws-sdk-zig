const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceContainerConfig = @import("inference_container_config.zig").InferenceContainerConfig;
const ContainerConfig = @import("container_config.zig").ContainerConfig;

pub const GetConfiguredModelAlgorithmInput = struct {
    /// The Amazon Resource Name (ARN) of the configured model algorithm that you
    /// want to return information about.
    configured_model_algorithm_arn: []const u8,

    pub const json_field_names = .{
        .configured_model_algorithm_arn = "configuredModelAlgorithmArn",
    };
};

pub const GetConfiguredModelAlgorithmOutput = struct {
    /// The Amazon Resource Name (ARN) of the configured model algorithm.
    configured_model_algorithm_arn: []const u8,

    /// The time at which the configured model algorithm was created.
    create_time: i64,

    /// The description of the configured model algorithm.
    description: ?[]const u8 = null,

    /// Configuration information for the inference container.
    inference_container_config: ?InferenceContainerConfig = null,

    /// The Amazon Resource Name (ARN) of the KMS key. This key is used to encrypt
    /// and decrypt customer-owned data in the configured ML model and associated
    /// data.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the configured model algorithm.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the service role that was used to create
    /// the configured model algorithm.
    role_arn: []const u8,

    /// The optional metadata that you applied to the resource to help you
    /// categorize and organize them. Each tag consists of a key and an optional
    /// value, both of which you define.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50.
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8.
    /// * Maximum value length - 256 Unicode characters in UTF-8.
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case sensitive.
    /// * Do not use aws:, AWS:, or any upper or lowercase combination of such as a
    ///   prefix for keys as it is reserved for AWS use. You cannot edit or delete
    ///   tag keys with this prefix. Values can have this prefix. If a tag value has
    ///   aws as its prefix but the key does not, then Clean Rooms ML considers it
    ///   to be a user tag and will count against the limit of 50 tags. Tags with
    ///   only the key prefix of aws do not count against your tags per resource
    ///   limit.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration information of the training container for the configured
    /// model algorithm.
    training_container_config: ?ContainerConfig = null,

    /// The most recent time at which the configured model algorithm was updated.
    update_time: i64,

    pub const json_field_names = .{
        .configured_model_algorithm_arn = "configuredModelAlgorithmArn",
        .create_time = "createTime",
        .description = "description",
        .inference_container_config = "inferenceContainerConfig",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .role_arn = "roleArn",
        .tags = "tags",
        .training_container_config = "trainingContainerConfig",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfiguredModelAlgorithmInput, options: CallOptions) !GetConfiguredModelAlgorithmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms-ml", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfiguredModelAlgorithmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configured-model-algorithms/");
    try path_buf.appendSlice(allocator, input.configured_model_algorithm_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfiguredModelAlgorithmOutput {
    const result: GetConfiguredModelAlgorithmOutput = try aws.json.parseJsonObject(
        GetConfiguredModelAlgorithmOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

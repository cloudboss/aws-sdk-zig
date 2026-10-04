const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceContainerConfig = @import("inference_container_config.zig").InferenceContainerConfig;
const ContainerConfig = @import("container_config.zig").ContainerConfig;

pub const CreateConfiguredModelAlgorithmInput = struct {
    /// The description of the configured model algorithm.
    description: ?[]const u8 = null,

    /// Configuration information for the inference container that is used when you
    /// run an inference job on a configured model algorithm.
    inference_container_config: ?InferenceContainerConfig = null,

    /// The Amazon Resource Name (ARN) of the KMS key. This key is used to encrypt
    /// and decrypt customer-owned data in the configured ML model algorithm and
    /// associated data.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the configured model algorithm.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the role that is used to access the
    /// repository.
    role_arn: []const u8,

    /// The optional metadata that you apply to the resource to help you categorize
    /// and organize them. Each tag consists of a key and an optional value, both of
    /// which you define.
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

    /// Configuration information for the training container, including entrypoints
    /// and arguments.
    training_container_config: ?ContainerConfig = null,

    pub const json_field_names = .{
        .description = "description",
        .inference_container_config = "inferenceContainerConfig",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .role_arn = "roleArn",
        .tags = "tags",
        .training_container_config = "trainingContainerConfig",
    };
};

pub const CreateConfiguredModelAlgorithmOutput = struct {
    /// The Amazon Resource Name (ARN) of the configured model algorithm.
    configured_model_algorithm_arn: []const u8,

    pub const json_field_names = .{
        .configured_model_algorithm_arn = "configuredModelAlgorithmArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfiguredModelAlgorithmInput, options: CallOptions) !CreateConfiguredModelAlgorithmOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfiguredModelAlgorithmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configured-model-algorithms";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.inference_container_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inferenceContainerConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.training_container_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"trainingContainerConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfiguredModelAlgorithmOutput {
    var result: CreateConfiguredModelAlgorithmOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConfiguredModelAlgorithmOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

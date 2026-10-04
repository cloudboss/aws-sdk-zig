const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceContainerExecutionParameters = @import("inference_container_execution_parameters.zig").InferenceContainerExecutionParameters;
const ModelInferenceDataSource = @import("model_inference_data_source.zig").ModelInferenceDataSource;
const InferenceOutputConfiguration = @import("inference_output_configuration.zig").InferenceOutputConfiguration;
const InferenceResourceConfig = @import("inference_resource_config.zig").InferenceResourceConfig;

pub const StartTrainedModelInferenceJobInput = struct {
    /// The Amazon Resource Name (ARN) of the configured model algorithm association
    /// that is used for this trained model inference job.
    configured_model_algorithm_association_arn: ?[]const u8 = null,

    /// The execution parameters for the container.
    container_execution_parameters: ?InferenceContainerExecutionParameters = null,

    /// Defines the data source that is used for the trained model inference job.
    data_source: ModelInferenceDataSource,

    /// The description of the trained model inference job.
    description: ?[]const u8 = null,

    /// The environment variables to set in the Docker container.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the KMS key. This key is used to encrypt
    /// and decrypt customer-owned data in the ML inference job and associated data.
    kms_key_arn: ?[]const u8 = null,

    /// The membership ID of the membership that contains the trained model
    /// inference job.
    membership_identifier: []const u8,

    /// The account ID of the member that is responsible for paying for model
    /// inference costs.
    ml_model_inference_payer_account_id: ?[]const u8 = null,

    /// The name of the trained model inference job.
    name: []const u8,

    /// Defines the output configuration information for the trained model inference
    /// job.
    output_configuration: InferenceOutputConfiguration,

    /// Defines the resource configuration for the trained model inference job.
    resource_config: InferenceResourceConfig,

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

    /// The Amazon Resource Name (ARN) of the trained model that is used for this
    /// trained model inference job.
    trained_model_arn: []const u8,

    /// The version identifier of the trained model to use for inference. This
    /// specifies which version of the trained model should be used to generate
    /// predictions on the input data.
    trained_model_version_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
        .container_execution_parameters = "containerExecutionParameters",
        .data_source = "dataSource",
        .description = "description",
        .environment = "environment",
        .kms_key_arn = "kmsKeyArn",
        .membership_identifier = "membershipIdentifier",
        .ml_model_inference_payer_account_id = "mlModelInferencePayerAccountId",
        .name = "name",
        .output_configuration = "outputConfiguration",
        .resource_config = "resourceConfig",
        .tags = "tags",
        .trained_model_arn = "trainedModelArn",
        .trained_model_version_identifier = "trainedModelVersionIdentifier",
    };
};

pub const StartTrainedModelInferenceJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the trained model inference job.
    trained_model_inference_job_arn: []const u8,

    pub const json_field_names = .{
        .trained_model_inference_job_arn = "trainedModelInferenceJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTrainedModelInferenceJobInput, options: CallOptions) !StartTrainedModelInferenceJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTrainedModelInferenceJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/trained-model-inference-jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.configured_model_algorithm_association_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configuredModelAlgorithmAssociationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.container_execution_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"containerExecutionParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataSource\":");
    try aws.json.writeValue(@TypeOf(input.data_source), input.data_source, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ml_model_inference_payer_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mlModelInferencePayerAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.output_configuration), input.output_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceConfig\":");
    try aws.json.writeValue(@TypeOf(input.resource_config), input.resource_config, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"trainedModelArn\":");
    try aws.json.writeValue(@TypeOf(input.trained_model_arn), input.trained_model_arn, allocator, &body_buf);
    has_prev = true;
    if (input.trained_model_version_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"trainedModelVersionIdentifier\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTrainedModelInferenceJobOutput {
    const result: StartTrainedModelInferenceJobOutput = try aws.json.parseJsonObject(
        StartTrainedModelInferenceJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

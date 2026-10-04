const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomModelDataSource = @import("custom_model_data_source.zig").CustomModelDataSource;
const ModelDataSource = @import("model_data_source.zig").ModelDataSource;
const Tag = @import("tag.zig").Tag;

pub const CreateCustomModelInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// The data source for the custom model. Use this field to specify a SageMaker
    /// AI model package ARN as the source for your custom model. Amazon Bedrock
    /// resolves the model package to retrieve the model artifacts.
    ///
    /// You can specify either `customModelDataSource` or `modelSourceConfig`, but
    /// not both.
    custom_model_data_source: ?CustomModelDataSource = null,

    /// The Amazon Resource Name (ARN) of the customer managed KMS key to encrypt
    /// the custom model. If you don't provide a KMS key, Amazon Bedrock uses an
    /// Amazon Web Services-managed KMS key to encrypt the model.
    ///
    /// If you provide a customer managed KMS key, your Amazon Bedrock service role
    /// must have permissions to use it. For more information see [Encryption of
    /// imported
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/encryption-import-model.html).
    model_kms_key_arn: ?[]const u8 = null,

    /// A unique name for the custom model.
    model_name: []const u8,

    /// The data source for the model. The Amazon S3 URI in the model source must be
    /// for the Amazon-managed Amazon S3 bucket containing your model artifacts.
    model_source_config: ?ModelDataSource = null,

    /// A list of key-value pairs to associate with the custom model resource. You
    /// can use these tags to organize and identify your resources.
    ///
    /// For more information, see [Tagging
    /// resources](https://docs.aws.amazon.com/bedrock/latest/userguide/tagging.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    model_tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of an IAM service role that Amazon Bedrock
    /// assumes to perform tasks on your behalf. This role must have permissions to
    /// access the Amazon S3 bucket containing your model artifacts and the KMS key
    /// (if specified). For more information, see [Setting up an IAM service role
    /// for importing
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-import-iam-role.html) in the Amazon Bedrock User Guide.
    ///
    /// This field is required when you use `modelSourceConfig` with an Amazon S3
    /// data source. It is not required when you use `customModelDataSource` with a
    /// model package ARN, because Amazon Bedrock uses its own credentials to access
    /// the model artifacts.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .custom_model_data_source = "customModelDataSource",
        .model_kms_key_arn = "modelKmsKeyArn",
        .model_name = "modelName",
        .model_source_config = "modelSourceConfig",
        .model_tags = "modelTags",
        .role_arn = "roleArn",
    };
};

pub const CreateCustomModelOutput = struct {
    /// The Amazon Resource Name (ARN) of the new custom model.
    model_arn: []const u8,

    pub const json_field_names = .{
        .model_arn = "modelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomModelInput, options: CallOptions) !CreateCustomModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/custom-models/create-custom-model";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_model_data_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customModelDataSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.model_kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"modelKmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelName\":");
    try aws.json.writeValue(@TypeOf(input.model_name), input.model_name, allocator, &body_buf);
    has_prev = true;
    if (input.model_source_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"modelSourceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.model_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"modelTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomModelOutput {
    const result: CreateCustomModelOutput = try aws.json.parseJsonObject(
        CreateCustomModelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

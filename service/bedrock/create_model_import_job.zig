const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ModelDataSource = @import("model_data_source.zig").ModelDataSource;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const CreateModelImportJobInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// The imported model is encrypted at rest using this key.
    imported_model_kms_key_id: ?[]const u8 = null,

    /// The name of the imported model.
    imported_model_name: []const u8,

    /// Tags to attach to the imported model.
    imported_model_tags: ?[]const Tag = null,

    /// The name of the import job.
    job_name: []const u8,

    /// Tags to attach to this import job.
    job_tags: ?[]const Tag = null,

    /// The data source for the imported model.
    model_data_source: ModelDataSource,

    /// The Amazon Resource Name (ARN) of the model import job.
    role_arn: []const u8,

    /// VPC configuration parameters for the private Virtual Private Cloud (VPC)
    /// that contains the resources you are using for the import job.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .imported_model_kms_key_id = "importedModelKmsKeyId",
        .imported_model_name = "importedModelName",
        .imported_model_tags = "importedModelTags",
        .job_name = "jobName",
        .job_tags = "jobTags",
        .model_data_source = "modelDataSource",
        .role_arn = "roleArn",
        .vpc_config = "vpcConfig",
    };
};

pub const CreateModelImportJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the model import job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateModelImportJobInput, options: CallOptions) !CreateModelImportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateModelImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/model-import-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.imported_model_kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"importedModelKmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"importedModelName\":");
    try aws.json.writeValue(@TypeOf(input.imported_model_name), input.imported_model_name, allocator, &body_buf);
    has_prev = true;
    if (input.imported_model_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"importedModelTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobName\":");
    try aws.json.writeValue(@TypeOf(input.job_name), input.job_name, allocator, &body_buf);
    has_prev = true;
    if (input.job_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelDataSource\":");
    try aws.json.writeValue(@TypeOf(input.model_data_source), input.model_data_source, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.vpc_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateModelImportJobOutput {
    var result: CreateModelImportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateModelImportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

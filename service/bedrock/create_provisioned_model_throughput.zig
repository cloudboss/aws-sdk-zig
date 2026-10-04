const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommitmentDuration = @import("commitment_duration.zig").CommitmentDuration;
const Tag = @import("tag.zig").Tag;

pub const CreateProvisionedModelThroughputInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html) in the Amazon S3 User Guide.
    client_request_token: ?[]const u8 = null,

    /// The commitment duration requested for the Provisioned Throughput. Billing
    /// occurs hourly and is discounted for longer commitment terms. To request a
    /// no-commit Provisioned Throughput, omit this field.
    ///
    /// Custom models support all levels of commitment. To see which base models
    /// support no commitment, see [Supported regions and models for Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/pt-supported.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html)
    commitment_duration: ?CommitmentDuration = null,

    /// The Amazon Resource Name (ARN) or name of the model to associate with this
    /// Provisioned Throughput. For a list of models for which you can purchase
    /// Provisioned Throughput, see [Amazon Bedrock model IDs for purchasing
    /// Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/model-ids.html#prov-throughput-models) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    model_id: []const u8,

    /// Number of model units to allocate. A model unit delivers a specific
    /// throughput level for the specified model. The throughput level of a model
    /// unit specifies the total number of input and output tokens that it can
    /// process and generate within a span of one minute. By default, your account
    /// has no model units for purchasing Provisioned Throughputs with commitment.
    /// You must first visit the [Amazon Web Services support
    /// center](https://console.aws.amazon.com/support/home#/case/create?issueType=service-limit-increase) to request MUs.
    ///
    /// For model unit quotas, see [Provisioned Throughput
    /// quotas](https://docs.aws.amazon.com/bedrock/latest/userguide/quotas.html#prov-thru-quotas) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    ///
    /// For more information about what an MU specifies, contact your Amazon Web
    /// Services account manager.
    model_units: i32,

    /// The name for this Provisioned Throughput.
    provisioned_model_name: []const u8,

    /// Tags to associate with this Provisioned Throughput.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .commitment_duration = "commitmentDuration",
        .model_id = "modelId",
        .model_units = "modelUnits",
        .provisioned_model_name = "provisionedModelName",
        .tags = "tags",
    };
};

pub const CreateProvisionedModelThroughputOutput = struct {
    /// The Amazon Resource Name (ARN) for this Provisioned Throughput.
    provisioned_model_arn: []const u8,

    pub const json_field_names = .{
        .provisioned_model_arn = "provisionedModelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProvisionedModelThroughputInput, options: CallOptions) !CreateProvisionedModelThroughputOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProvisionedModelThroughputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/provisioned-model-throughput";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.commitment_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"commitmentDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelId\":");
    try aws.json.writeValue(@TypeOf(input.model_id), input.model_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelUnits\":");
    try aws.json.writeValue(@TypeOf(input.model_units), input.model_units, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"provisionedModelName\":");
    try aws.json.writeValue(@TypeOf(input.provisioned_model_name), input.provisioned_model_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProvisionedModelThroughputOutput {
    var result: CreateProvisionedModelThroughputOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateProvisionedModelThroughputOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateCustomModelDeploymentInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// A description for the custom model deployment to help you identify its
    /// purpose.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the custom model to deploy for on-demand
    /// inference. The custom model must be in the `Active` state.
    model_arn: []const u8,

    /// The name for the custom model deployment. The name must be unique within
    /// your Amazon Web Services account and Region.
    model_deployment_name: []const u8,

    /// Tags to assign to the custom model deployment. You can use tags to organize
    /// and track your Amazon Web Services resources for cost allocation and
    /// management purposes.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .description = "description",
        .model_arn = "modelArn",
        .model_deployment_name = "modelDeploymentName",
        .tags = "tags",
    };
};

pub const CreateCustomModelDeploymentOutput = struct {
    /// The Amazon Resource Name (ARN) of the custom model deployment. Use this ARN
    /// as the `modelId` parameter when invoking the model with the `InvokeModel` or
    /// `Converse` operations.
    custom_model_deployment_arn: []const u8,

    pub const json_field_names = .{
        .custom_model_deployment_arn = "customModelDeploymentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomModelDeploymentInput, options: CallOptions) !CreateCustomModelDeploymentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomModelDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/model-customization/custom-model-deployments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelArn\":");
    try aws.json.writeValue(@TypeOf(input.model_arn), input.model_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelDeploymentName\":");
    try aws.json.writeValue(@TypeOf(input.model_deployment_name), input.model_deployment_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomModelDeploymentOutput {
    var result: CreateCustomModelDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCustomModelDeploymentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

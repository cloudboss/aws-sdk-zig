const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentParameterInput = @import("deployment_parameter_input.zig").DeploymentParameterInput;

pub const PutDeploymentParameterInput = struct {
    /// The unique identifier of the agreement.
    agreement_id: []const u8,

    /// The catalog related to the request. Fixed value: `AWSMarketplace`
    catalog: []const u8,

    /// The idempotency token for deployment parameters. A unique identifier for the
    /// new version.
    ///
    /// This field is not required if you're calling using an AWS SDK. Otherwise, a
    /// `clientToken` must be provided with the request.
    client_token: ?[]const u8 = null,

    /// The deployment parameter targeted to the acceptor of an agreement for which
    /// to create the AWS Secret Manager resource.
    deployment_parameter: DeploymentParameterInput,

    /// The date when deployment parameters expire and are scheduled for deletion.
    expiration_date: ?i64 = null,

    /// The product for which AWS Marketplace will save secrets for the buyer’s
    /// account.
    product_id: []const u8,

    /// A map of key-value pairs, where each pair represents a tag saved to the
    /// resource. Tags will only be applied for create operations, and they'll be
    /// ignored if the resource already exists.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .catalog = "catalog",
        .client_token = "clientToken",
        .deployment_parameter = "deploymentParameter",
        .expiration_date = "expirationDate",
        .product_id = "productId",
        .tags = "tags",
    };
};

pub const PutDeploymentParameterOutput = struct {
    /// The unique identifier of the agreement.
    agreement_id: []const u8,

    /// The unique identifier of the deployment parameter.
    deployment_parameter_id: []const u8,

    /// The Amazon Resource Name (ARN) associated with the deployment parameter
    /// resource you want to create or update.
    resource_arn: []const u8,

    /// A map of key-value pairs, where each pair represents a tag saved to the
    /// resource. Tags will only be applied for create operations, and they'll be
    /// ignored if the resource already exists.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .deployment_parameter_id = "deploymentParameterId",
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDeploymentParameterInput, options: CallOptions) !PutDeploymentParameterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDeploymentParameterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deployment-marketplace", "Marketplace Deployment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/catalogs/");
    try path_buf.appendSlice(allocator, input.catalog);
    try path_buf.appendSlice(allocator, "/products/");
    try path_buf.appendSlice(allocator, input.product_id);
    try path_buf.appendSlice(allocator, "/deployment-parameters");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agreementId\":");
    try aws.json.writeValue(@TypeOf(input.agreement_id), input.agreement_id, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"deploymentParameter\":");
    try aws.json.writeValue(@TypeOf(input.deployment_parameter), input.deployment_parameter, allocator, &body_buf);
    has_prev = true;
    if (input.expiration_date) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expirationDate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDeploymentParameterOutput {
    const result: PutDeploymentParameterOutput = try aws.json.parseJsonObject(
        PutDeploymentParameterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointConfig = @import("endpoint_config.zig").EndpointConfig;
const Tag = @import("tag.zig").Tag;
const MarketplaceModelEndpoint = @import("marketplace_model_endpoint.zig").MarketplaceModelEndpoint;

pub const CreateMarketplaceModelEndpointInput = struct {
    /// Indicates whether you accept the end-user license agreement (EULA) for the
    /// model. Set to `true` to accept the EULA.
    accept_eula: ?bool = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. This token is listed as not required because
    /// Amazon Web Services SDKs automatically generate it for you and set this
    /// parameter. If you're not using the Amazon Web Services SDK or the CLI, you
    /// must provide this token or the action will fail.
    client_request_token: ?[]const u8 = null,

    /// The configuration for the endpoint, including the number and type of
    /// instances to use.
    endpoint_config: EndpointConfig,

    /// The name of the endpoint. This name must be unique within your Amazon Web
    /// Services account and region.
    endpoint_name: []const u8,

    /// The ARN of the model from Amazon Bedrock Marketplace that you want to deploy
    /// to the endpoint.
    model_source_identifier: []const u8,

    /// An array of key-value pairs to apply to the underlying Amazon SageMaker
    /// endpoint. You can use these tags to organize and identify your Amazon Web
    /// Services resources.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .accept_eula = "acceptEula",
        .client_request_token = "clientRequestToken",
        .endpoint_config = "endpointConfig",
        .endpoint_name = "endpointName",
        .model_source_identifier = "modelSourceIdentifier",
        .tags = "tags",
    };
};

pub const CreateMarketplaceModelEndpointOutput = struct {
    /// Details about the created endpoint.
    marketplace_model_endpoint: ?MarketplaceModelEndpoint = null,

    pub const json_field_names = .{
        .marketplace_model_endpoint = "marketplaceModelEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMarketplaceModelEndpointInput, options: CallOptions) !CreateMarketplaceModelEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMarketplaceModelEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/marketplace-model/endpoints";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.accept_eula) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"acceptEula\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"endpointConfig\":");
    try aws.json.writeValue(@TypeOf(input.endpoint_config), input.endpoint_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"endpointName\":");
    try aws.json.writeValue(@TypeOf(input.endpoint_name), input.endpoint_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelSourceIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.model_source_identifier), input.model_source_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMarketplaceModelEndpointOutput {
    var result: CreateMarketplaceModelEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMarketplaceModelEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

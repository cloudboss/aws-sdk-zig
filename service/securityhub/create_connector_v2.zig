const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderConfiguration = @import("provider_configuration.zig").ProviderConfiguration;
const ConnectorStatus = @import("connector_status.zig").ConnectorStatus;

pub const CreateConnectorV2Input = struct {
    /// A unique identifier used to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The description of the connectorV2.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of KMS key used to encrypt secrets for the
    /// connectorV2.
    kms_key_arn: ?[]const u8 = null,

    /// The unique name of the connectorV2.
    name: []const u8,

    /// The third-party provider’s service configuration.
    provider: ProviderConfiguration,

    /// The tags to add to the connectorV2 when you create.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .kms_key_arn = "KmsKeyArn",
        .name = "Name",
        .provider = "Provider",
        .tags = "Tags",
    };
};

pub const CreateConnectorV2Output = struct {
    /// The Url provide to customers for OAuth auth code flow.
    auth_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the connectorV2.
    connector_arn: []const u8,

    /// The UUID of the connectorV2 to identify connectorV2 resource.
    connector_id: []const u8,

    /// The current status of the connectorV2.
    connector_status: ?ConnectorStatus = null,

    pub const json_field_names = .{
        .auth_url = "AuthUrl",
        .connector_arn = "ConnectorArn",
        .connector_id = "ConnectorId",
        .connector_status = "ConnectorStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectorV2Input, options: CallOptions) !CreateConnectorV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectorV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connectorsv2";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Provider\":");
    try aws.json.writeValue(@TypeOf(input.provider), input.provider, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectorV2Output {
    var result: CreateConnectorV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConnectorV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

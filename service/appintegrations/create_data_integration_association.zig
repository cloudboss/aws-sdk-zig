const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionConfiguration = @import("execution_configuration.zig").ExecutionConfiguration;

pub const CreateDataIntegrationAssociationInput = struct {
    /// The mapping of metadata to be extracted from the data.
    client_association_metadata: ?[]const aws.map.StringMapEntry = null,

    /// The identifier for the client that is associated with the DataIntegration
    /// association.
    client_id: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// A unique identifier for the DataIntegration.
    data_integration_identifier: []const u8,

    /// The URI of the data destination.
    destination_uri: ?[]const u8 = null,

    /// The configuration for how the files should be pulled from the source.
    execution_configuration: ?ExecutionConfiguration = null,

    object_configuration: ?[]const aws.map.MapEntry([]const aws.map.MapEntry([]const []const u8)) = null,

    pub const json_field_names = .{
        .client_association_metadata = "ClientAssociationMetadata",
        .client_id = "ClientId",
        .client_token = "ClientToken",
        .data_integration_identifier = "DataIntegrationIdentifier",
        .destination_uri = "DestinationURI",
        .execution_configuration = "ExecutionConfiguration",
        .object_configuration = "ObjectConfiguration",
    };
};

pub const CreateDataIntegrationAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) for the DataIntegration.
    data_integration_arn: ?[]const u8 = null,

    /// A unique identifier. for the DataIntegrationAssociation.
    data_integration_association_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_integration_arn = "DataIntegrationArn",
        .data_integration_association_id = "DataIntegrationAssociationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataIntegrationAssociationInput, options: CallOptions) !CreateDataIntegrationAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "app-integrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataIntegrationAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("app-integrations", "AppIntegrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dataIntegrations/");
    try path_buf.appendSlice(allocator, input.data_integration_identifier);
    try path_buf.appendSlice(allocator, "/associations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_association_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientAssociationMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.destination_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationURI\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExecutionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.object_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ObjectConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataIntegrationAssociationOutput {
    var result: CreateDataIntegrationAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataIntegrationAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

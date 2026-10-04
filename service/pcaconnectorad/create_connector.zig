const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcInformation = @import("vpc_information.zig").VpcInformation;

pub const CreateConnectorInput = struct {
    /// The Amazon Resource Name (ARN) of the certificate authority being used.
    certificate_authority_arn: []const u8,

    /// Idempotency token.
    client_token: ?[]const u8 = null,

    /// The identifier of the Active Directory.
    directory_id: []const u8,

    /// Metadata assigned to a connector consisting of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Information about your VPC and security groups used with the connector.
    vpc_information: VpcInformation,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .client_token = "ClientToken",
        .directory_id = "DirectoryId",
        .tags = "Tags",
        .vpc_information = "VpcInformation",
    };
};

pub const CreateConnectorOutput = struct {
    /// If successful, the Amazon Resource Name (ARN) of the connector for Active
    /// Directory.
    connector_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectorInput, options: CallOptions) !CreateConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pca-connector-ad", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pca-connector-ad", "Pca Connector Ad", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connectors";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CertificateAuthorityArn\":");
    try aws.json.writeValue(@TypeOf(input.certificate_authority_arn), input.certificate_authority_arn, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DirectoryId\":");
    try aws.json.writeValue(@TypeOf(input.directory_id), input.directory_id, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VpcInformation\":");
    try aws.json.writeValue(@TypeOf(input.vpc_information), input.vpc_information, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectorOutput {
    var result: CreateConnectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConnectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

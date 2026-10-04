const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MobileDeviceManagement = @import("mobile_device_management.zig").MobileDeviceManagement;

pub const CreateConnectorInput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Private
    /// Certificate Authority certificate authority to use with this connector. Due
    /// to security vulnerabilities present in the SCEP protocol, we recommend using
    /// a private CA that's dedicated for use with the connector.
    ///
    /// To retrieve the private CAs associated with your account, you can call
    /// [ListCertificateAuthorities](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListCertificateAuthorities.html) using the Amazon Web Services Private CA API.
    certificate_authority_arn: []const u8,

    /// Custom string that can be used to distinguish between calls to the
    /// [CreateChallenge](https://docs.aws.amazon.com/pca-connector-scep/latest/APIReference/API_CreateChallenge.html) action. Client tokens for `CreateChallenge` time out after five minutes. Therefore, if you call `CreateChallenge` multiple times with the same client token within five minutes, Connector for SCEP recognizes that you are requesting only one challenge and will only respond with one. If you change the client token for each call, Connector for SCEP recognizes that you are requesting multiple challenge passwords.
    client_token: ?[]const u8 = null,

    /// If you don't supply a value, by default Connector for SCEP creates a
    /// connector for general-purpose use. A general-purpose connector is designed
    /// to work with clients or endpoints that support the SCEP protocol, except
    /// Connector for SCEP for Microsoft Intune. With connectors for general-purpose
    /// use, you manage SCEP challenge passwords using Connector for SCEP. For
    /// information about considerations and limitations with using Connector for
    /// SCEP, see [Considerations and
    /// Limitations](https://docs.aws.amazon.com/privateca/latest/userguide/scep-connector.htmlc4scep-considerations-limitations.html).
    ///
    /// If you provide an `IntuneConfiguration`, Connector for SCEP creates a
    /// connector for use with Microsoft Intune, and you manage the challenge
    /// passwords using Microsoft Intune. For more information, see [Using Connector
    /// for SCEP for Microsoft
    /// Intune](https://docs.aws.amazon.com/privateca/latest/userguide/scep-connector.htmlconnector-for-scep-intune.html).
    mobile_device_management: ?MobileDeviceManagement = null,

    /// The key-value pairs to associate with the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// If you don't supply a value, by default Connector for SCEP creates a
    /// connector accessible over the public internet. If you provide a VPC endpoint
    /// ID, creates a connector accessible only through that specific VPC endpoint.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .client_token = "ClientToken",
        .mobile_device_management = "MobileDeviceManagement",
        .tags = "Tags",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};

pub const CreateConnectorOutput = struct {
    /// Returns the Amazon Resource Name (ARN) of the connector.
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pca-connector-scep", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("pca-connector-scep", "Pca Connector Scep", allocator);

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
    if (input.mobile_device_management) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MobileDeviceManagement\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_endpoint_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcEndpointId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectorOutput {
    const result: CreateConnectorOutput = try aws.json.parseJsonObject(
        CreateConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

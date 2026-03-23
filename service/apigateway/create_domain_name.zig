const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EndpointAccessMode = @import("endpoint_access_mode.zig").EndpointAccessMode;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const MutualTlsAuthenticationInput = @import("mutual_tls_authentication_input.zig").MutualTlsAuthenticationInput;
const RoutingMode = @import("routing_mode.zig").RoutingMode;
const SecurityPolicy = @import("security_policy.zig").SecurityPolicy;
const DomainNameStatus = @import("domain_name_status.zig").DomainNameStatus;
const MutualTlsAuthentication = @import("mutual_tls_authentication.zig").MutualTlsAuthentication;

pub const CreateDomainNameInput = struct {
    /// The reference to an Amazon Web Services-managed certificate that will be
    /// used by edge-optimized endpoint or private endpoint for this domain name.
    /// Certificate Manager is the only supported source.
    certificate_arn: ?[]const u8 = null,

    /// [Deprecated] The body of the server certificate that will be used by
    /// edge-optimized endpoint or private endpoint for this domain name provided by
    /// your certificate authority.
    certificate_body: ?[]const u8 = null,

    /// [Deprecated] The intermediate certificates and optionally the root
    /// certificate, one after the other without any blank lines, used by an
    /// edge-optimized endpoint for this domain name. If you include the root
    /// certificate, your certificate chain must start with intermediate
    /// certificates and end with the root certificate. Use the intermediate
    /// certificates that were provided by your certificate authority. Do not
    /// include any intermediaries that are not in the chain of trust path.
    certificate_chain: ?[]const u8 = null,

    /// The user-friendly name of the certificate that will be used by
    /// edge-optimized endpoint or private endpoint for this domain name.
    certificate_name: ?[]const u8 = null,

    /// [Deprecated] Your edge-optimized endpoint's domain name certificate's
    /// private key.
    certificate_private_key: ?[]const u8 = null,

    /// The name of the DomainName resource.
    domain_name: []const u8,

    /// The endpoint access mode of the DomainName. Only available for DomainNames
    /// that use security policies that start with `SecurityPolicy_`.
    endpoint_access_mode: ?EndpointAccessMode = null,

    /// The endpoint configuration of this DomainName showing the endpoint types and
    /// IP address types of the domain name.
    endpoint_configuration: ?EndpointConfiguration = null,

    mutual_tls_authentication: ?MutualTlsAuthenticationInput = null,

    /// The ARN of the public certificate issued by ACM to validate ownership of
    /// your custom
    /// domain. Only required when configuring mutual TLS and using an ACM imported
    /// or private CA
    /// certificate ARN as the regionalCertificateArn.
    ownership_verification_certificate_arn: ?[]const u8 = null,

    /// A stringified JSON policy document that applies to the `execute-api` service
    /// for this DomainName regardless of the caller and Method
    /// configuration. Supported only for private custom
    /// domain names.
    policy: ?[]const u8 = null,

    /// The reference to an Amazon Web Services-managed certificate that will be
    /// used by regional endpoint for this domain name. Certificate Manager is the
    /// only supported source.
    regional_certificate_arn: ?[]const u8 = null,

    /// The user-friendly name of the certificate that will be used by regional
    /// endpoint for this domain name.
    regional_certificate_name: ?[]const u8 = null,

    /// The routing mode for this domain name. The routing mode determines how API
    /// Gateway sends traffic from your custom domain name to your private APIs.
    routing_mode: ?RoutingMode = null,

    /// The Transport Layer Security (TLS) version + cipher suite for this
    /// DomainName.
    security_policy: ?SecurityPolicy = null,

    /// The key-value map of strings. The valid character set is [a-zA-Z+-=._:/].
    /// The tag key can be up to 128 characters and must not start with `aws:`. The
    /// tag value can be up to 256 characters.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_body = "certificateBody",
        .certificate_chain = "certificateChain",
        .certificate_name = "certificateName",
        .certificate_private_key = "certificatePrivateKey",
        .domain_name = "domainName",
        .endpoint_access_mode = "endpointAccessMode",
        .endpoint_configuration = "endpointConfiguration",
        .mutual_tls_authentication = "mutualTlsAuthentication",
        .ownership_verification_certificate_arn = "ownershipVerificationCertificateArn",
        .policy = "policy",
        .regional_certificate_arn = "regionalCertificateArn",
        .regional_certificate_name = "regionalCertificateName",
        .routing_mode = "routingMode",
        .security_policy = "securityPolicy",
        .tags = "tags",
    };
};

pub const CreateDomainNameOutput = @import("domain_name.zig").DomainName;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainNameInput, options: CallOptions) !CreateDomainNameOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainNameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/domainnames";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.certificate_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificateArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.certificate_body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificateBody\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.certificate_chain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificateChain\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.certificate_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificateName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.certificate_private_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificatePrivateKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"domainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;
    if (input.endpoint_access_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endpointAccessMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.endpoint_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endpointConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.mutual_tls_authentication) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mutualTlsAuthentication\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ownership_verification_certificate_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ownershipVerificationCertificateArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.regional_certificate_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"regionalCertificateArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.regional_certificate_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"regionalCertificateName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.routing_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"routingMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.security_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"securityPolicy\":");
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainNameOutput {
    var result: CreateDomainNameOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDomainNameOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ApplicationProtocol = @import("application_protocol.zig").ApplicationProtocol;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const AuthorizerConfig = @import("authorizer_config.zig").AuthorizerConfig;
const ClientCertificateConfig = @import("client_certificate_config.zig").ClientCertificateConfig;
const ServerCertificateConfig = @import("server_certificate_config.zig").ServerCertificateConfig;
const ServiceType = @import("service_type.zig").ServiceType;
const Tag = @import("tag.zig").Tag;
const TlsConfig = @import("tls_config.zig").TlsConfig;

pub const CreateDomainConfigurationInput = struct {
    /// An enumerated string that speciﬁes the application-layer protocol.
    ///
    /// * `SECURE_MQTT` - MQTT over TLS.
    ///
    /// * `MQTT_WSS` - MQTT over WebSocket.
    ///
    /// * `HTTPS` - HTTP over TLS.
    ///
    /// * `DEFAULT` - Use a combination of port and Application Layer Protocol
    ///   Negotiation (ALPN) to specify application_layer protocol.
    /// For more information, see [Device communication
    /// protocols](https://docs.aws.amazon.com/iot/latest/developerguide/protocols.html).
    application_protocol: ?ApplicationProtocol = null,

    /// An enumerated string that speciﬁes the authentication type.
    ///
    /// * `CUSTOM_AUTH_X509` - Use custom authentication and authorization with
    ///   additional details from the X.509 client certificate.
    ///
    /// * `CUSTOM_AUTH` - Use custom authentication and authorization. For more
    /// information, see [Custom authentication and
    /// authorization](https://docs.aws.amazon.com/iot/latest/developerguide/custom-authentication.html).
    ///
    /// * `AWS_X509` - Use X.509 client certificates without custom authentication
    ///   and authorization. For more information,
    /// see [X.509 client
    /// certificates](https://docs.aws.amazon.com/iot/latest/developerguide/x509-client-certs.html).
    ///
    /// * `AWS_SIGV4` - Use Amazon Web Services Signature Version 4. For more
    ///   information, see [IAM users, groups, and
    ///   roles](https://docs.aws.amazon.com/iot/latest/developerguide/custom-authentication.html).
    ///
    /// * `DEFAULT` - Use a combination of port and Application Layer Protocol
    ///   Negotiation (ALPN) to specify authentication type.
    /// For more information, see [Device communication
    /// protocols](https://docs.aws.amazon.com/iot/latest/developerguide/protocols.html).
    authentication_type: ?AuthenticationType = null,

    /// An object that specifies the authorization service for a domain.
    authorizer_config: ?AuthorizerConfig = null,

    /// An object that speciﬁes the client certificate conﬁguration for a domain.
    client_certificate_config: ?ClientCertificateConfig = null,

    /// The name of the domain configuration. This value must be unique to a region.
    domain_configuration_name: []const u8,

    /// The name of the domain.
    domain_name: ?[]const u8 = null,

    /// The ARNs of the certificates that IoT passes to the device during the TLS
    /// handshake. Currently you can specify only one certificate ARN.
    /// This value is not required for Amazon Web Services-managed domains.
    server_certificate_arns: ?[]const []const u8 = null,

    /// The server certificate configuration.
    server_certificate_config: ?ServerCertificateConfig = null,

    /// The type of service delivered by the endpoint.
    ///
    /// Amazon Web Services IoT Core currently supports only the `DATA` service
    /// type.
    service_type: ?ServiceType = null,

    /// Metadata which can be used to manage the domain configuration.
    ///
    /// For URI Request parameters use format: ...key1=value1&key2=value2...
    ///
    /// For the CLI command-line parameter use format: &&tags
    /// "key1=value1&key2=value2..."
    ///
    /// For the cli-input-json file use format: "tags":
    /// "key1=value1&key2=value2..."
    tags: ?[]const Tag = null,

    /// An object that specifies the TLS configuration for a domain.
    tls_config: ?TlsConfig = null,

    /// The certificate used to validate the server certificate and prove domain
    /// name ownership. This certificate must be signed by a public certificate
    /// authority.
    /// This value is not required for Amazon Web Services-managed domains.
    validation_certificate_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_protocol = "applicationProtocol",
        .authentication_type = "authenticationType",
        .authorizer_config = "authorizerConfig",
        .client_certificate_config = "clientCertificateConfig",
        .domain_configuration_name = "domainConfigurationName",
        .domain_name = "domainName",
        .server_certificate_arns = "serverCertificateArns",
        .server_certificate_config = "serverCertificateConfig",
        .service_type = "serviceType",
        .tags = "tags",
        .tls_config = "tlsConfig",
        .validation_certificate_arn = "validationCertificateArn",
    };
};

pub const CreateDomainConfigurationOutput = struct {
    /// The ARN of the domain configuration.
    domain_configuration_arn: ?[]const u8 = null,

    /// The name of the domain configuration.
    domain_configuration_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_configuration_arn = "domainConfigurationArn",
        .domain_configuration_name = "domainConfigurationName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainConfigurationInput, options: Options) !CreateDomainConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iot");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDomainConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/domainConfigurations/");
    try path_buf.appendSlice(alloc, input.domain_configuration_name);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.application_protocol) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"applicationProtocol\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.authentication_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"authenticationType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.authorizer_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"authorizerConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.client_certificate_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientCertificateConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.domain_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"domainName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.server_certificate_arns) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"serverCertificateArns\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.server_certificate_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"serverCertificateConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.service_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"serviceType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tls_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tlsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.validation_certificate_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"validationCertificateArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDomainConfigurationOutput {
    var result: CreateDomainConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDomainConfigurationOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "CertificateConflictException")) {
        return .{ .arena = arena, .kind = .{ .certificate_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateStateException")) {
        return .{ .arena = arena, .kind = .{ .certificate_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateValidationException")) {
        return .{ .arena = arena, .kind = .{ .certificate_validation_exception = .{
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
    if (std.mem.eql(u8, error_code, "ConflictingResourceUpdateException")) {
        return .{ .arena = arena, .kind = .{ .conflicting_resource_update_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteConflictException")) {
        return .{ .arena = arena, .kind = .{ .delete_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IndexNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .index_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAggregationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_aggregation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidQueryException")) {
        return .{ .arena = arena, .kind = .{ .invalid_query_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResponseException")) {
        return .{ .arena = arena, .kind = .{ .invalid_response_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_transition_exception = .{
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
    if (std.mem.eql(u8, error_code, "MalformedPolicyException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotConfiguredException")) {
        return .{ .arena = arena, .kind = .{ .not_configured_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegistrationCodeValidationException")) {
        return .{ .arena = arena, .kind = .{ .registration_code_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceRegistrationFailureException")) {
        return .{ .arena = arena, .kind = .{ .resource_registration_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "SqlParseException")) {
        return .{ .arena = arena, .kind = .{ .sql_parse_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaskAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .task_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransferAlreadyCompletedException")) {
        return .{ .arena = arena, .kind = .{ .transfer_already_completed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransferConflictException")) {
        return .{ .arena = arena, .kind = .{ .transfer_conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VersionConflictException")) {
        return .{ .arena = arena, .kind = .{ .version_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VersionsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .versions_limit_exceeded_exception = .{
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationProtocol = @import("application_protocol.zig").ApplicationProtocol;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const AuthorizerConfig = @import("authorizer_config.zig").AuthorizerConfig;
const ClientCertificateConfig = @import("client_certificate_config.zig").ClientCertificateConfig;
const DomainConfigurationStatus = @import("domain_configuration_status.zig").DomainConfigurationStatus;
const DomainType = @import("domain_type.zig").DomainType;
const ServerCertificateConfig = @import("server_certificate_config.zig").ServerCertificateConfig;
const ServerCertificateSummary = @import("server_certificate_summary.zig").ServerCertificateSummary;
const ServiceType = @import("service_type.zig").ServiceType;
const TlsConfig = @import("tls_config.zig").TlsConfig;

pub const DescribeDomainConfigurationInput = struct {
    /// The name of the domain configuration.
    domain_configuration_name: []const u8,

    pub const json_field_names = .{
        .domain_configuration_name = "domainConfigurationName",
    };
};

pub const DescribeDomainConfigurationOutput = struct {
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

    /// The ARN of the domain configuration.
    domain_configuration_arn: ?[]const u8 = null,

    /// The name of the domain configuration.
    domain_configuration_name: ?[]const u8 = null,

    /// A Boolean value that specifies the current state of the domain
    /// configuration.
    domain_configuration_status: ?DomainConfigurationStatus = null,

    /// The name of the domain.
    domain_name: ?[]const u8 = null,

    /// The type of the domain.
    domain_type: ?DomainType = null,

    /// The date and time the domain configuration's status was last changed.
    last_status_change_date: ?i64 = null,

    /// The server certificate configuration.
    server_certificate_config: ?ServerCertificateConfig = null,

    /// A list containing summary information about the server certificate included
    /// in the domain configuration.
    server_certificates: ?[]const ServerCertificateSummary = null,

    /// The type of service delivered by the endpoint.
    service_type: ?ServiceType = null,

    /// An object that specifies the TLS configuration for a domain.
    tls_config: ?TlsConfig = null,

    pub const json_field_names = .{
        .application_protocol = "applicationProtocol",
        .authentication_type = "authenticationType",
        .authorizer_config = "authorizerConfig",
        .client_certificate_config = "clientCertificateConfig",
        .domain_configuration_arn = "domainConfigurationArn",
        .domain_configuration_name = "domainConfigurationName",
        .domain_configuration_status = "domainConfigurationStatus",
        .domain_name = "domainName",
        .domain_type = "domainType",
        .last_status_change_date = "lastStatusChangeDate",
        .server_certificate_config = "serverCertificateConfig",
        .server_certificates = "serverCertificates",
        .service_type = "serviceType",
        .tls_config = "tlsConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDomainConfigurationInput, options: CallOptions) !DescribeDomainConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDomainConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domainConfigurations/");
    try path_buf.appendSlice(allocator, input.domain_configuration_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDomainConfigurationOutput {
    const result: DescribeDomainConfigurationOutput = try aws.json.parseJsonObject(
        DescribeDomainConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

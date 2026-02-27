const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PatchOperation = @import("patch_operation.zig").PatchOperation;
const DomainNameStatus = @import("domain_name_status.zig").DomainNameStatus;
const EndpointAccessMode = @import("endpoint_access_mode.zig").EndpointAccessMode;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const MutualTlsAuthentication = @import("mutual_tls_authentication.zig").MutualTlsAuthentication;
const RoutingMode = @import("routing_mode.zig").RoutingMode;
const SecurityPolicy = @import("security_policy.zig").SecurityPolicy;

pub const UpdateDomainNameInput = struct {
    /// The name of the DomainName resource to be changed.
    domain_name: []const u8,

    /// The identifier for the domain name resource. Supported only for private
    /// custom domain names.
    domain_name_id: ?[]const u8 = null,

    /// For more information about supported patch operations, see [Patch
    /// Operations](https://docs.aws.amazon.com/apigateway/latest/api/patch-operations.html).
    patch_operations: ?[]const PatchOperation = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .domain_name_id = "domainNameId",
        .patch_operations = "patchOperations",
    };
};

pub const UpdateDomainNameOutput = struct {
    /// The reference to an Amazon Web Services-managed certificate that will be
    /// used by edge-optimized endpoint or private endpoint for this domain name.
    /// Certificate Manager is the only supported source.
    certificate_arn: ?[]const u8 = null,

    /// The name of the certificate that will be used by edge-optimized endpoint or
    /// private endpoint for this domain name.
    certificate_name: ?[]const u8 = null,

    /// The timestamp when the certificate that was used by edge-optimized endpoint
    /// or private endpoint for this domain name was uploaded.
    certificate_upload_date: ?i64 = null,

    /// The domain name of the Amazon CloudFront distribution associated with this
    /// custom domain name for an edge-optimized endpoint. You set up this
    /// association when adding a DNS record pointing the custom domain name to this
    /// distribution name. For more information about CloudFront distributions, see
    /// the Amazon CloudFront documentation.
    distribution_domain_name: ?[]const u8 = null,

    /// The region-agnostic Amazon Route 53 Hosted Zone ID of the edge-optimized
    /// endpoint. The valid value is `Z2FDTNDATAQYW2` for all the regions. For more
    /// information, see Set up a Regional Custom Domain Name and AWS Regions and
    /// Endpoints for API Gateway.
    distribution_hosted_zone_id: ?[]const u8 = null,

    /// The custom domain name as an API host name, for example,
    /// `my-api.example.com`.
    domain_name: ?[]const u8 = null,

    /// The ARN of the domain name.
    domain_name_arn: ?[]const u8 = null,

    /// The identifier for the domain name resource. Supported only for private
    /// custom domain names.
    domain_name_id: ?[]const u8 = null,

    /// The status of the DomainName migration. The valid values are `AVAILABLE` and
    /// `UPDATING`. If the status is `UPDATING`, the domain cannot be modified
    /// further until the existing operation is complete. If it is `AVAILABLE`, the
    /// domain can be updated.
    domain_name_status: ?DomainNameStatus = null,

    /// An optional text message containing detailed information about status of the
    /// DomainName migration.
    domain_name_status_message: ?[]const u8 = null,

    /// The endpoint access mode of the DomainName.
    endpoint_access_mode: ?EndpointAccessMode = null,

    /// The endpoint configuration of this DomainName showing the endpoint types and
    /// IP address types of the domain name.
    endpoint_configuration: ?EndpointConfiguration = null,

    /// A stringified JSON policy document that applies to the API Gateway
    /// Management service for this DomainName. This policy document controls access
    /// for access association sources to create domain name access associations
    /// with this DomainName. Supported only for private custom domain names.
    management_policy: ?[]const u8 = null,

    /// The mutual TLS authentication configuration for a custom domain name. If
    /// specified, API Gateway
    /// performs two-way authentication between the client and the server. Clients
    /// must present a
    /// trusted certificate to access your API.
    mutual_tls_authentication: ?MutualTlsAuthentication = null,

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
    /// used for validating the regional domain name. Certificate Manager is the
    /// only supported source.
    regional_certificate_arn: ?[]const u8 = null,

    /// The name of the certificate that will be used for validating the regional
    /// domain name.
    regional_certificate_name: ?[]const u8 = null,

    /// The domain name associated with the regional endpoint for this custom domain
    /// name. You set up this association by adding a DNS record that points the
    /// custom domain name to this regional domain name. The regional domain name is
    /// returned by API Gateway when you create a regional endpoint.
    regional_domain_name: ?[]const u8 = null,

    /// The region-specific Amazon Route 53 Hosted Zone ID of the regional endpoint.
    /// For more information, see Set up a Regional Custom Domain Name and AWS
    /// Regions and Endpoints for API Gateway.
    regional_hosted_zone_id: ?[]const u8 = null,

    /// The routing mode for this domain name. The routing mode determines how API
    /// Gateway sends traffic from your custom domain name to your private APIs.
    routing_mode: ?RoutingMode = null,

    /// The Transport Layer Security (TLS) version + cipher suite for this
    /// DomainName.
    security_policy: ?SecurityPolicy = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_name = "certificateName",
        .certificate_upload_date = "certificateUploadDate",
        .distribution_domain_name = "distributionDomainName",
        .distribution_hosted_zone_id = "distributionHostedZoneId",
        .domain_name = "domainName",
        .domain_name_arn = "domainNameArn",
        .domain_name_id = "domainNameId",
        .domain_name_status = "domainNameStatus",
        .domain_name_status_message = "domainNameStatusMessage",
        .endpoint_access_mode = "endpointAccessMode",
        .endpoint_configuration = "endpointConfiguration",
        .management_policy = "managementPolicy",
        .mutual_tls_authentication = "mutualTlsAuthentication",
        .ownership_verification_certificate_arn = "ownershipVerificationCertificateArn",
        .policy = "policy",
        .regional_certificate_arn = "regionalCertificateArn",
        .regional_certificate_name = "regionalCertificateName",
        .regional_domain_name = "regionalDomainName",
        .regional_hosted_zone_id = "regionalHostedZoneId",
        .routing_mode = "routingMode",
        .security_policy = "securityPolicy",
        .tags = "tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainNameInput, options: Options) !UpdateDomainNameOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateDomainNameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/domainnames/");
    try path_buf.appendSlice(alloc, input.domain_name);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.domain_name_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "domainNameId=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.patch_operations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"patchOperations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateDomainNameOutput {
    var result: UpdateDomainNameOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDomainNameOutput, body, alloc);
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AlarmIdentifier = @import("alarm_identifier.zig").AlarmIdentifier;
const InsufficientDataHealthStatus = @import("insufficient_data_health_status.zig").InsufficientDataHealthStatus;
const HealthCheckRegion = @import("health_check_region.zig").HealthCheckRegion;
const ResettableElementName = @import("resettable_element_name.zig").ResettableElementName;
const HealthCheck = @import("health_check.zig").HealthCheck;
const serde = @import("serde.zig");

pub const UpdateHealthCheckInput = struct {
    /// A complex type that identifies the CloudWatch alarm that you want Amazon
    /// Route 53
    /// health checkers to use to determine whether the specified health check is
    /// healthy.
    alarm_identifier: ?AlarmIdentifier = null,

    /// A complex type that contains one `ChildHealthCheck` element for each health
    /// check that you want to associate with a `CALCULATED` health check.
    child_health_checks: ?[]const []const u8 = null,

    /// Stops Route 53 from performing health checks. When you disable a health
    /// check, here's
    /// what happens:
    ///
    /// * **Health checks that check the health of
    /// endpoints:** Route 53 stops submitting requests to your
    /// application, server, or other resource.
    ///
    /// * **Calculated health checks:** Route 53 stops
    /// aggregating the status of the referenced health checks.
    ///
    /// * **Health checks that monitor CloudWatch alarms:**
    /// Route 53 stops monitoring the corresponding CloudWatch metrics.
    ///
    /// After you disable a health check, Route 53 considers the status of the
    /// health check to
    /// always be healthy. If you configured DNS failover, Route 53 continues to
    /// route traffic
    /// to the corresponding resources. Additionally, in disabled state, you can
    /// also invert the
    /// status of the health check to route traffic differently. For more
    /// information, see
    /// [Inverted](https://docs.aws.amazon.com/Route53/latest/APIReference/API_UpdateHealthCheck.html#Route53-UpdateHealthCheck-request-Inverted).
    ///
    /// Charges for a health check still apply when the health check is disabled.
    /// For more
    /// information, see [Amazon Route 53
    /// Pricing](http://aws.amazon.com/route53/pricing/).
    disabled: ?bool = null,

    /// Specify whether you want Amazon Route 53 to send the value of
    /// `FullyQualifiedDomainName` to the endpoint in the
    /// `client_hello` message during `TLS` negotiation. This allows
    /// the endpoint to respond to `HTTPS` health check requests with the applicable
    /// SSL/TLS certificate.
    ///
    /// Some endpoints require that HTTPS requests include the host name in the
    /// `client_hello` message. If you don't enable SNI, the status of the health
    /// check will be SSL alert `handshake_failure`. A health check can also have
    /// that status for other reasons. If SNI is enabled and you're still getting
    /// the error,
    /// check the SSL/TLS configuration on your endpoint and confirm that your
    /// certificate is
    /// valid.
    ///
    /// The SSL/TLS certificate on your endpoint includes a domain name in the
    /// `Common
    /// Name` field and possibly several more in the `Subject Alternative
    /// Names` field. One of the domain names in the certificate should match the
    /// value that you specify for `FullyQualifiedDomainName`. If the endpoint
    /// responds to the `client_hello` message with a certificate that does not
    /// include the domain name that you specified in `FullyQualifiedDomainName`, a
    /// health checker will retry the handshake. In the second attempt, the health
    /// checker will
    /// omit `FullyQualifiedDomainName` from the `client_hello`
    /// message.
    enable_sni: ?bool = null,

    /// The number of consecutive health checks that an endpoint must pass or fail
    /// for Amazon
    /// Route 53 to change the current status of the endpoint from unhealthy to
    /// healthy or vice
    /// versa. For more information, see [How Amazon Route 53 Determines Whether an
    /// Endpoint Is
    /// Healthy](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-determining-health-of-endpoints.html) in the
    /// *Amazon Route 53 Developer Guide*.
    ///
    /// Otherwise, if you don't specify a value for `FailureThreshold`, the default
    /// value is
    /// three health checks.
    failure_threshold: ?i32 = null,

    /// Amazon Route 53 behavior depends on whether you specify a value for
    /// `IPAddress`.
    ///
    /// If a health check already has a value for `IPAddress`, you can change
    /// the value. However, you can't update an existing health check to add or
    /// remove the
    /// value of `IPAddress`.
    ///
    /// **If you specify a value for**
    /// `IPAddress`:
    ///
    /// Route 53 sends health check requests to the specified IPv4 or IPv6 address
    /// and passes
    /// the value of `FullyQualifiedDomainName` in the `Host` header for
    /// all health checks except TCP health checks. This is typically the fully
    /// qualified DNS
    /// name of the endpoint on which you want Route 53 to perform health checks.
    ///
    /// When Route 53 checks the health of an endpoint, here is how it constructs
    /// the
    /// `Host` header:
    ///
    /// * If you specify a value of `80` for `Port` and
    /// `HTTP` or `HTTP_STR_MATCH` for `Type`,
    /// Route 53 passes the value of `FullyQualifiedDomainName` to the
    /// endpoint in the `Host` header.
    ///
    /// * If you specify a value of `443` for `Port` and
    /// `HTTPS` or `HTTPS_STR_MATCH` for `Type`,
    /// Route 53 passes the value of `FullyQualifiedDomainName` to the
    /// endpoint in the `Host` header.
    ///
    /// * If you specify another value for `Port` and any value except
    /// `TCP` for `Type`, Route 53 passes
    /// *
    /// `FullyQualifiedDomainName`:`Port`
    /// *
    /// to the endpoint in the `Host` header.
    ///
    /// If you don't specify a value for `FullyQualifiedDomainName`, Route 53
    /// substitutes the value of `IPAddress` in the `Host` header in each
    /// of the above cases.
    ///
    /// **If you don't specify a value for**
    /// `IPAddress`:
    ///
    /// If you don't specify a value for `IPAddress`, Route 53 sends a DNS request
    /// to the domain that you specify in `FullyQualifiedDomainName` at the interval
    /// you specify in `RequestInterval`. Using an IPv4 address that is returned by
    /// DNS, Route 53 then checks the health of the endpoint.
    ///
    /// If you don't specify a value for `IPAddress`, you can’t update the health
    /// check to remove the `FullyQualifiedDomainName`; if you don’t specify a value
    /// for `IPAddress` on creation, a
    /// `FullyQualifiedDomainName` is required.
    ///
    /// If you don't specify a value for `IPAddress`, Route 53 uses only IPv4
    /// to send health checks to the endpoint. If there's no resource record set
    /// with a type
    /// of A for the name that you specify for `FullyQualifiedDomainName`, the
    /// health check fails with a "DNS resolution failed" error.
    ///
    /// If you want to check the health of weighted, latency, or failover resource
    /// record sets
    /// and you choose to specify the endpoint only by `FullyQualifiedDomainName`,
    /// we
    /// recommend that you create a separate health check for each endpoint. For
    /// example, create
    /// a health check for each HTTP server that is serving content for
    /// www.example.com. For the
    /// value of `FullyQualifiedDomainName`, specify the domain name of the server
    /// (such as `us-east-2-www.example.com`), not the name of the resource record
    /// sets (www.example.com).
    ///
    /// In this configuration, if the value of `FullyQualifiedDomainName`
    /// matches the name of the resource record sets and you then associate the
    /// health check
    /// with those resource record sets, health check results will be unpredictable.
    ///
    /// In addition, if the value of `Type` is `HTTP`,
    /// `HTTPS`, `HTTP_STR_MATCH`, or `HTTPS_STR_MATCH`,
    /// Route 53 passes the value of `FullyQualifiedDomainName` in the
    /// `Host` header, as it does when you specify a value for
    /// `IPAddress`. If the value of `Type` is `TCP`, Route
    /// 53 doesn't pass a `Host` header.
    fully_qualified_domain_name: ?[]const u8 = null,

    /// The ID for the health check for which you want detailed information. When
    /// you created
    /// the health check, `CreateHealthCheck` returned the ID in the response, in
    /// the
    /// `HealthCheckId` element.
    health_check_id: []const u8,

    /// A sequential counter that Amazon Route 53 sets to `1` when you create a
    /// health check and increments by 1 each time you update settings for the
    /// health
    /// check.
    ///
    /// We recommend that you use `GetHealthCheck` or `ListHealthChecks`
    /// to get the current value of `HealthCheckVersion` for the health check that
    /// you want to update, and that you include that value in your
    /// `UpdateHealthCheck` request. This prevents Route 53 from overwriting an
    /// intervening update:
    ///
    /// * If the value in the `UpdateHealthCheck` request matches the value
    /// of `HealthCheckVersion` in the health check, Route 53 updates the
    /// health check with the new settings.
    ///
    /// * If the value of `HealthCheckVersion` in the health check is
    /// greater, the health check was changed after you got the version number.
    /// Route 53
    /// does not update the health check, and it returns a
    /// `HealthCheckVersionMismatch` error.
    health_check_version: ?i64 = null,

    /// The number of child health checks that are associated with a `CALCULATED`
    /// health that Amazon Route 53 must consider healthy for the `CALCULATED`
    /// health
    /// check to be considered healthy. To specify the child health checks that you
    /// want to
    /// associate with a `CALCULATED` health check, use the
    /// `ChildHealthChecks` and `ChildHealthCheck` elements.
    ///
    /// Note the following:
    ///
    /// * If you specify a number greater than the number of child health checks,
    ///   Route
    /// 53 always considers this health check to be unhealthy.
    ///
    /// * If you specify `0`, Route 53 always considers this health check to
    /// be healthy.
    health_threshold: ?i32 = null,

    /// When CloudWatch has insufficient data about the metric to determine the
    /// alarm state,
    /// the status that you want Amazon Route 53 to assign to the health check:
    ///
    /// * `Healthy`: Route 53 considers the health check to be
    /// healthy.
    ///
    /// * `Unhealthy`: Route 53 considers the health check to be
    /// unhealthy.
    ///
    /// * `LastKnownStatus`: By default, Route 53 uses the status of the
    /// health check from the last time CloudWatch had sufficient data to determine
    /// the
    /// alarm state. For new health checks that have no last known status, the
    /// status
    /// for the health check is healthy.
    insufficient_data_health_status: ?InsufficientDataHealthStatus = null,

    /// Specify whether you want Amazon Route 53 to invert the status of a health
    /// check, for
    /// example, to consider a health check unhealthy when it otherwise would be
    /// considered
    /// healthy.
    inverted: ?bool = null,

    /// The IPv4 or IPv6 IP address for the endpoint that you want Amazon Route 53
    /// to perform
    /// health checks on. If you don't specify a value for `IPAddress`, Route 53
    /// sends a DNS request to resolve the domain name that you specify in
    /// `FullyQualifiedDomainName` at the interval that you specify in
    /// `RequestInterval`. Using an IP address that is returned by DNS, Route 53
    /// then checks the health of the endpoint.
    ///
    /// Use one of the following formats for the value of `IPAddress`:
    ///
    /// * **IPv4 address**: four values between 0 and 255,
    /// separated by periods (.), for example, `192.0.2.44`.
    ///
    /// * **IPv6 address**: eight groups of four
    /// hexadecimal values, separated by colons (:), for example,
    /// `2001:0db8:85a3:0000:0000:abcd:0001:2345`. You can also shorten
    /// IPv6 addresses as described in RFC 5952, for example,
    /// `2001:db8:85a3::abcd:1:2345`.
    ///
    /// If the endpoint is an EC2 instance, we recommend that you create an Elastic
    /// IP
    /// address, associate it with your EC2 instance, and specify the Elastic IP
    /// address for
    /// `IPAddress`. This ensures that the IP address of your instance never
    /// changes. For more information, see the applicable documentation:
    ///
    /// * Linux: [Elastic IP
    /// Addresses
    /// (EIP)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html) in the *Amazon EC2 User Guide for Linux
    /// Instances*
    ///
    /// * Windows: [Elastic IP
    /// Addresses
    /// (EIP)](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/elastic-ip-addresses-eip.html) in the *Amazon EC2 User Guide for Windows
    /// Instances*
    ///
    /// If a health check already has a value for `IPAddress`, you can change
    /// the value. However, you can't update an existing health check to add or
    /// remove the
    /// value of `IPAddress`.
    ///
    /// For more information, see
    /// [FullyQualifiedDomainName](https://docs.aws.amazon.com/Route53/latest/APIReference/API_UpdateHealthCheck.html#Route53-UpdateHealthCheck-request-FullyQualifiedDomainName).
    ///
    /// Constraints: Route 53 can't check the health of endpoints for which the IP
    /// address is
    /// in local, private, non-routable, or multicast ranges. For more information
    /// about IP
    /// addresses for which you can't create health checks, see the following
    /// documents:
    ///
    /// * [RFC 5735, Special Use IPv4
    /// Addresses](https://tools.ietf.org/html/rfc5735)
    ///
    /// * [RFC 6598, IANA-Reserved IPv4
    /// Prefix for Shared Address Space](https://tools.ietf.org/html/rfc6598)
    ///
    /// * [RFC 5156, Special-Use IPv6
    /// Addresses](https://tools.ietf.org/html/rfc5156)
    ip_address: ?[]const u8 = null,

    /// The port on the endpoint that you want Amazon Route 53 to perform health
    /// checks
    /// on.
    ///
    /// Don't specify a value for `Port` when you specify a value for
    /// `Type` of `CLOUDWATCH_METRIC` or
    /// `CALCULATED`.
    port: ?i32 = null,

    /// A complex type that contains one `Region` element for each region that you
    /// want Amazon Route 53 health checkers to check the specified endpoint from.
    regions: ?[]const HealthCheckRegion = null,

    /// A complex type that contains one `ResettableElementName` element for each
    /// element that you want to reset to the default value. Valid values for
    /// `ResettableElementName` include the following:
    ///
    /// * `ChildHealthChecks`: Amazon Route 53 resets
    ///   [ChildHealthChecks](https://docs.aws.amazon.com/Route53/latest/APIReference/API_HealthCheckConfig.html#Route53-Type-HealthCheckConfig-ChildHealthChecks) to null.
    ///
    /// * `FullyQualifiedDomainName`: Route 53 resets
    ///   [FullyQualifiedDomainName](https://docs.aws.amazon.com/Route53/latest/APIReference/API_UpdateHealthCheck.html#Route53-UpdateHealthCheck-request-FullyQualifiedDomainName). to null.
    ///
    /// * `Regions`: Route 53 resets the
    ///   [Regions](https://docs.aws.amazon.com/Route53/latest/APIReference/API_HealthCheckConfig.html#Route53-Type-HealthCheckConfig-Regions) list to the default set of regions.
    ///
    /// * `ResourcePath`: Route 53 resets
    ///   [ResourcePath](https://docs.aws.amazon.com/Route53/latest/APIReference/API_HealthCheckConfig.html#Route53-Type-HealthCheckConfig-ResourcePath) to null.
    reset_elements: ?[]const ResettableElementName = null,

    /// The path that you want Amazon Route 53 to request when performing health
    /// checks. The
    /// path can be any value for which your endpoint will return an HTTP status
    /// code of 2xx or
    /// 3xx when the endpoint is healthy, for example the file
    /// /docs/route53-health-check.html.
    /// You can also include query string parameters, for example,
    /// `/welcome.html?language=jp&login=y`.
    ///
    /// Specify this value only if you want to change it.
    resource_path: ?[]const u8 = null,

    /// If the value of `Type` is `HTTP_STR_MATCH` or
    /// `HTTPS_STR_MATCH`, the string that you want Amazon Route 53 to search for
    /// in the response body from the specified resource. If the string appears in
    /// the response
    /// body, Route 53 considers the resource healthy. (You can't change the value
    /// of
    /// `Type` when you update a health check.)
    search_string: ?[]const u8 = null,
};

pub const UpdateHealthCheckOutput = struct {
    /// A complex type that contains the response to an `UpdateHealthCheck`
    /// request.
    health_check: ?HealthCheck = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHealthCheckInput, options: CallOptions) !UpdateHealthCheckOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "route53");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHealthCheckInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/2013-04-01/healthcheck/");
    try path_buf.appendSlice(allocator, input.health_check_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(allocator, "<UpdateHealthCheckRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    if (input.alarm_identifier) |v| {
        try body_buf.appendSlice(allocator, "<AlarmIdentifier>");
        try serde.serializeAlarmIdentifier(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</AlarmIdentifier>");
    }
    if (input.child_health_checks) |v| {
        try body_buf.appendSlice(allocator, "<ChildHealthChecks>");
        try serde.serializeChildHealthCheckList(allocator, &body_buf, v, "ChildHealthCheck");
        try body_buf.appendSlice(allocator, "</ChildHealthChecks>");
    }
    if (input.disabled) |v| {
        try body_buf.appendSlice(allocator, "<Disabled>");
        try body_buf.appendSlice(allocator, if (v) "true" else "false");
        try body_buf.appendSlice(allocator, "</Disabled>");
    }
    if (input.enable_sni) |v| {
        try body_buf.appendSlice(allocator, "<EnableSNI>");
        try body_buf.appendSlice(allocator, if (v) "true" else "false");
        try body_buf.appendSlice(allocator, "</EnableSNI>");
    }
    if (input.failure_threshold) |v| {
        try body_buf.appendSlice(allocator, "<FailureThreshold>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try body_buf.appendSlice(allocator, num_str);
        }
        try body_buf.appendSlice(allocator, "</FailureThreshold>");
    }
    if (input.fully_qualified_domain_name) |v| {
        try body_buf.appendSlice(allocator, "<FullyQualifiedDomainName>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</FullyQualifiedDomainName>");
    }
    if (input.health_check_version) |v| {
        try body_buf.appendSlice(allocator, "<HealthCheckVersion>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try body_buf.appendSlice(allocator, num_str);
        }
        try body_buf.appendSlice(allocator, "</HealthCheckVersion>");
    }
    if (input.health_threshold) |v| {
        try body_buf.appendSlice(allocator, "<HealthThreshold>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try body_buf.appendSlice(allocator, num_str);
        }
        try body_buf.appendSlice(allocator, "</HealthThreshold>");
    }
    if (input.insufficient_data_health_status) |v| {
        try body_buf.appendSlice(allocator, "<InsufficientDataHealthStatus>");
        try body_buf.appendSlice(allocator, v.wireName());
        try body_buf.appendSlice(allocator, "</InsufficientDataHealthStatus>");
    }
    if (input.inverted) |v| {
        try body_buf.appendSlice(allocator, "<Inverted>");
        try body_buf.appendSlice(allocator, if (v) "true" else "false");
        try body_buf.appendSlice(allocator, "</Inverted>");
    }
    if (input.ip_address) |v| {
        try body_buf.appendSlice(allocator, "<IPAddress>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</IPAddress>");
    }
    if (input.port) |v| {
        try body_buf.appendSlice(allocator, "<Port>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try body_buf.appendSlice(allocator, num_str);
        }
        try body_buf.appendSlice(allocator, "</Port>");
    }
    if (input.regions) |v| {
        try body_buf.appendSlice(allocator, "<Regions>");
        try serde.serializeHealthCheckRegionList(allocator, &body_buf, v, "Region");
        try body_buf.appendSlice(allocator, "</Regions>");
    }
    if (input.reset_elements) |v| {
        try body_buf.appendSlice(allocator, "<ResetElements>");
        try serde.serializeResettableElementNameList(allocator, &body_buf, v, "ResettableElementName");
        try body_buf.appendSlice(allocator, "</ResetElements>");
    }
    if (input.resource_path) |v| {
        try body_buf.appendSlice(allocator, "<ResourcePath>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</ResourcePath>");
    }
    if (input.search_string) |v| {
        try body_buf.appendSlice(allocator, "<SearchString>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</SearchString>");
    }
    try body_buf.appendSlice(allocator, "</UpdateHealthCheckRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHealthCheckOutput {
    var result: UpdateHealthCheckOutput = undefined;
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HealthCheck")) {
                    result.health_check = try serde.deserializeHealthCheck(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "CidrBlockInUseException")) {
        return .{ .arena = arena, .kind = .{ .cidr_block_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CidrCollectionAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .cidr_collection_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CidrCollectionInUseException")) {
        return .{ .arena = arena, .kind = .{ .cidr_collection_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CidrCollectionVersionMismatchException")) {
        return .{ .arena = arena, .kind = .{ .cidr_collection_version_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModification")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictingDomainExists")) {
        return .{ .arena = arena, .kind = .{ .conflicting_domain_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictingTypes")) {
        return .{ .arena = arena, .kind = .{ .conflicting_types = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetAlreadyCreated")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_already_created = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetAlreadyReusable")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_already_reusable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetInUse")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetNotAvailable")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_not_available = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegationSetNotReusable")) {
        return .{ .arena = arena, .kind = .{ .delegation_set_not_reusable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DNSSECNotFound")) {
        return .{ .arena = arena, .kind = .{ .dnssec_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HealthCheckAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .health_check_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HealthCheckInUse")) {
        return .{ .arena = arena, .kind = .{ .health_check_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HealthCheckVersionMismatch")) {
        return .{ .arena = arena, .kind = .{ .health_check_version_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZoneAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZoneNotEmpty")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_not_empty = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZoneNotFound")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZoneNotPrivate")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_not_private = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HostedZonePartiallyDelegated")) {
        return .{ .arena = arena, .kind = .{ .hosted_zone_partially_delegated = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleVersion")) {
        return .{ .arena = arena, .kind = .{ .incompatible_version = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCloudWatchLogsResourcePolicy")) {
        return .{ .arena = arena, .kind = .{ .insufficient_cloud_watch_logs_resource_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgument")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidChangeBatch")) {
        return .{ .arena = arena, .kind = .{ .invalid_change_batch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDomainName")) {
        return .{ .arena = arena, .kind = .{ .invalid_domain_name = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInput")) {
        return .{ .arena = arena, .kind = .{ .invalid_input = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKeySigningKeyName")) {
        return .{ .arena = arena, .kind = .{ .invalid_key_signing_key_name = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKeySigningKeyStatus")) {
        return .{ .arena = arena, .kind = .{ .invalid_key_signing_key_status = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKMSArn")) {
        return .{ .arena = arena, .kind = .{ .invalid_kms_arn = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSigningStatus")) {
        return .{ .arena = arena, .kind = .{ .invalid_signing_status = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTrafficPolicyDocument")) {
        return .{ .arena = arena, .kind = .{ .invalid_traffic_policy_document = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidVPCId")) {
        return .{ .arena = arena, .kind = .{ .invalid_vpc_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeySigningKeyAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .key_signing_key_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeySigningKeyInParentDSRecord")) {
        return .{ .arena = arena, .kind = .{ .key_signing_key_in_parent_ds_record = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeySigningKeyInUse")) {
        return .{ .arena = arena, .kind = .{ .key_signing_key_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeySigningKeyWithActiveStatusNotFound")) {
        return .{ .arena = arena, .kind = .{ .key_signing_key_with_active_status_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LastVPCAssociation")) {
        return .{ .arena = arena, .kind = .{ .last_vpc_association = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitsExceeded")) {
        return .{ .arena = arena, .kind = .{ .limits_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchChange")) {
        return .{ .arena = arena, .kind = .{ .no_such_change = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchCidrCollectionException")) {
        return .{ .arena = arena, .kind = .{ .no_such_cidr_collection_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchCidrLocationException")) {
        return .{ .arena = arena, .kind = .{ .no_such_cidr_location_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchCloudWatchLogsLogGroup")) {
        return .{ .arena = arena, .kind = .{ .no_such_cloud_watch_logs_log_group = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchDelegationSet")) {
        return .{ .arena = arena, .kind = .{ .no_such_delegation_set = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchGeoLocation")) {
        return .{ .arena = arena, .kind = .{ .no_such_geo_location = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchHealthCheck")) {
        return .{ .arena = arena, .kind = .{ .no_such_health_check = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchHostedZone")) {
        return .{ .arena = arena, .kind = .{ .no_such_hosted_zone = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKeySigningKey")) {
        return .{ .arena = arena, .kind = .{ .no_such_key_signing_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchQueryLoggingConfig")) {
        return .{ .arena = arena, .kind = .{ .no_such_query_logging_config = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchTrafficPolicy")) {
        return .{ .arena = arena, .kind = .{ .no_such_traffic_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchTrafficPolicyInstance")) {
        return .{ .arena = arena, .kind = .{ .no_such_traffic_policy_instance = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PriorRequestNotComplete")) {
        return .{ .arena = arena, .kind = .{ .prior_request_not_complete = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PublicZoneVPCAssociation")) {
        return .{ .arena = arena, .kind = .{ .public_zone_vpc_association = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryLoggingConfigAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .query_logging_config_already_exists = .{
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
    if (std.mem.eql(u8, error_code, "TooManyHealthChecks")) {
        return .{ .arena = arena, .kind = .{ .too_many_health_checks = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyHostedZones")) {
        return .{ .arena = arena, .kind = .{ .too_many_hosted_zones = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyKeySigningKeys")) {
        return .{ .arena = arena, .kind = .{ .too_many_key_signing_keys = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrafficPolicies")) {
        return .{ .arena = arena, .kind = .{ .too_many_traffic_policies = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrafficPolicyInstances")) {
        return .{ .arena = arena, .kind = .{ .too_many_traffic_policy_instances = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrafficPolicyVersionsForCurrentPolicy")) {
        return .{ .arena = arena, .kind = .{ .too_many_traffic_policy_versions_for_current_policy = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyVPCAssociationAuthorizations")) {
        return .{ .arena = arena, .kind = .{ .too_many_vpc_association_authorizations = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrafficPolicyAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .traffic_policy_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrafficPolicyInUse")) {
        return .{ .arena = arena, .kind = .{ .traffic_policy_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrafficPolicyInstanceAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .traffic_policy_instance_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VPCAssociationAuthorizationNotFound")) {
        return .{ .arena = arena, .kind = .{ .vpc_association_authorization_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VPCAssociationNotFound")) {
        return .{ .arena = arena, .kind = .{ .vpc_association_not_found = .{
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

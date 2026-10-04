const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalResolverIpAddressType = @import("global_resolver_ip_address_type.zig").GlobalResolverIpAddressType;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const CreateGlobalResolverInput = struct {
    /// A unique string that identifies the request and ensures idempotency. If you
    /// make multiple requests with the same client token, only one Route 53 Global
    /// Resolver is created.
    client_token: ?[]const u8 = null,

    /// An optional description for the Route 53 Global Resolver instance. Maximum
    /// length of 1024 characters.
    description: ?[]const u8 = null,

    /// The IP address type for the Route 53 Global Resolver. Valid values are IPV4
    /// (default) or DUAL_STACK for both IPv4 and IPv6 support.
    ip_address_type: ?GlobalResolverIpAddressType = null,

    /// A descriptive name for the Route 53 Global Resolver instance. Maximum length
    /// of 64 characters.
    name: []const u8,

    /// The Amazon Web Services Region where query resolution logs and metrics will
    /// be aggregated and delivered. If not specified, logging is not enabled.
    observability_region: ?[]const u8 = null,

    /// List of Amazon Web Services Regions where the Route 53 Global Resolver will
    /// operate. The resolver will be distributed across these Regions to provide
    /// global availability and low-latency DNS resolution.
    regions: []const []const u8,

    /// Tags to associate with the Route 53 Global Resolver. Tags are key-value
    /// pairs that help you organize and identify your resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .observability_region = "observabilityRegion",
        .regions = "regions",
        .tags = "tags",
    };
};

pub const CreateGlobalResolverOutput = struct {
    /// The Amazon Resource Name (ARN) of the Route 53 Global Resolver.
    arn: []const u8,

    /// The unique string that identifies the request and ensures idempotency.
    client_token: []const u8,

    /// The date and time when the Route 53 Global Resolver was created.
    created_at: i64,

    /// The description of the Route 53 Global Resolver.
    description: ?[]const u8 = null,

    /// The hostname that DNS clients should use for TLS certificate validation when
    /// connecting to the Route 53 Global Resolver. This value resolves to the
    /// global anycast IP addresses for the resolver.
    dns_name: []const u8,

    /// The unique identifier for the Route 53 Global Resolver.
    id: []const u8,

    /// The IP address type configured for the Route 53 Global Resolver (IPV4 or
    /// DUAL_STACK).
    ip_address_type: ?GlobalResolverIpAddressType = null,

    /// The global anycast IPv4 addresses associated with the Route 53 Global
    /// Resolver. DNS clients can send queries to these addresses from anywhere on
    /// the internet.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// The global anycast IPv6 addresses associated with the Route 53 Global
    /// Resolver. This field is only populated when ipAddressType is DUAL_STACK. DNS
    /// clients can send queries to these addresses from anywhere on the internet.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// The name of the Route 53 Global Resolver.
    name: []const u8,

    /// The Amazon Web Services Region where observability data for the Route 53
    /// Global Resolver is stored.
    observability_region: ?[]const u8 = null,

    /// The Amazon Web Services Regions where the Route 53 Global Resolver is
    /// deployed and operational.
    regions: ?[]const []const u8 = null,

    /// The current status of the Route 53 Global Resolver. Possible values are
    /// CREATING (being provisioned), UPDATING (being modified), OPERATIONAL (ready
    /// to serve queries), or DELETING (being removed).
    status: CRResourceStatus,

    /// The date and time when the Route 53 Global Resolver was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .dns_name = "dnsName",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .ipv_4_addresses = "ipv4Addresses",
        .ipv_6_addresses = "ipv6Addresses",
        .name = "name",
        .observability_region = "observabilityRegion",
        .regions = "regions",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGlobalResolverInput, options: CallOptions) !CreateGlobalResolverOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53globalresolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGlobalResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/global-resolver";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ipAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.observability_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"observabilityRegion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"regions\":");
    try aws.json.writeValue(@TypeOf(input.regions), input.regions, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGlobalResolverOutput {
    var result: CreateGlobalResolverOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGlobalResolverOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

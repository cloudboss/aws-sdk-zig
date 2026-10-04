const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Customizations = @import("customizations.zig").Customizations;
const DomainItem = @import("domain_item.zig").DomainItem;
const ManagedCertificateRequest = @import("managed_certificate_request.zig").ManagedCertificateRequest;
const Parameter = @import("parameter.zig").Parameter;
const Tags = @import("tags.zig").Tags;
const DistributionTenant = @import("distribution_tenant.zig").DistributionTenant;
const serde = @import("serde.zig");

pub const CreateDistributionTenantInput = struct {
    /// The ID of the connection group to associate with the distribution tenant.
    connection_group_id: ?[]const u8 = null,

    /// Customizations for the distribution tenant. For each distribution tenant,
    /// you can specify the geographic restrictions, and the Amazon Resource Names
    /// (ARNs) for the ACM certificate and WAF web ACL. These are specific values
    /// that you can override or disable from the multi-tenant distribution that was
    /// used to create the distribution tenant.
    customizations: ?Customizations = null,

    /// The ID of the multi-tenant distribution to use for creating the distribution
    /// tenant.
    distribution_id: []const u8,

    /// The domains associated with the distribution tenant. You must specify at
    /// least one domain in the request.
    domains: []const DomainItem,

    /// Indicates whether the distribution tenant should be enabled when created. If
    /// the distribution tenant is disabled, the distribution tenant won't serve
    /// traffic.
    enabled: ?bool = null,

    /// The configuration for the CloudFront managed ACM certificate request.
    managed_certificate_request: ?ManagedCertificateRequest = null,

    /// The name of the distribution tenant. Enter a friendly identifier that is
    /// unique within your Amazon Web Services account. This name can't be updated
    /// after you create the distribution tenant.
    name: []const u8,

    /// A list of parameter values to add to the resource. A parameter is specified
    /// as a key-value pair. A valid parameter value must exist for any parameter
    /// that is marked as required in the multi-tenant distribution.
    parameters: ?[]const Parameter = null,

    tags: ?Tags = null,
};

pub const CreateDistributionTenantOutput = struct {
    /// The distribution tenant that you created.
    distribution_tenant: ?DistributionTenant = null,

    /// The current version of the distribution tenant.
    e_tag: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDistributionTenantInput, options: CallOptions) !CreateDistributionTenantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDistributionTenantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/distribution-tenant";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateDistributionTenantRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.connection_group_id) |v| {
        try body_buf.appendSlice(allocator, "<ConnectionGroupId>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</ConnectionGroupId>");
    }
    if (input.customizations) |v| {
        try body_buf.appendSlice(allocator, "<Customizations>");
        try serde.serializeCustomizations(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Customizations>");
    }
    try body_buf.appendSlice(allocator, "<DistributionId>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.distribution_id);
    try body_buf.appendSlice(allocator, "</DistributionId>");
    try body_buf.appendSlice(allocator, "<Domains>");
    try serde.serializeDomainList(allocator, &body_buf, input.domains, "member");
    try body_buf.appendSlice(allocator, "</Domains>");
    if (input.enabled) |v| {
        try body_buf.appendSlice(allocator, "<Enabled>");
        try body_buf.appendSlice(allocator, if (v) "true" else "false");
        try body_buf.appendSlice(allocator, "</Enabled>");
    }
    if (input.managed_certificate_request) |v| {
        try body_buf.appendSlice(allocator, "<ManagedCertificateRequest>");
        try serde.serializeManagedCertificateRequest(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</ManagedCertificateRequest>");
    }
    try body_buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "</Name>");
    if (input.parameters) |v| {
        try body_buf.appendSlice(allocator, "<Parameters>");
        try serde.serializeParameters(allocator, &body_buf, v, "member");
        try body_buf.appendSlice(allocator, "</Parameters>");
    }
    if (input.tags) |v| {
        try body_buf.appendSlice(allocator, "<Tags>");
        try serde.serializeTags(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Tags>");
    }
    try body_buf.appendSlice(allocator, "</CreateDistributionTenantRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDistributionTenantOutput {
    var result: CreateDistributionTenantOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}

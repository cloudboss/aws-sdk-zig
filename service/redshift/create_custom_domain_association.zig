const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateCustomDomainAssociationInput = struct {
    /// The cluster identifier that the custom domain is associated with.
    cluster_identifier: []const u8,

    /// The certificate Amazon Resource Name (ARN) for the custom domain name
    /// association.
    custom_domain_certificate_arn: []const u8,

    /// The custom domain name for a custom domain association.
    custom_domain_name: []const u8,
};

pub const CreateCustomDomainAssociationOutput = struct {
    /// The identifier of the cluster that the custom domain is associated with.
    cluster_identifier: ?[]const u8 = null,

    /// The expiration time for the certificate for the custom domain.
    custom_domain_cert_expiry_time: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the certificate associated with the
    /// custom domain name.
    custom_domain_certificate_arn: ?[]const u8 = null,

    /// The custom domain name for the association result.
    custom_domain_name: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomDomainAssociationInput, options: CallOptions) !CreateCustomDomainAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomDomainAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateCustomDomainAssociation&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    try body_buf.appendSlice(allocator, "&CustomDomainCertificateArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.custom_domain_certificate_arn);
    try body_buf.appendSlice(allocator, "&CustomDomainName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.custom_domain_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomDomainAssociationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateCustomDomainAssociationResult")) break;
            },
            else => {},
        }
    }

    var result: CreateCustomDomainAssociationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomDomainCertExpiryTime")) {
                    result.custom_domain_cert_expiry_time = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomDomainCertificateArn")) {
                    result.custom_domain_certificate_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomDomainName")) {
                    result.custom_domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

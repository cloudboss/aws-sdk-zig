const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateCustomDomainAssociationInput = struct {
    /// The custom domain name’s certificate Amazon resource name (ARN).
    custom_domain_certificate_arn: []const u8,

    /// The custom domain name to associate with the workgroup.
    custom_domain_name: []const u8,

    /// The name of the workgroup associated with the database.
    workgroup_name: []const u8,

    pub const json_field_names = .{
        .custom_domain_certificate_arn = "customDomainCertificateArn",
        .custom_domain_name = "customDomainName",
        .workgroup_name = "workgroupName",
    };
};

pub const CreateCustomDomainAssociationOutput = struct {
    /// The custom domain name’s certificate Amazon resource name (ARN).
    custom_domain_certificate_arn: ?[]const u8 = null,

    /// The expiration time for the certificate.
    custom_domain_certificate_expiry_time: ?i64 = null,

    /// The custom domain name to associate with the workgroup.
    custom_domain_name: ?[]const u8 = null,

    /// The name of the workgroup associated with the database.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_domain_certificate_arn = "customDomainCertificateArn",
        .custom_domain_certificate_expiry_time = "customDomainCertificateExpiryTime",
        .custom_domain_name = "customDomainName",
        .workgroup_name = "workgroupName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomDomainAssociationInput, options: CallOptions) !CreateCustomDomainAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.CreateCustomDomainAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomDomainAssociationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCustomDomainAssociationOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthType = @import("auth_type.zig").AuthType;
const DnsEntry = @import("dns_entry.zig").DnsEntry;
const ServiceStatus = @import("service_status.zig").ServiceStatus;

pub const GetServiceInput = struct {
    /// The ID or ARN of the service.
    service_identifier: []const u8,

    pub const json_field_names = .{
        .service_identifier = "serviceIdentifier",
    };
};

pub const GetServiceOutput = struct {
    /// The Amazon Resource Name (ARN) of the service.
    arn: ?[]const u8 = null,

    /// The type of IAM policy.
    auth_type: ?AuthType = null,

    /// The Amazon Resource Name (ARN) of the certificate.
    certificate_arn: ?[]const u8 = null,

    /// The date and time that the service was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The custom domain name of the service.
    custom_domain_name: ?[]const u8 = null,

    /// The DNS name of the service.
    dns_entry: ?DnsEntry = null,

    /// The failure code.
    failure_code: ?[]const u8 = null,

    /// The failure message.
    failure_message: ?[]const u8 = null,

    /// The ID of the service.
    id: ?[]const u8 = null,

    /// The amount of time, in seconds, that a connection can remain idle before VPC
    /// Lattice closes it.
    idle_timeout_seconds: ?i32 = null,

    /// The date and time that the service was last updated, in ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// The name of the service.
    name: ?[]const u8 = null,

    /// The status of the service.
    status: ?ServiceStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .auth_type = "authType",
        .certificate_arn = "certificateArn",
        .created_at = "createdAt",
        .custom_domain_name = "customDomainName",
        .dns_entry = "dnsEntry",
        .failure_code = "failureCode",
        .failure_message = "failureMessage",
        .id = "id",
        .idle_timeout_seconds = "idleTimeoutSeconds",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceInput, options: CallOptions) !GetServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/services/");
    try path_buf.appendSlice(allocator, input.service_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceOutput {
    const result: GetServiceOutput = try aws.json.parseJsonObject(
        GetServiceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

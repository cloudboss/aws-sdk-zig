const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DnsEntry = @import("dns_entry.zig").DnsEntry;
const ServiceNetworkServiceAssociationStatus = @import("service_network_service_association_status.zig").ServiceNetworkServiceAssociationStatus;

pub const GetServiceNetworkServiceAssociationInput = struct {
    /// The ID or ARN of the association.
    service_network_service_association_identifier: []const u8,

    pub const json_field_names = .{
        .service_network_service_association_identifier = "serviceNetworkServiceAssociationIdentifier",
    };
};

pub const GetServiceNetworkServiceAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: ?[]const u8 = null,

    /// The date and time that the association was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The account that created the association.
    created_by: ?[]const u8 = null,

    /// The custom domain name of the service.
    custom_domain_name: ?[]const u8 = null,

    /// The DNS name of the service.
    dns_entry: ?DnsEntry = null,

    /// The failure code.
    failure_code: ?[]const u8 = null,

    /// The failure message.
    failure_message: ?[]const u8 = null,

    /// The ID of the service network and service association.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service.
    service_arn: ?[]const u8 = null,

    /// The ID of the service.
    service_id: ?[]const u8 = null,

    /// The name of the service.
    service_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service network.
    service_network_arn: ?[]const u8 = null,

    /// The ID of the service network.
    service_network_id: ?[]const u8 = null,

    /// The name of the service network.
    service_network_name: ?[]const u8 = null,

    /// The status of the association.
    status: ?ServiceNetworkServiceAssociationStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .custom_domain_name = "customDomainName",
        .dns_entry = "dnsEntry",
        .failure_code = "failureCode",
        .failure_message = "failureMessage",
        .id = "id",
        .service_arn = "serviceArn",
        .service_id = "serviceId",
        .service_name = "serviceName",
        .service_network_arn = "serviceNetworkArn",
        .service_network_id = "serviceNetworkId",
        .service_network_name = "serviceNetworkName",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceNetworkServiceAssociationInput, options: CallOptions) !GetServiceNetworkServiceAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceNetworkServiceAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/servicenetworkserviceassociations/");
    try path_buf.appendSlice(allocator, input.service_network_service_association_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceNetworkServiceAssociationOutput {
    var result: GetServiceNetworkServiceAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetServiceNetworkServiceAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

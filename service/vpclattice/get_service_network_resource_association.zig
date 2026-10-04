const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DnsEntry = @import("dns_entry.zig").DnsEntry;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;
const ServiceNetworkResourceAssociationStatus = @import("service_network_resource_association_status.zig").ServiceNetworkResourceAssociationStatus;

pub const GetServiceNetworkResourceAssociationInput = struct {
    /// The ID of the association.
    service_network_resource_association_identifier: []const u8,

    pub const json_field_names = .{
        .service_network_resource_association_identifier = "serviceNetworkResourceAssociationIdentifier",
    };
};

pub const GetServiceNetworkResourceAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: ?[]const u8 = null,

    /// The date and time that the association was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The account that created the association.
    created_by: ?[]const u8 = null,

    /// The DNS entry for the service.
    dns_entry: ?DnsEntry = null,

    /// The domain verification status in the service network resource association.
    domain_verification_status: ?VerificationStatus = null,

    /// The failure code.
    failure_code: ?[]const u8 = null,

    /// The reason the association request failed.
    failure_reason: ?[]const u8 = null,

    /// The ID of the association.
    id: ?[]const u8 = null,

    /// Indicates whether the association is managed by Amazon.
    is_managed_association: ?bool = null,

    /// The most recent date and time that the association was updated, in ISO-8601
    /// format.
    last_updated_at: ?i64 = null,

    /// Indicates if private DNS is enabled in the service network resource
    /// association.
    private_dns_enabled: ?bool = null,

    /// The private DNS entry for the service.
    private_dns_entry: ?DnsEntry = null,

    /// The Amazon Resource Name (ARN) of the association.
    resource_configuration_arn: ?[]const u8 = null,

    /// The ID of the resource configuration that is associated with the service
    /// network.
    resource_configuration_id: ?[]const u8 = null,

    /// The name of the resource configuration that is associated with the service
    /// network.
    resource_configuration_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service network that is associated
    /// with the resource configuration.
    service_network_arn: ?[]const u8 = null,

    /// The ID of the service network that is associated with the resource
    /// configuration.
    service_network_id: ?[]const u8 = null,

    /// The name of the service network that is associated with the resource
    /// configuration.
    service_network_name: ?[]const u8 = null,

    /// The status of the association.
    status: ?ServiceNetworkResourceAssociationStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .dns_entry = "dnsEntry",
        .domain_verification_status = "domainVerificationStatus",
        .failure_code = "failureCode",
        .failure_reason = "failureReason",
        .id = "id",
        .is_managed_association = "isManagedAssociation",
        .last_updated_at = "lastUpdatedAt",
        .private_dns_enabled = "privateDnsEnabled",
        .private_dns_entry = "privateDnsEntry",
        .resource_configuration_arn = "resourceConfigurationArn",
        .resource_configuration_id = "resourceConfigurationId",
        .resource_configuration_name = "resourceConfigurationName",
        .service_network_arn = "serviceNetworkArn",
        .service_network_id = "serviceNetworkId",
        .service_network_name = "serviceNetworkName",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceNetworkResourceAssociationInput, options: CallOptions) !GetServiceNetworkResourceAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceNetworkResourceAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/servicenetworkresourceassociations/");
    try path_buf.appendSlice(allocator, input.service_network_resource_association_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceNetworkResourceAssociationOutput {
    var result: GetServiceNetworkResourceAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetServiceNetworkResourceAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

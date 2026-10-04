const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HostedZoneAssociationStatus = @import("hosted_zone_association_status.zig").HostedZoneAssociationStatus;

pub const DisassociateHostedZoneInput = struct {
    /// The ID of the Route 53 private hosted zone to disassociate.
    hosted_zone_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Route 53 Global Resolver resource to
    /// disassociate the hosted zone from.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .hosted_zone_id = "hostedZoneId",
        .resource_arn = "resourceArn",
    };
};

pub const DisassociateHostedZoneOutput = struct {
    /// The date and time when the association was originally created.
    created_at: i64,

    /// The ID of the Route 53 private hosted zone that was disassociated.
    hosted_zone_id: []const u8,

    /// The name of the Route 53 private hosted zone that was disassociated.
    hosted_zone_name: []const u8,

    /// The unique identifier of the disassociation.
    id: []const u8,

    /// The name of the association that was removed.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the Route 53 Global Resolver resource that
    /// the hosted zone was disassociated from.
    resource_arn: []const u8,

    /// The final status of the disassociation.
    status: HostedZoneAssociationStatus,

    /// The date and time when the association was last updated before
    /// disassociation.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .hosted_zone_id = "hostedZoneId",
        .hosted_zone_name = "hostedZoneName",
        .id = "id",
        .name = "name",
        .resource_arn = "resourceArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateHostedZoneInput, options: CallOptions) !DisassociateHostedZoneOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateHostedZoneInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/hosted-zone-associations/hosted-zone/");
    try path_buf.appendSlice(allocator, input.hosted_zone_id);
    try path_buf.appendSlice(allocator, "/resource-arn/");
    try path_buf.appendSlice(allocator, input.resource_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateHostedZoneOutput {
    const result: DisassociateHostedZoneOutput = try aws.json.parseJsonObject(
        DisassociateHostedZoneOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

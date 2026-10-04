const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HostedZoneAssociationStatus = @import("hosted_zone_association_status.zig").HostedZoneAssociationStatus;

pub const AssociateHostedZoneInput = struct {
    /// The ID of the Route 53 private hosted zone to associate with the Route 53
    /// Global Resolver resource.
    hosted_zone_id: []const u8,

    /// Name for the private hosted zone association.
    name: []const u8,

    /// An Amazon Resource Name (ARN) of the Route 53 Global Resolver the private
    /// hosted zone will be associated to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .hosted_zone_id = "hostedZoneId",
        .name = "name",
        .resource_arn = "resourceArn",
    };
};

pub const AssociateHostedZoneOutput = struct {
    /// The date and time the private hosted zone association was created.
    created_at: i64,

    /// ID of the private hosted zone.
    hosted_zone_id: []const u8,

    /// Name of the hosted zone (also the domain associated with the hosted zone).
    hosted_zone_name: []const u8,

    /// ID of the association.
    id: []const u8,

    /// Name for the private hosted zone association.
    name: []const u8,

    /// An Amazon Resource Name (ARN) of the Route 53 Global Resolver the private
    /// hosted zone is associated to.
    resource_arn: []const u8,

    /// Aggregate status for all the Amazon Web Services Regions in which the Route
    /// 53 Global Resolver exists.
    status: HostedZoneAssociationStatus,

    /// The date and time the private hosted zone association was modified.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateHostedZoneInput, options: CallOptions) !AssociateHostedZoneOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateHostedZoneInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/hosted-zone-associations/");
    try path_buf.appendSlice(allocator, input.hosted_zone_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateHostedZoneOutput {
    var result: AssociateHostedZoneOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateHostedZoneOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

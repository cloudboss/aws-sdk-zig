const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HostedZoneAssociationStatus = @import("hosted_zone_association_status.zig").HostedZoneAssociationStatus;

pub const UpdateHostedZoneAssociationInput = struct {
    /// The ID of the private hosted zone association.
    hosted_zone_association_id: []const u8,

    /// The name you want to update the hosted zone association to.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .hosted_zone_association_id = "hostedZoneAssociationId",
        .name = "name",
    };
};

pub const UpdateHostedZoneAssociationOutput = struct {
    /// The time and date the private hosted zone association was created.
    created_at: i64,

    /// The ID of the private hosted zone.
    hosted_zone_id: []const u8,

    /// The name of the domain associated with the private hosted zone.
    hosted_zone_name: []const u8,

    /// The ID of the private hosted zone association.
    id: []const u8,

    /// The name of the private hosted zone association.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the private hosted zone association.
    resource_arn: []const u8,

    /// The operational status of the private hosted zone association.
    status: HostedZoneAssociationStatus,

    /// The time and date the private hosted zone association was updated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHostedZoneAssociationInput, options: CallOptions) !UpdateHostedZoneAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHostedZoneAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/hosted-zone-associations/");
    try path_buf.appendSlice(allocator, input.hosted_zone_association_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHostedZoneAssociationOutput {
    var result: UpdateHostedZoneAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateHostedZoneAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

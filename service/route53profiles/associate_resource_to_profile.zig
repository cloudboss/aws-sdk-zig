const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileResourceAssociation = @import("profile_resource_association.zig").ProfileResourceAssociation;

pub const AssociateResourceToProfileInput = struct {
    /// Name for the resource association.
    name: []const u8,

    /// ID of the Profile.
    profile_id: []const u8,

    /// Amazon resource number, ARN, of the DNS resource.
    resource_arn: []const u8,

    /// If you are adding a DNS Firewall rule group, include also a priority. The
    /// priority indicates the processing order for the rule groups, starting with
    /// the priority assinged the lowest value.
    ///
    /// The allowed values for priority are between 100 and 9900.
    resource_properties: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .profile_id = "ProfileId",
        .resource_arn = "ResourceArn",
        .resource_properties = "ResourceProperties",
    };
};

pub const AssociateResourceToProfileOutput = struct {
    /// Infromation about the `AssociateResourceToProfile`, including a status
    /// message.
    profile_resource_association: ?ProfileResourceAssociation = null,

    pub const json_field_names = .{
        .profile_resource_association = "ProfileResourceAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateResourceToProfileInput, options: CallOptions) !AssociateResourceToProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53profiles", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateResourceToProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53profiles", "Route53Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/profileresourceassociation";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProfileId\":");
    try aws.json.writeValue(@TypeOf(input.profile_id), input.profile_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;
    if (input.resource_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceProperties\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateResourceToProfileOutput {
    var result: AssociateResourceToProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateResourceToProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

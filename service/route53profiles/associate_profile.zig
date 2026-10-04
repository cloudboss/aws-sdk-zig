const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ProfileAssociation = @import("profile_association.zig").ProfileAssociation;

pub const AssociateProfileInput = struct {
    /// A name for the association.
    name: []const u8,

    /// ID of the Profile.
    profile_id: []const u8,

    /// The ID of the VPC.
    resource_id: []const u8,

    /// A list of the tag keys and values that you want to identify the Profile
    /// association.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .name = "Name",
        .profile_id = "ProfileId",
        .resource_id = "ResourceId",
        .tags = "Tags",
    };
};

pub const AssociateProfileOutput = struct {
    /// The association that you just created. The association has an ID that you
    /// can use to identify it in other requests, like update and delete.
    profile_association: ?ProfileAssociation = null,

    pub const json_field_names = .{
        .profile_association = "ProfileAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateProfileInput, options: CallOptions) !AssociateProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53profiles", "Route53Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/profileassociation";

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
    try body_buf.appendSlice(allocator, "\"ResourceId\":");
    try aws.json.writeValue(@TypeOf(input.resource_id), input.resource_id, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateProfileOutput {
    var result: AssociateProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

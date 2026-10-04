const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdMappingConfig = @import("id_mapping_config.zig").IdMappingConfig;
const IdNamespaceAssociation = @import("id_namespace_association.zig").IdNamespaceAssociation;

pub const UpdateIdNamespaceAssociationInput = struct {
    /// A new description for the ID namespace association.
    description: ?[]const u8 = null,

    /// The configuration settings for the ID mapping table.
    id_mapping_config: ?IdMappingConfig = null,

    /// The unique identifier of the ID namespace association that you want to
    /// update.
    id_namespace_association_identifier: []const u8,

    /// The unique identifier of the membership that contains the ID namespace
    /// association that you want to update.
    membership_identifier: []const u8,

    /// A new name for the ID namespace association.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .id_mapping_config = "idMappingConfig",
        .id_namespace_association_identifier = "idNamespaceAssociationIdentifier",
        .membership_identifier = "membershipIdentifier",
        .name = "name",
    };
};

pub const UpdateIdNamespaceAssociationOutput = struct {
    /// The updated ID namespace association.
    id_namespace_association: ?IdNamespaceAssociation = null,

    pub const json_field_names = .{
        .id_namespace_association = "idNamespaceAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIdNamespaceAssociationInput, options: CallOptions) !UpdateIdNamespaceAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIdNamespaceAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/idnamespaceassociations/");
    try path_buf.appendSlice(allocator, input.id_namespace_association_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.id_mapping_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idMappingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIdNamespaceAssociationOutput {
    const result: UpdateIdNamespaceAssociationOutput = try aws.json.parseJsonObject(
        UpdateIdNamespaceAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

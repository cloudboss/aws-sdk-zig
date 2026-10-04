const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CollaborationIdNamespaceAssociation = @import("collaboration_id_namespace_association.zig").CollaborationIdNamespaceAssociation;

pub const GetCollaborationIdNamespaceAssociationInput = struct {
    /// The unique identifier of the collaboration that contains the ID namespace
    /// association that you want to retrieve.
    collaboration_identifier: []const u8,

    /// The unique identifier of the ID namespace association that you want to
    /// retrieve.
    id_namespace_association_identifier: []const u8,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .id_namespace_association_identifier = "idNamespaceAssociationIdentifier",
    };
};

pub const GetCollaborationIdNamespaceAssociationOutput = struct {
    /// The ID namespace association that you requested.
    collaboration_id_namespace_association: ?CollaborationIdNamespaceAssociation = null,

    pub const json_field_names = .{
        .collaboration_id_namespace_association = "collaborationIdNamespaceAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCollaborationIdNamespaceAssociationInput, options: CallOptions) !GetCollaborationIdNamespaceAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCollaborationIdNamespaceAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/idnamespaceassociations/");
    try path_buf.appendSlice(allocator, input.id_namespace_association_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCollaborationIdNamespaceAssociationOutput {
    var result: GetCollaborationIdNamespaceAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCollaborationIdNamespaceAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

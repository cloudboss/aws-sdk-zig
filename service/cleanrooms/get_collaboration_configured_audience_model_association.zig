const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CollaborationConfiguredAudienceModelAssociation = @import("collaboration_configured_audience_model_association.zig").CollaborationConfiguredAudienceModelAssociation;

pub const GetCollaborationConfiguredAudienceModelAssociationInput = struct {
    /// A unique identifier for the collaboration that the configured audience model
    /// association belongs to. Accepts a collaboration ID.
    collaboration_identifier: []const u8,

    /// A unique identifier for the configured audience model association that you
    /// want to retrieve.
    configured_audience_model_association_identifier: []const u8,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_audience_model_association_identifier = "configuredAudienceModelAssociationIdentifier",
    };
};

pub const GetCollaborationConfiguredAudienceModelAssociationOutput = struct {
    /// The metadata of the configured audience model association.
    collaboration_configured_audience_model_association: ?CollaborationConfiguredAudienceModelAssociation = null,

    pub const json_field_names = .{
        .collaboration_configured_audience_model_association = "collaborationConfiguredAudienceModelAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCollaborationConfiguredAudienceModelAssociationInput, options: CallOptions) !GetCollaborationConfiguredAudienceModelAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCollaborationConfiguredAudienceModelAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/configuredaudiencemodelassociations/");
    try path_buf.appendSlice(allocator, input.configured_audience_model_association_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCollaborationConfiguredAudienceModelAssociationOutput {
    var result: GetCollaborationConfiguredAudienceModelAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCollaborationConfiguredAudienceModelAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

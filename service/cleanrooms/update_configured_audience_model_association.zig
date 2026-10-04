const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfiguredAudienceModelAssociation = @import("configured_audience_model_association.zig").ConfiguredAudienceModelAssociation;

pub const UpdateConfiguredAudienceModelAssociationInput = struct {
    /// A unique identifier for the configured audience model association that you
    /// want to update.
    configured_audience_model_association_identifier: []const u8,

    /// A new description for the configured audience model association.
    description: ?[]const u8 = null,

    /// A unique identifier of the membership that contains the configured audience
    /// model association that you want to update.
    membership_identifier: []const u8,

    /// A new name for the configured audience model association.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .configured_audience_model_association_identifier = "configuredAudienceModelAssociationIdentifier",
        .description = "description",
        .membership_identifier = "membershipIdentifier",
        .name = "name",
    };
};

pub const UpdateConfiguredAudienceModelAssociationOutput = struct {
    /// Details about the configured audience model association that you updated.
    configured_audience_model_association: ?ConfiguredAudienceModelAssociation = null,

    pub const json_field_names = .{
        .configured_audience_model_association = "configuredAudienceModelAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConfiguredAudienceModelAssociationInput, options: CallOptions) !UpdateConfiguredAudienceModelAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConfiguredAudienceModelAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/configuredaudiencemodelassociations/");
    try path_buf.appendSlice(allocator, input.configured_audience_model_association_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConfiguredAudienceModelAssociationOutput {
    const result: UpdateConfiguredAudienceModelAssociationOutput = try aws.json.parseJsonObject(
        UpdateConfiguredAudienceModelAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

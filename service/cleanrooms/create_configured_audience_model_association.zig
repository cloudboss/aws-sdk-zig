const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfiguredAudienceModelAssociation = @import("configured_audience_model_association.zig").ConfiguredAudienceModelAssociation;

pub const CreateConfiguredAudienceModelAssociationInput = struct {
    /// A unique identifier for the configured audience model that you want to
    /// associate.
    configured_audience_model_arn: []const u8,

    /// The name of the configured audience model association.
    configured_audience_model_association_name: []const u8,

    /// A description of the configured audience model association.
    description: ?[]const u8 = null,

    /// When `TRUE`, indicates that the resource policy for the configured audience
    /// model resource being associated is configured for Clean Rooms to manage
    /// permissions related to the given collaboration. When `FALSE`, indicates that
    /// the configured audience model resource owner will manage permissions related
    /// to the given collaboration.
    ///
    /// Setting this to `TRUE` requires you to have permissions to create, update,
    /// and delete the resource policy for the `cleanrooms-ml` resource when you
    /// call the DeleteConfiguredAudienceModelAssociation resource. In addition, if
    /// you are the collaboration creator and specify `TRUE`, you must have the same
    /// permissions when you call the DeleteMember and DeleteCollaboration APIs.
    manage_resource_policies: bool,

    /// A unique identifier for one of your memberships for a collaboration. The
    /// configured audience model is associated to the collaboration that this
    /// membership belongs to. Accepts a membership ID.
    membership_identifier: []const u8,

    /// An optional label that you can assign to a resource when you create it. Each
    /// tag consists of a key and an optional value, both of which you define. When
    /// you use tagging, you can also use tag-based access control in IAM policies
    /// to control access to this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .configured_audience_model_association_name = "configuredAudienceModelAssociationName",
        .description = "description",
        .manage_resource_policies = "manageResourcePolicies",
        .membership_identifier = "membershipIdentifier",
        .tags = "tags",
    };
};

pub const CreateConfiguredAudienceModelAssociationOutput = struct {
    /// Information about the configured audience model association.
    configured_audience_model_association: ?ConfiguredAudienceModelAssociation = null,

    pub const json_field_names = .{
        .configured_audience_model_association = "configuredAudienceModelAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfiguredAudienceModelAssociationInput, options: CallOptions) !CreateConfiguredAudienceModelAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfiguredAudienceModelAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/configuredaudiencemodelassociations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuredAudienceModelArn\":");
    try aws.json.writeValue(@TypeOf(input.configured_audience_model_arn), input.configured_audience_model_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuredAudienceModelAssociationName\":");
    try aws.json.writeValue(@TypeOf(input.configured_audience_model_association_name), input.configured_audience_model_association_name, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"manageResourcePolicies\":");
    try aws.json.writeValue(@TypeOf(input.manage_resource_policies), input.manage_resource_policies, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfiguredAudienceModelAssociationOutput {
    var result: CreateConfiguredAudienceModelAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConfiguredAudienceModelAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

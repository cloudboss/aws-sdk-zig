const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncidentResponder = @import("incident_responder.zig").IncidentResponder;
const MembershipAccountsConfigurationsUpdate = @import("membership_accounts_configurations_update.zig").MembershipAccountsConfigurationsUpdate;
const OptInFeature = @import("opt_in_feature.zig").OptInFeature;

pub const UpdateMembershipInput = struct {
    /// Optional element for UpdateMembership to update the membership name.
    incident_response_team: ?[]const IncidentResponder = null,

    /// The `membershipAccountsConfigurationsUpdate` field in the
    /// `UpdateMembershipRequest` structure allows you to update the configuration
    /// settings for accounts within a membership.
    ///
    /// This field is optional and contains a structure of type
    /// `MembershipAccountsConfigurationsUpdate ` that specifies the updated account
    /// configurations for the membership.
    membership_accounts_configurations_update: ?MembershipAccountsConfigurationsUpdate = null,

    /// Required element for UpdateMembership to identify the membership to update.
    membership_id: []const u8,

    /// Optional element for UpdateMembership to update the membership name.
    membership_name: ?[]const u8 = null,

    /// Optional element for UpdateMembership to enable or disable opt-in features
    /// for the service.
    opt_in_features: ?[]const OptInFeature = null,

    /// The `undoMembershipCancellation` parameter is a boolean flag that indicates
    /// whether to reverse a previously requested membership cancellation. When set
    /// to true, this will revoke the cancellation request and maintain the
    /// membership status.
    ///
    /// This parameter is optional and can be used in scenarios where you need to
    /// restore a membership that was marked for cancellation but hasn't been fully
    /// terminated yet.
    ///
    /// * If set to `true`, the cancellation request will be revoked
    /// * If set to `false` the service will throw a ValidationException.
    undo_membership_cancellation: ?bool = null,

    pub const json_field_names = .{
        .incident_response_team = "incidentResponseTeam",
        .membership_accounts_configurations_update = "membershipAccountsConfigurationsUpdate",
        .membership_id = "membershipId",
        .membership_name = "membershipName",
        .opt_in_features = "optInFeatures",
        .undo_membership_cancellation = "undoMembershipCancellation",
    };
};

pub const UpdateMembershipOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMembershipInput, options: CallOptions) !UpdateMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/membership/");
    try path_buf.appendSlice(allocator, input.membership_id);
    try path_buf.appendSlice(allocator, "/update-membership");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.incident_response_team) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"incidentResponseTeam\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.membership_accounts_configurations_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"membershipAccountsConfigurationsUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.membership_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"membershipName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.opt_in_features) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"optInFeatures\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.undo_membership_cancellation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"undoMembershipCancellation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMembershipOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateMembershipOutput = .{};

    return result;
}

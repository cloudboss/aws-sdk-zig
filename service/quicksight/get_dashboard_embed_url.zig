const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EmbeddingIdentityType = @import("embedding_identity_type.zig").EmbeddingIdentityType;

pub const GetDashboardEmbedUrlInput = struct {
    /// A list of one or more dashboard IDs that you want anonymous users to have
    /// tempporary
    /// access to. Currently, the `IdentityType` parameter must be set to
    /// `ANONYMOUS` because other identity types authenticate as Quick or IAM users.
    /// For example, if you set "`--dashboard-id
    /// dash_id1 --dashboard-id dash_id2 dash_id3 identity-type ANONYMOUS`", the
    /// session can access all three dashboards.
    additional_dashboard_ids: ?[]const []const u8 = null,

    /// The ID for the Amazon Web Services account that contains the dashboard that
    /// you're
    /// embedding.
    aws_account_id: []const u8,

    /// The ID for the dashboard, also added to the Identity and Access Management
    /// (IAM) policy.
    dashboard_id: []const u8,

    /// The authentication method that the user uses to sign in.
    identity_type: EmbeddingIdentityType,

    /// The Amazon Quick Sight namespace that contains the dashboard IDs in this
    /// request. If
    /// you're not using a custom namespace, set `Namespace = default`.
    namespace: ?[]const u8 = null,

    /// Remove the reset button on the embedded dashboard. The default is FALSE,
    /// which enables
    /// the reset button.
    reset_disabled: ?bool = null,

    /// How many minutes the session is valid. The session lifetime must be 15-600
    /// minutes.
    session_lifetime_in_minutes: ?i64 = null,

    /// Adds persistence of state for the user session in an embedded dashboard.
    /// Persistence
    /// applies to the sheet and the parameter settings. These are control settings
    /// that the
    /// dashboard subscriber (Amazon Quick Sight reader) chooses while viewing the
    /// dashboard. If
    /// this is set to `TRUE`, the settings are the same when the subscriber reopens
    /// the same dashboard URL. The state is stored in Amazon Quick Sight, not in a
    /// browser
    /// cookie. If this is set to FALSE, the state of the user session is not
    /// persisted. The
    /// default is `FALSE`.
    state_persistence_enabled: ?bool = null,

    /// Remove the undo/redo button on the embedded dashboard. The default is FALSE,
    /// which
    /// enables the undo/redo button.
    undo_redo_disabled: ?bool = null,

    /// The Amazon Quick user's Amazon Resource Name (ARN), for use with
    /// `QUICKSIGHT` identity type. You can use this for any Amazon Quick users in
    /// your account (readers, authors, or admins) authenticated as one of the
    /// following:
    ///
    /// * Active Directory (AD) users or group members
    ///
    /// * Invited nonfederated users
    ///
    /// * IAM users and IAM role-based sessions
    /// authenticated through Federated Single Sign-On using SAML, OpenID Connect,
    /// or
    /// IAM federation.
    ///
    /// Omit this parameter for users in the third group – IAM users and IAM
    /// role-based sessions.
    user_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_dashboard_ids = "AdditionalDashboardIds",
        .aws_account_id = "AwsAccountId",
        .dashboard_id = "DashboardId",
        .identity_type = "IdentityType",
        .namespace = "Namespace",
        .reset_disabled = "ResetDisabled",
        .session_lifetime_in_minutes = "SessionLifetimeInMinutes",
        .state_persistence_enabled = "StatePersistenceEnabled",
        .undo_redo_disabled = "UndoRedoDisabled",
        .user_arn = "UserArn",
    };
};

pub const GetDashboardEmbedUrlOutput = struct {
    /// A single-use URL that you can put into your server-side webpage to embed
    /// your
    /// dashboard. This URL is valid for 5 minutes. The API operation provides the
    /// URL with an
    /// `auth_code` value that enables one (and only one) sign-on to a user
    /// session that is valid for 10 hours.
    embed_url: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .embed_url = "EmbedUrl",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDashboardEmbedUrlInput, options: CallOptions) !GetDashboardEmbedUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDashboardEmbedUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/dashboards/");
    try path_buf.appendSlice(allocator, input.dashboard_id);
    try path_buf.appendSlice(allocator, "/embed-url");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.additional_dashboard_ids) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "additional-dashboard-ids=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "creds-type=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.identity_type.wireName());
    query_has_prev = true;
    if (input.namespace) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "namespace=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.reset_disabled) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "reset-disabled=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.session_lifetime_in_minutes) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "session-lifetime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.state_persistence_enabled) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "state-persistence-enabled=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.undo_redo_disabled) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "undo-redo-disabled=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.user_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "user-arn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDashboardEmbedUrlOutput {
    var result: GetDashboardEmbedUrlOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDashboardEmbedUrlOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}

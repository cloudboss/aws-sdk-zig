const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetSessionEmbedUrlInput = struct {
    /// The ID for the Amazon Web Services account associated with your Amazon Quick
    /// Sight
    /// subscription.
    aws_account_id: []const u8,

    /// The URL you use to access the embedded session. The entry point URL is
    /// constrained to
    /// the following paths:
    ///
    /// * `/start`
    ///
    /// * `/start/analyses`
    ///
    /// * `/start/dashboards`
    ///
    /// * `/start/favorites`
    ///
    /// * `/dashboards/*DashboardId*
    /// ` - where
    /// `DashboardId` is the actual ID key from the Amazon Quick Sight
    /// console URL of the dashboard
    ///
    /// * `/analyses/*AnalysisId*
    /// ` - where
    /// `AnalysisId` is the actual ID key from the Amazon Quick Sight
    /// console URL of the analysis
    entry_point: ?[]const u8 = null,

    /// How many minutes the session is valid. The session lifetime must be 15-600
    /// minutes.
    session_lifetime_in_minutes: ?i64 = null,

    /// The Amazon Quick user's Amazon Resource Name (ARN), for use with
    /// `QUICKSIGHT` identity type. You can use this for any type of Amazon Quick
    /// users in your account (readers, authors, or admins). They need to be
    /// authenticated as one of the following:
    ///
    /// * Active Directory (AD) users or group members
    ///
    /// * Invited nonfederated users
    ///
    /// * IAM users and IAM role-based sessions
    /// authenticated through Federated Single Sign-On using SAML, OpenID Connect,
    /// or
    /// IAM federation
    ///
    /// Omit this parameter for users in the third group, IAM users and IAM
    /// role-based sessions.
    user_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .entry_point = "EntryPoint",
        .session_lifetime_in_minutes = "SessionLifetimeInMinutes",
        .user_arn = "UserArn",
    };
};

pub const GetSessionEmbedUrlOutput = struct {
    /// A single-use URL that you can put into your server-side web page to embed
    /// your Quick session. This URL is valid for 5 minutes. The API operation
    /// provides the
    /// URL with an `auth_code` value that enables one (and only one) sign-on to a
    /// user session that is valid for 10 hours.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionEmbedUrlInput, options: CallOptions) !GetSessionEmbedUrlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionEmbedUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/session-embed-url");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.entry_point) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "entry-point=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionEmbedUrlOutput {
    var result: GetSessionEmbedUrlOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSessionEmbedUrlOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Theme = @import("theme.zig").Theme;

pub const DescribeThemeInput = struct {
    /// The alias of the theme that you want to describe. If you name a specific
    /// alias, you
    /// describe the version that the alias points to. You can specify the latest
    /// version of the
    /// theme by providing the keyword `$LATEST` in the `AliasName`
    /// parameter. The keyword `$PUBLISHED` doesn't apply to themes.
    alias_name: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that contains the theme that
    /// you're describing.
    aws_account_id: []const u8,

    /// The ID for the theme.
    theme_id: []const u8,

    /// The version number for the version to describe. If a `VersionNumber`
    /// parameter
    /// value isn't provided, the latest version of the theme is described.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .aws_account_id = "AwsAccountId",
        .theme_id = "ThemeId",
        .version_number = "VersionNumber",
    };
};

pub const DescribeThemeOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The information about the theme that you are describing.
    theme: ?Theme = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .status = "Status",
        .theme = "Theme",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeThemeInput, options: CallOptions) !DescribeThemeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeThemeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/themes/");
    try path_buf.appendSlice(allocator, input.theme_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.alias_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "alias-name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.version_number) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version-number=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeThemeOutput {
    var result: DescribeThemeOutput = try aws.json.parseJsonObject(
        DescribeThemeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}

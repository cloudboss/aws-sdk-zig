const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteThemeInput = struct {
    /// The ID of the Amazon Web Services account that contains the theme that
    /// you're deleting.
    aws_account_id: []const u8,

    /// An ID for the theme that you want to delete.
    theme_id: []const u8,

    /// The version of the theme that you want to delete.
    ///
    /// **Note:** If you don't provide a version number, you're
    /// using this call to `DeleteTheme` to delete all versions of the theme.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .theme_id = "ThemeId",
        .version_number = "VersionNumber",
    };
};

pub const DeleteThemeOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// An ID for the theme.
    theme_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .request_id = "RequestId",
        .status = "Status",
        .theme_id = "ThemeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteThemeInput, options: CallOptions) !DeleteThemeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteThemeInput, config: *aws.Config) !aws.http.Request {
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
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteThemeOutput {
    var result: DeleteThemeOutput = try aws.json.parseJsonObject(
        DeleteThemeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppInstanceAdminSummary = @import("app_instance_admin_summary.zig").AppInstanceAdminSummary;

pub const ListAppInstanceAdminsInput = struct {
    /// The ARN of the `AppInstance`.
    app_instance_arn: []const u8,

    /// The maximum number of administrators that you want to return.
    max_results: ?i32 = null,

    /// The token returned from previous API requests until the number of
    /// administrators is
    /// reached.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_arn = "AppInstanceArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListAppInstanceAdminsOutput = struct {
    /// The information for each administrator.
    app_instance_admins: ?[]const AppInstanceAdminSummary = null,

    /// The ARN of the `AppInstance`.
    app_instance_arn: ?[]const u8 = null,

    /// The token returned from previous API requests until the number of
    /// administrators is
    /// reached.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_admins = "AppInstanceAdmins",
        .app_instance_arn = "AppInstanceArn",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAppInstanceAdminsInput, options: CallOptions) !ListAppInstanceAdminsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAppInstanceAdminsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("identity-chime", "Chime SDK Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/app-instances/");
    try path_buf.appendSlice(allocator, input.app_instance_arn);
    try path_buf.appendSlice(allocator, "/admins");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAppInstanceAdminsOutput {
    const result: ListAppInstanceAdminsOutput = try aws.json.parseJsonObject(
        ListAppInstanceAdminsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

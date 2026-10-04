const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AllowListCriteria = @import("allow_list_criteria.zig").AllowListCriteria;
const AllowListStatus = @import("allow_list_status.zig").AllowListStatus;

pub const GetAllowListInput = struct {
    /// The unique identifier for the Amazon Macie resource that the request applies
    /// to.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetAllowListOutput = struct {
    /// The Amazon Resource Name (ARN) of the allow list.
    arn: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the allow list
    /// was created in Amazon Macie.
    created_at: ?i64 = null,

    /// The criteria that specify the text or text pattern to ignore. The criteria
    /// can be the location and name of an S3 object that lists specific text to
    /// ignore (s3WordsList), or a regular expression (regex) that defines a text
    /// pattern to ignore.
    criteria: ?AllowListCriteria = null,

    /// The custom description of the allow list.
    description: ?[]const u8 = null,

    /// The unique identifier for the allow list.
    id: ?[]const u8 = null,

    /// The custom name of the allow list.
    name: ?[]const u8 = null,

    /// The current status of the allow list, which indicates whether Amazon Macie
    /// can access and use the list's criteria.
    status: ?AllowListStatus = null,

    /// A map of key-value pairs that specifies which tags (keys and values) are
    /// associated with the allow list.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the allow
    /// list's settings were most recently changed in Amazon Macie.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .criteria = "criteria",
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAllowListInput, options: CallOptions) !GetAllowListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAllowListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/allow-lists/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAllowListOutput {
    const result: GetAllowListOutput = try aws.json.parseJsonObject(
        GetAllowListOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateBrandPublishedVersionInput = struct {
    /// The ID of the Amazon Web Services account that owns the brand.
    aws_account_id: []const u8,

    /// The ID of the Quick brand.
    brand_id: []const u8,

    /// The ID of the published version.
    version_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .brand_id = "BrandId",
        .version_id = "VersionId",
    };
};

pub const UpdateBrandPublishedVersionOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The ID of the published version.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .version_id = "VersionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBrandPublishedVersionInput, options: CallOptions) !UpdateBrandPublishedVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBrandPublishedVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/brands/");
    try path_buf.appendSlice(allocator, input.brand_id);
    try path_buf.appendSlice(allocator, "/publishedversion");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VersionId\":");
    try aws.json.writeValue(@TypeOf(input.version_id), input.version_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBrandPublishedVersionOutput {
    const result: UpdateBrandPublishedVersionOutput = try aws.json.parseJsonObject(
        UpdateBrandPublishedVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3ClassificationScope = @import("s3_classification_scope.zig").S3ClassificationScope;

pub const GetClassificationScopeInput = struct {
    /// The unique identifier for the Amazon Macie resource that the request applies
    /// to.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetClassificationScopeOutput = struct {
    /// The unique identifier for the classification scope.
    id: ?[]const u8 = null,

    /// The name of the classification scope: automated-sensitive-data-discovery.
    name: ?[]const u8 = null,

    /// The S3 buckets that are excluded from automated sensitive data discovery.
    s_3: ?S3ClassificationScope = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .s_3 = "s3",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetClassificationScopeInput, options: CallOptions) !GetClassificationScopeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetClassificationScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/classification-scopes/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetClassificationScopeOutput {
    var result: GetClassificationScopeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetClassificationScopeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

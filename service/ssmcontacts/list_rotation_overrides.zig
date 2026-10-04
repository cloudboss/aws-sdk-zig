const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RotationOverride = @import("rotation_override.zig").RotationOverride;

pub const ListRotationOverridesInput = struct {
    /// The date and time for the end of a time range for listing overrides.
    end_time: i64,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that
    /// you can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// A token to start the list. Use this token to get the next set of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the rotation to retrieve information
    /// about.
    rotation_id: []const u8,

    /// The date and time for the beginning of a time range for listing overrides.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .rotation_id = "RotationId",
        .start_time = "StartTime",
    };
};

pub const ListRotationOverridesOutput = struct {
    /// The token for the next set of items to return. Use this token to get the
    /// next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of rotation overrides in the specified time range.
    rotation_overrides: ?[]const RotationOverride = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rotation_overrides = "RotationOverrides",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRotationOverridesInput, options: CallOptions) !ListRotationOverridesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-contacts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRotationOverridesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-contacts", "SSM Contacts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.ListRotationOverrides");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRotationOverridesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRotationOverridesOutput, body, allocator);
}

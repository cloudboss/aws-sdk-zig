const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SessionSharingConfiguration = @import("session_sharing_configuration.zig").SessionSharingConfiguration;

pub const GetQAppSessionMetadataInput = struct {
    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// The unique identifier of the Q App session.
    session_id: []const u8,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .session_id = "sessionId",
    };
};

pub const GetQAppSessionMetadataOutput = struct {
    /// The Amazon Resource Name (ARN) of the Q App session.
    session_arn: []const u8,

    /// The unique identifier of the Q App session.
    session_id: []const u8,

    /// The name of the Q App session.
    session_name: ?[]const u8 = null,

    /// Indicates whether the current user is the owner of the Q App session.
    session_owner: ?bool = null,

    /// The sharing configuration of the Q App data collection session.
    sharing_configuration: ?SessionSharingConfiguration = null,

    pub const json_field_names = .{
        .session_arn = "sessionArn",
        .session_id = "sessionId",
        .session_name = "sessionName",
        .session_owner = "sessionOwner",
        .sharing_configuration = "sharingConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQAppSessionMetadataInput, options: CallOptions) !GetQAppSessionMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qapps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQAppSessionMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/runtime.getQAppSessionMetadata";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "sessionId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.session_id);
    query_has_prev = true;
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
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQAppSessionMetadataOutput {
    var result: GetQAppSessionMetadataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetQAppSessionMetadataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

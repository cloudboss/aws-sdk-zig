const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityType = @import("identity_type.zig").IdentityType;
const SessionMappingSummary = @import("session_mapping_summary.zig").SessionMappingSummary;

pub const ListStudioSessionMappingsInput = struct {
    /// Specifies whether to return session mappings for users or groups. If not
    /// specified, the
    /// results include session mapping details for both users and groups.
    identity_type: ?IdentityType = null,

    /// The pagination token that indicates the set of results to retrieve.
    marker: ?[]const u8 = null,

    /// The ID of the Amazon EMR Studio.
    studio_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .identity_type = "IdentityType",
        .marker = "Marker",
        .studio_id = "StudioId",
    };
};

pub const ListStudioSessionMappingsOutput = struct {
    /// The pagination token that indicates the next set of results to retrieve.
    marker: ?[]const u8 = null,

    /// A list of session mapping summary objects. Each object includes session
    /// mapping details
    /// such as creation time, identity type (user or group), and Amazon EMR Studio
    /// ID.
    session_mappings: ?[]const SessionMappingSummary = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .session_mappings = "SessionMappings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStudioSessionMappingsInput, options: CallOptions) !ListStudioSessionMappingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStudioSessionMappingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.ListStudioSessionMappings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStudioSessionMappingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListStudioSessionMappingsOutput, body, allocator);
}

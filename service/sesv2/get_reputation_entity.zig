const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReputationEntityType = @import("reputation_entity_type.zig").ReputationEntityType;
const ReputationEntity = @import("reputation_entity.zig").ReputationEntity;

pub const GetReputationEntityInput = struct {
    /// The unique identifier for the reputation entity. For resource-type entities,
    /// this is the Amazon Resource Name (ARN) of the resource.
    reputation_entity_reference: []const u8,

    /// The type of reputation entity. Currently, only `RESOURCE` type entities are
    /// supported.
    reputation_entity_type: ReputationEntityType,

    pub const json_field_names = .{
        .reputation_entity_reference = "ReputationEntityReference",
        .reputation_entity_type = "ReputationEntityType",
    };
};

pub const GetReputationEntityOutput = struct {
    /// The reputation entity information, including status records, policy
    /// configuration,
    /// and reputation impact.
    reputation_entity: ?ReputationEntity = null,

    pub const json_field_names = .{
        .reputation_entity = "ReputationEntity",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReputationEntityInput, options: CallOptions) !GetReputationEntityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReputationEntityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/reputation/entities/");
    try path_buf.appendSlice(allocator, input.reputation_entity_type);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.reputation_entity_reference);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReputationEntityOutput {
    const result: GetReputationEntityOutput = try aws.json.parseJsonObject(
        GetReputationEntityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

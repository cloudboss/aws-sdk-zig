const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReputationEntityType = @import("reputation_entity_type.zig").ReputationEntityType;

pub const UpdateReputationEntityPolicyInput = struct {
    /// The Amazon Resource Name (ARN) of the reputation management policy to apply
    /// to this entity. This is an Amazon Web Services Amazon SES-managed policy.
    reputation_entity_policy: []const u8,

    /// The unique identifier for the reputation entity. For resource-type entities,
    /// this is the Amazon Resource Name (ARN) of the resource.
    reputation_entity_reference: []const u8,

    /// The type of reputation entity. Currently, only `RESOURCE` type entities are
    /// supported.
    reputation_entity_type: ReputationEntityType,

    pub const json_field_names = .{
        .reputation_entity_policy = "ReputationEntityPolicy",
        .reputation_entity_reference = "ReputationEntityReference",
        .reputation_entity_type = "ReputationEntityType",
    };
};

pub const UpdateReputationEntityPolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateReputationEntityPolicyInput, options: CallOptions) !UpdateReputationEntityPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateReputationEntityPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/reputation/entities/");
    try path_buf.appendSlice(allocator, input.reputation_entity_type);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.reputation_entity_reference);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReputationEntityPolicy\":");
    try aws.json.writeValue(@TypeOf(input.reputation_entity_policy), input.reputation_entity_policy, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateReputationEntityPolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateReputationEntityPolicyOutput = .{};

    return result;
}

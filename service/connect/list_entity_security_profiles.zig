const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityType = @import("entity_type.zig").EntityType;
const SecurityProfileItem = @import("security_profile_item.zig").SecurityProfileItem;

pub const ListEntitySecurityProfilesInput = struct {
    /// ARN of a Q in Connect AI Agent.
    entity_arn: []const u8,

    /// Only supported type is AI_AGENT.
    entity_type: EntityType,

    /// The identifier of the Amazon Connect instance. You can find the instance ID
    /// in the Amazon Resource Name (ARN)
    /// of the instance.
    instance_id: []const u8,

    /// The maximum number of results to return per page. The default MaxResult size
    /// is 100.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to
    /// retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity_arn = "EntityArn",
        .entity_type = "EntityType",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListEntitySecurityProfilesOutput = struct {
    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to
    /// retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// List of Security Profile Object.
    security_profiles: ?[]const SecurityProfileItem = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .security_profiles = "SecurityProfiles",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEntitySecurityProfilesInput, options: CallOptions) !ListEntitySecurityProfilesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEntitySecurityProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/entity-security-profiles-summary/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EntityArn\":");
    try aws.json.writeValue(@TypeOf(input.entity_arn), input.entity_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EntityType\":");
    try aws.json.writeValue(@TypeOf(input.entity_type), input.entity_type, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEntitySecurityProfilesOutput {
    var result: ListEntitySecurityProfilesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListEntitySecurityProfilesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

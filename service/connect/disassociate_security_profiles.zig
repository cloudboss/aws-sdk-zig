const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityType = @import("entity_type.zig").EntityType;
const SecurityProfileItem = @import("security_profile_item.zig").SecurityProfileItem;

pub const DisassociateSecurityProfilesInput = struct {
    /// ARN of a Q in Connect AI Agent.
    entity_arn: []const u8,

    /// Only supported type is AI_AGENT.
    entity_type: EntityType,

    /// The identifier of the Amazon Connect instance. You can find the instance ID
    /// in the Amazon Resource Name (ARN)
    /// of the instance.
    instance_id: []const u8,

    /// List of Security Profile Object.
    security_profiles: []const SecurityProfileItem,

    pub const json_field_names = .{
        .entity_arn = "EntityArn",
        .entity_type = "EntityType",
        .instance_id = "InstanceId",
        .security_profiles = "SecurityProfiles",
    };
};

pub const DisassociateSecurityProfilesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateSecurityProfilesInput, options: CallOptions) !DisassociateSecurityProfilesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateSecurityProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/disassociate-security-profiles/");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecurityProfiles\":");
    try aws.json.writeValue(@TypeOf(input.security_profiles), input.security_profiles, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateSecurityProfilesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DisassociateSecurityProfilesOutput = .{};

    return result;
}

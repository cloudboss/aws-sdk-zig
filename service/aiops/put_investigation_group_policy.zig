const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutInvestigationGroupPolicyInput = struct {
    /// Specify either the name or the ARN of the investigation group that you want
    /// to assign the policy to.
    identifier: []const u8,

    /// The policy, in JSON format.
    policy: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
        .policy = "policy",
    };
};

pub const PutInvestigationGroupPolicyOutput = struct {
    /// The ARN of the investigation group that will use this policy.
    investigation_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .investigation_group_arn = "investigationGroupArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutInvestigationGroupPolicyInput, options: CallOptions) !PutInvestigationGroupPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aiops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutInvestigationGroupPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aiops", "AIOps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/investigationGroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policy\":");
    try aws.json.writeValue(@TypeOf(input.policy), input.policy, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutInvestigationGroupPolicyOutput {
    const result: PutInvestigationGroupPolicyOutput = try aws.json.parseJsonObject(
        PutInvestigationGroupPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SipRuleTargetApplication = @import("sip_rule_target_application.zig").SipRuleTargetApplication;
const SipRule = @import("sip_rule.zig").SipRule;

pub const UpdateSipRuleInput = struct {
    /// The new value that indicates whether the rule is disabled.
    disabled: ?bool = null,

    /// The new name for the specified SIP rule.
    name: []const u8,

    /// The SIP rule ID.
    sip_rule_id: []const u8,

    /// The new list of target applications.
    target_applications: ?[]const SipRuleTargetApplication = null,

    pub const json_field_names = .{
        .disabled = "Disabled",
        .name = "Name",
        .sip_rule_id = "SipRuleId",
        .target_applications = "TargetApplications",
    };
};

pub const UpdateSipRuleOutput = struct {
    /// The updated SIP rule details.
    sip_rule: ?SipRule = null,

    pub const json_field_names = .{
        .sip_rule = "SipRule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSipRuleInput, options: CallOptions) !UpdateSipRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSipRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sip-rules/");
    try path_buf.appendSlice(allocator, input.sip_rule_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.disabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Disabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.target_applications) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetApplications\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSipRuleOutput {
    var result: UpdateSipRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSipRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

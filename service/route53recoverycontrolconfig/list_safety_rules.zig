const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Rule = @import("rule.zig").Rule;

pub const ListSafetyRulesInput = struct {
    /// The Amazon Resource Name (ARN) of the control panel.
    control_panel_arn: []const u8,

    /// The number of objects that you want to return with this call.
    max_results: ?i32 = null,

    /// The token that identifies which batch of results you want to see.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .control_panel_arn = "ControlPanelArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListSafetyRulesOutput = struct {
    /// The token that identifies which batch of results you want to see.
    next_token: ?[]const u8 = null,

    /// The list of safety rules in a control panel.
    safety_rules: ?[]const Rule = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .safety_rules = "SafetyRules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSafetyRulesInput, options: CallOptions) !ListSafetyRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-control-config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSafetyRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-control-config", "Route53 Recovery Control Config", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/controlpanel/");
    try path_buf.appendSlice(allocator, input.control_panel_arn);
    try path_buf.appendSlice(allocator, "/safetyrules");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSafetyRulesOutput {
    var result: ListSafetyRulesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSafetyRulesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

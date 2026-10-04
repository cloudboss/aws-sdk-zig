const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleUpdate = @import("rule_update.zig").RuleUpdate;
const RuleUpdateSuccess = @import("rule_update_success.zig").RuleUpdateSuccess;
const RuleUpdateFailure = @import("rule_update_failure.zig").RuleUpdateFailure;

pub const BatchUpdateRuleInput = struct {
    /// The ID or ARN of the listener.
    listener_identifier: []const u8,

    /// The rules for the specified listener.
    rules: []const RuleUpdate,

    /// The ID or ARN of the service.
    service_identifier: []const u8,

    pub const json_field_names = .{
        .listener_identifier = "listenerIdentifier",
        .rules = "rules",
        .service_identifier = "serviceIdentifier",
    };
};

pub const BatchUpdateRuleOutput = struct {
    /// The rules that were successfully updated.
    successful: ?[]const RuleUpdateSuccess = null,

    /// The rules that the operation couldn't update.
    unsuccessful: ?[]const RuleUpdateFailure = null,

    pub const json_field_names = .{
        .successful = "successful",
        .unsuccessful = "unsuccessful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateRuleInput, options: CallOptions) !BatchUpdateRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/services/");
    try path_buf.appendSlice(allocator, input.service_identifier);
    try path_buf.appendSlice(allocator, "/listeners/");
    try path_buf.appendSlice(allocator, input.listener_identifier);
    try path_buf.appendSlice(allocator, "/rules");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"rules\":");
    try aws.json.writeValue(@TypeOf(input.rules), input.rules, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateRuleOutput {
    const result: BatchUpdateRuleOutput = try aws.json.parseJsonObject(
        BatchUpdateRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

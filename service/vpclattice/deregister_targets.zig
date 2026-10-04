const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Target = @import("target.zig").Target;
const TargetFailure = @import("target_failure.zig").TargetFailure;

pub const DeregisterTargetsInput = struct {
    /// The ID or ARN of the target group.
    target_group_identifier: []const u8,

    /// The targets to deregister.
    targets: []const Target,

    pub const json_field_names = .{
        .target_group_identifier = "targetGroupIdentifier",
        .targets = "targets",
    };
};

pub const DeregisterTargetsOutput = struct {
    /// The targets that were successfully deregistered.
    successful: ?[]const Target = null,

    /// The targets that the operation couldn't deregister.
    unsuccessful: ?[]const TargetFailure = null,

    pub const json_field_names = .{
        .successful = "successful",
        .unsuccessful = "unsuccessful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterTargetsInput, options: CallOptions) !DeregisterTargetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterTargetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/targetgroups/");
    try path_buf.appendSlice(allocator, input.target_group_identifier);
    try path_buf.appendSlice(allocator, "/deregistertargets");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targets\":");
    try aws.json.writeValue(@TypeOf(input.targets), input.targets, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterTargetsOutput {
    const result: DeregisterTargetsOutput = try aws.json.parseJsonObject(
        DeregisterTargetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

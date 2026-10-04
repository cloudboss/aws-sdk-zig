const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Behavior = @import("behavior.zig").Behavior;
const ValidationError = @import("validation_error.zig").ValidationError;

pub const ValidateSecurityProfileBehaviorsInput = struct {
    /// Specifies the behaviors that, when violated by a device (thing), cause an
    /// alert.
    behaviors: []const Behavior,

    pub const json_field_names = .{
        .behaviors = "behaviors",
    };
};

pub const ValidateSecurityProfileBehaviorsOutput = struct {
    /// True if the behaviors were valid.
    valid: ?bool = null,

    /// The list of any errors found in the behaviors.
    validation_errors: ?[]const ValidationError = null,

    pub const json_field_names = .{
        .valid = "valid",
        .validation_errors = "validationErrors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateSecurityProfileBehaviorsInput, options: CallOptions) !ValidateSecurityProfileBehaviorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidateSecurityProfileBehaviorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/security-profile-behaviors/validate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"behaviors\":");
    try aws.json.writeValue(@TypeOf(input.behaviors), input.behaviors, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidateSecurityProfileBehaviorsOutput {
    const result: ValidateSecurityProfileBehaviorsOutput = try aws.json.parseJsonObject(
        ValidateSecurityProfileBehaviorsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

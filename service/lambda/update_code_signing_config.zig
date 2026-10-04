const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AllowedPublishers = @import("allowed_publishers.zig").AllowedPublishers;
const CodeSigningPolicies = @import("code_signing_policies.zig").CodeSigningPolicies;
const CodeSigningConfig = @import("code_signing_config.zig").CodeSigningConfig;

pub const UpdateCodeSigningConfigInput = struct {
    /// Signing profiles for this code signing configuration.
    allowed_publishers: ?AllowedPublishers = null,

    /// The The Amazon Resource Name (ARN) of the code signing configuration.
    code_signing_config_arn: []const u8,

    /// The code signing policy.
    code_signing_policies: ?CodeSigningPolicies = null,

    /// Descriptive name for this code signing configuration.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_publishers = "AllowedPublishers",
        .code_signing_config_arn = "CodeSigningConfigArn",
        .code_signing_policies = "CodeSigningPolicies",
        .description = "Description",
    };
};

pub const UpdateCodeSigningConfigOutput = struct {
    /// The code signing configuration
    code_signing_config: ?CodeSigningConfig = null,

    pub const json_field_names = .{
        .code_signing_config = "CodeSigningConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCodeSigningConfigInput, options: CallOptions) !UpdateCodeSigningConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCodeSigningConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-04-22/code-signing-configs/");
    try path_buf.appendSlice(allocator, input.code_signing_config_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_publishers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllowedPublishers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.code_signing_policies) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CodeSigningPolicies\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCodeSigningConfigOutput {
    var result: UpdateCodeSigningConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateCodeSigningConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

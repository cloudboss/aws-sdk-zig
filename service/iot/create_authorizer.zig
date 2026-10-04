const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizerStatus = @import("authorizer_status.zig").AuthorizerStatus;
const Tag = @import("tag.zig").Tag;

pub const CreateAuthorizerInput = struct {
    /// The ARN of the authorizer's Lambda function.
    authorizer_function_arn: []const u8,

    /// The authorizer name.
    authorizer_name: []const u8,

    /// When `true`, the result from the authorizer’s Lambda function is
    /// cached for clients that use persistent HTTP connections. The results are
    /// cached for the time
    /// specified by the Lambda function in `refreshAfterInSeconds`. This value
    /// does not affect authorization of clients that use MQTT connections.
    ///
    /// The default value is `false`.
    enable_caching_for_http: ?bool = null,

    /// Specifies whether IoT validates the token signature in an authorization
    /// request.
    signing_disabled: ?bool = null,

    /// The status of the create authorizer request.
    status: ?AuthorizerStatus = null,

    /// Metadata which can be used to manage the custom authorizer.
    ///
    /// For URI Request parameters use format: ...key1=value1&key2=value2...
    ///
    /// For the CLI command-line parameter use format: &&tags
    /// "key1=value1&key2=value2..."
    ///
    /// For the cli-input-json file use format: "tags":
    /// "key1=value1&key2=value2..."
    tags: ?[]const Tag = null,

    /// The name of the token key used to extract the token from the HTTP headers.
    token_key_name: ?[]const u8 = null,

    /// The public keys used to verify the digital signature returned by your custom
    /// authentication service.
    token_signing_public_keys: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authorizer_function_arn = "authorizerFunctionArn",
        .authorizer_name = "authorizerName",
        .enable_caching_for_http = "enableCachingForHttp",
        .signing_disabled = "signingDisabled",
        .status = "status",
        .tags = "tags",
        .token_key_name = "tokenKeyName",
        .token_signing_public_keys = "tokenSigningPublicKeys",
    };
};

pub const CreateAuthorizerOutput = struct {
    /// The authorizer ARN.
    authorizer_arn: ?[]const u8 = null,

    /// The authorizer's name.
    authorizer_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorizer_arn = "authorizerArn",
        .authorizer_name = "authorizerName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAuthorizerInput, options: CallOptions) !CreateAuthorizerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAuthorizerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/authorizer/");
    try path_buf.appendSlice(allocator, input.authorizer_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authorizerFunctionArn\":");
    try aws.json.writeValue(@TypeOf(input.authorizer_function_arn), input.authorizer_function_arn, allocator, &body_buf);
    has_prev = true;
    if (input.enable_caching_for_http) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableCachingForHttp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.signing_disabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"signingDisabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.token_key_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tokenKeyName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.token_signing_public_keys) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tokenSigningPublicKeys\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAuthorizerOutput {
    var result: CreateAuthorizerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAuthorizerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

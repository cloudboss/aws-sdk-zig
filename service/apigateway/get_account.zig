const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThrottleSettings = @import("throttle_settings.zig").ThrottleSettings;

pub const GetAccountInput = struct {};

pub const GetAccountOutput = struct {
    /// The version of the API keys used for the account.
    api_key_version: ?[]const u8 = null,

    /// The ARN of an Amazon CloudWatch role for the current Account.
    cloudwatch_role_arn: ?[]const u8 = null,

    /// A list of features supported for the account. When usage plans are enabled,
    /// the features list will include an entry of `"UsagePlans"`.
    features: ?[]const []const u8 = null,

    /// Specifies the API request limits configured for the current Account.
    throttle_settings: ?ThrottleSettings = null,

    pub const json_field_names = .{
        .api_key_version = "apiKeyVersion",
        .cloudwatch_role_arn = "cloudwatchRoleArn",
        .features = "features",
        .throttle_settings = "throttleSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountInput, options: CallOptions) !GetAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/account";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountOutput {
    const result: GetAccountOutput = try aws.json.parseJsonObject(
        GetAccountOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

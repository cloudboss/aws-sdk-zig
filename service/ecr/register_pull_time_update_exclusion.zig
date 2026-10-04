const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RegisterPullTimeUpdateExclusionInput = struct {
    /// The ARN of the IAM principal to exclude from having image pull times
    /// recorded.
    principal_arn: []const u8,

    pub const json_field_names = .{
        .principal_arn = "principalArn",
    };
};

pub const RegisterPullTimeUpdateExclusionOutput = struct {
    /// The date and time, expressed in standard JavaScript date format, when the
    /// exclusion was created.
    created_at: ?i64 = null,

    /// The ARN of the IAM principal that was added to the pull time update
    /// exclusion list.
    principal_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .principal_arn = "principalArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterPullTimeUpdateExclusionInput, options: CallOptions) !RegisterPullTimeUpdateExclusionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterPullTimeUpdateExclusionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.RegisterPullTimeUpdateExclusion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterPullTimeUpdateExclusionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterPullTimeUpdateExclusionOutput, body, allocator);
}

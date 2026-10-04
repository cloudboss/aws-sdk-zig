const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetStackPolicyInput = struct {
    /// The name or unique stack ID that you want to associate a policy with.
    stack_name: []const u8,

    /// Structure that contains the stack policy body. For more information, see
    /// [Prevent updates to stack
    /// resources](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/protect-stack-resources.html) in the *CloudFormation User Guide*.
    /// You can specify either the `StackPolicyBody` or the `StackPolicyURL`
    /// parameter, but not both.
    stack_policy_body: ?[]const u8 = null,

    /// Location of a file that contains the stack policy. The URL must point to a
    /// policy (maximum
    /// size: 16 KB) located in an Amazon S3 bucket in the same Amazon Web Services
    /// Region as the stack. The location for
    /// an Amazon S3 bucket must start with `https://`. URLs from S3 static websites
    /// are not
    /// supported.
    ///
    /// You can specify either the `StackPolicyBody` or the `StackPolicyURL`
    /// parameter, but not both.
    stack_policy_url: ?[]const u8 = null,
};

pub const SetStackPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetStackPolicyInput, options: CallOptions) !SetStackPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetStackPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetStackPolicy&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&StackName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_name);
    if (input.stack_policy_body) |v| {
        try body_buf.appendSlice(allocator, "&StackPolicyBody=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.stack_policy_url) |v| {
        try body_buf.appendSlice(allocator, "&StackPolicyURL=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetStackPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetStackPolicyOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeletePolicyVersionInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM policy from which you want to
    /// delete a
    /// version.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    policy_arn: []const u8,

    /// The policy version to delete.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters that
    /// consists of the lowercase letter 'v' followed by one or two digits, and
    /// optionally
    /// followed by a period '.' and a string of letters and digits.
    ///
    /// For more information about managed policy versions, see [Versioning for
    /// managed
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-versions.html) in the *IAM User Guide*.
    version_id: []const u8,
};

pub const DeletePolicyVersionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePolicyVersionInput, options: CallOptions) !DeletePolicyVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePolicyVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeletePolicyVersion&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&PolicyArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_arn);
    try body_buf.appendSlice(allocator, "&VersionId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.version_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePolicyVersionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: DeletePolicyVersionOutput = .{};

    return result;
}

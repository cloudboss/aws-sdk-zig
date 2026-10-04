const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceSignalStatus = @import("resource_signal_status.zig").ResourceSignalStatus;

pub const SignalResourceInput = struct {
    /// The logical ID of the resource that you want to signal. The logical ID is
    /// the name of the
    /// resource that given in the template.
    logical_resource_id: []const u8,

    /// The stack name or unique stack ID that includes the resource that you want
    /// to
    /// signal.
    stack_name: []const u8,

    /// The status of the signal, which is either success or failure. A failure
    /// signal causes
    /// CloudFormation to immediately fail the stack creation or update.
    status: ResourceSignalStatus,

    /// A unique ID of the signal. When you signal Amazon EC2 instances or Amazon
    /// EC2 Auto Scaling groups, specify the
    /// instance ID that you are signaling as the unique ID. If you send multiple
    /// signals to a single
    /// resource (such as signaling a wait condition), each signal requires a
    /// different unique
    /// ID.
    unique_id: []const u8,
};

pub const SignalResourceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SignalResourceInput, options: CallOptions) !SignalResourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SignalResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SignalResource&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&LogicalResourceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.logical_resource_id);
    try body_buf.appendSlice(allocator, "&StackName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_name);
    try body_buf.appendSlice(allocator, "&Status=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.status.wireName());
    try body_buf.appendSlice(allocator, "&UniqueId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.unique_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SignalResourceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SignalResourceOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutDestinationPolicyInput = struct {
    /// An IAM policy document that authorizes cross-account users to deliver their
    /// log events
    /// to the associated destination. This can be up to 5120 bytes.
    access_policy: []const u8,

    /// A name for an existing destination.
    destination_name: []const u8,

    /// Specify true if you are updating an existing destination policy to grant
    /// permission to an
    /// organization ID instead of granting permission to individual Amazon Web
    /// Services accounts.
    /// Before you update a destination policy this way, you must first update the
    /// subscription
    /// filters in the accounts that send logs to this destination. If you do not,
    /// the subscription
    /// filters might stop working. By specifying `true` for `forceUpdate`, you
    /// are affirming that you have already updated the subscription filters. For
    /// more information,
    /// see [ Updating an
    /// existing cross-account
    /// subscription](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Cross-Account-Log_Subscription-Update.html)
    ///
    /// If you omit this parameter, the default of `false` is used.
    force_update: ?bool = null,

    pub const json_field_names = .{
        .access_policy = "accessPolicy",
        .destination_name = "destinationName",
        .force_update = "forceUpdate",
    };
};

pub const PutDestinationPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDestinationPolicyInput, options: CallOptions) !PutDestinationPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDestinationPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutDestinationPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDestinationPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

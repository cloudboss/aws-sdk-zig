const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Destination = @import("destination.zig").Destination;

pub const PutDestinationInput = struct {
    /// A name for the destination.
    destination_name: []const u8,

    /// The ARN of an IAM role that grants CloudWatch Logs permissions to call the
    /// Amazon
    /// Kinesis `PutRecord` operation on the destination stream.
    role_arn: []const u8,

    /// An optional list of key-value pairs to associate with the resource.
    ///
    /// For more information about tagging, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of an Amazon Kinesis stream to which to deliver matching log events.
    target_arn: []const u8,

    pub const json_field_names = .{
        .destination_name = "destinationName",
        .role_arn = "roleArn",
        .tags = "tags",
        .target_arn = "targetArn",
    };
};

pub const PutDestinationOutput = struct {
    /// The destination.
    destination: ?Destination = null,

    pub const json_field_names = .{
        .destination = "destination",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDestinationInput, options: CallOptions) !PutDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDestinationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutDestination");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDestinationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutDestinationOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ResolverQueryLogConfig = @import("resolver_query_log_config.zig").ResolverQueryLogConfig;

pub const CreateResolverQueryLogConfigInput = struct {
    /// A unique string that identifies the request and that allows failed requests
    /// to be retried
    /// without the risk of running the operation twice. `CreatorRequestId` can be
    /// any unique string, for example, a date/time stamp.
    creator_request_id: []const u8,

    /// The ARN of the resource that you want Resolver to send query logs. You can
    /// send query logs to an S3 bucket, a CloudWatch Logs log group,
    /// or a Kinesis Data Firehose delivery stream. Examples of valid values include
    /// the following:
    ///
    /// * **S3 bucket**:
    ///
    /// `arn:aws:s3:::amzn-s3-demo-bucket`
    ///
    /// You can optionally append a file prefix to the end of the ARN.
    ///
    /// `arn:aws:s3:::amzn-s3-demo-bucket/development/`
    ///
    /// * **CloudWatch Logs log group**:
    ///
    /// `arn:aws:logs:us-west-1:123456789012:log-group:/mystack-testgroup-12ABC1AB12A1:*`
    ///
    /// * **Kinesis Data Firehose delivery stream**:
    ///
    /// `arn:aws:kinesis:us-east-2:0123456789:stream/my_stream_name`
    destination_arn: []const u8,

    /// The name that you want to give the query logging configuration.
    name: []const u8,

    /// A list of the tag keys and values that you want to associate with the query
    /// logging configuration.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .destination_arn = "DestinationArn",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateResolverQueryLogConfigOutput = struct {
    /// Information about the `CreateResolverQueryLogConfig` request, including the
    /// status of the request.
    resolver_query_log_config: ?ResolverQueryLogConfig = null,

    pub const json_field_names = .{
        .resolver_query_log_config = "ResolverQueryLogConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResolverQueryLogConfigInput, options: CallOptions) !CreateResolverQueryLogConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53resolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResolverQueryLogConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.CreateResolverQueryLogConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResolverQueryLogConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateResolverQueryLogConfigOutput, body, allocator);
}

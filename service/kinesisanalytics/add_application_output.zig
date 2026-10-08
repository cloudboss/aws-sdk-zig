const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Output = @import("output.zig").Output;

pub const AddApplicationOutputInput = struct {
    /// Name of the application to which you want to add the output configuration.
    application_name: []const u8,

    /// Version of the application to which you want to add the output
    /// configuration. You
    /// can use the
    /// [DescribeApplication](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_DescribeApplication.html) operation to get the current
    /// application version. If the version specified is not the current version,
    /// the
    /// `ConcurrentModificationException` is returned.
    current_application_version_id: i64,

    /// An array of objects, each describing one output configuration. In the output
    /// configuration, you specify the name of an in-application stream, a
    /// destination (that is,
    /// an Amazon Kinesis stream, an Amazon Kinesis Firehose delivery stream, or an
    /// AWS Lambda
    /// function), and record the formation to use when writing to the destination.
    output: Output,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .current_application_version_id = "CurrentApplicationVersionId",
        .output = "Output",
    };
};

pub const AddApplicationOutputOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddApplicationOutputInput, options: CallOptions) !AddApplicationOutputOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisanalytics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddApplicationOutputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20150814.AddApplicationOutput");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddApplicationOutputOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

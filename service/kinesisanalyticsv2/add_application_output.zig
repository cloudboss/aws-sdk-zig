const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Output = @import("output.zig").Output;
const OutputDescription = @import("output_description.zig").OutputDescription;

pub const AddApplicationOutputInput = struct {
    /// The name of the application to which you want to add the output
    /// configuration.
    application_name: []const u8,

    /// The version of the application to which you want to add the output
    /// configuration. You can
    /// use the DescribeApplication operation to get the current application
    /// version. If the version specified is not the current version, the
    /// `ConcurrentModificationException` is returned.
    current_application_version_id: i64,

    /// An array of objects, each describing one output configuration. In the output
    /// configuration, you specify the name of an in-application stream, a
    /// destination (that is, a
    /// Kinesis data stream, a Kinesis Data Firehose delivery stream, or an Amazon
    /// Lambda function), and
    /// record the formation to use when writing to the destination.
    output: Output,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .current_application_version_id = "CurrentApplicationVersionId",
        .output = "Output",
    };
};

pub const AddApplicationOutputOutput = struct {
    /// The application Amazon Resource Name (ARN).
    application_arn: ?[]const u8 = null,

    /// The updated application version ID. Kinesis Data Analytics increments this
    /// ID when the application is
    /// updated.
    application_version_id: ?i64 = null,

    /// Describes the application output configuration.
    /// For more information,
    /// see [Configuring Application
    /// Output](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-output.html).
    output_descriptions: ?[]const OutputDescription = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_version_id = "ApplicationVersionId",
        .output_descriptions = "OutputDescriptions",
    };
};

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
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.AddApplicationOutput");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddApplicationOutputOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddApplicationOutputOutput, body, allocator);
}

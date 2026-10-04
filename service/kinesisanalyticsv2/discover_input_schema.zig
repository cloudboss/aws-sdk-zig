const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputProcessingConfiguration = @import("input_processing_configuration.zig").InputProcessingConfiguration;
const InputStartingPositionConfiguration = @import("input_starting_position_configuration.zig").InputStartingPositionConfiguration;
const S3Configuration = @import("s3_configuration.zig").S3Configuration;
const SourceSchema = @import("source_schema.zig").SourceSchema;

pub const DiscoverInputSchemaInput = struct {
    /// The InputProcessingConfiguration to use to preprocess the records
    /// before discovering the schema of the records.
    input_processing_configuration: ?InputProcessingConfiguration = null,

    /// The point at which you want Kinesis Data Analytics to start reading records
    /// from the
    /// specified streaming source for discovery purposes.
    input_starting_position_configuration: ?InputStartingPositionConfiguration = null,

    /// The Amazon Resource Name (ARN) of the streaming source.
    resource_arn: ?[]const u8 = null,

    /// Specify this parameter to discover a schema from data in an Amazon S3
    /// object.
    s3_configuration: ?S3Configuration = null,

    /// The ARN of the role that is used to access the streaming source.
    service_execution_role: []const u8,

    pub const json_field_names = .{
        .input_processing_configuration = "InputProcessingConfiguration",
        .input_starting_position_configuration = "InputStartingPositionConfiguration",
        .resource_arn = "ResourceARN",
        .s3_configuration = "S3Configuration",
        .service_execution_role = "ServiceExecutionRole",
    };
};

pub const DiscoverInputSchemaOutput = struct {
    /// The schema inferred from the streaming source. It identifies the format of
    /// the data in the
    /// streaming source and how each data element maps to corresponding columns in
    /// the in-application
    /// stream that you can create.
    input_schema: ?SourceSchema = null,

    /// An array of elements, where each element corresponds to a row in a stream
    /// record
    /// (a stream record can have more than one row).
    parsed_input_records: ?[]const []const []const u8 = null,

    /// The stream data that was modified by the processor specified in the
    /// `InputProcessingConfiguration` parameter.
    processed_input_records: ?[]const []const u8 = null,

    /// The raw stream data that was sampled to infer the schema.
    raw_input_records: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .input_schema = "InputSchema",
        .parsed_input_records = "ParsedInputRecords",
        .processed_input_records = "ProcessedInputRecords",
        .raw_input_records = "RawInputRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DiscoverInputSchemaInput, options: CallOptions) !DiscoverInputSchemaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DiscoverInputSchemaInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.DiscoverInputSchema");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DiscoverInputSchemaOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DiscoverInputSchemaOutput, body, allocator);
}

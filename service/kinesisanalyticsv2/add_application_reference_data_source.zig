const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReferenceDataSource = @import("reference_data_source.zig").ReferenceDataSource;
const ReferenceDataSourceDescription = @import("reference_data_source_description.zig").ReferenceDataSourceDescription;

pub const AddApplicationReferenceDataSourceInput = struct {
    /// The name of an existing application.
    application_name: []const u8,

    /// The version of the application for which you are adding the reference data
    /// source.
    /// You can
    /// use the DescribeApplication operation to get the current application
    /// version. If the version specified is not the current version, the
    /// `ConcurrentModificationException` is returned.
    current_application_version_id: i64,

    /// The reference data source can be an object in your Amazon S3 bucket. Kinesis
    /// Data Analytics reads the object and copies the data
    /// into the in-application table that is created. You provide an S3 bucket,
    /// object key name, and the resulting
    /// in-application table that is
    /// created.
    reference_data_source: ReferenceDataSource,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .current_application_version_id = "CurrentApplicationVersionId",
        .reference_data_source = "ReferenceDataSource",
    };
};

pub const AddApplicationReferenceDataSourceOutput = struct {
    /// The application Amazon Resource Name (ARN).
    application_arn: ?[]const u8 = null,

    /// The updated application version ID. Kinesis Data Analytics increments this
    /// ID when
    /// the application is updated.
    application_version_id: ?i64 = null,

    /// Describes reference data sources configured for the application.
    reference_data_source_descriptions: ?[]const ReferenceDataSourceDescription = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_version_id = "ApplicationVersionId",
        .reference_data_source_descriptions = "ReferenceDataSourceDescriptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddApplicationReferenceDataSourceInput, options: CallOptions) !AddApplicationReferenceDataSourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddApplicationReferenceDataSourceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.AddApplicationReferenceDataSource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddApplicationReferenceDataSourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddApplicationReferenceDataSourceOutput, body, allocator);
}

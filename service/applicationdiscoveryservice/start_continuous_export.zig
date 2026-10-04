const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSource = @import("data_source.zig").DataSource;

pub const StartContinuousExportInput = struct {
};

pub const StartContinuousExportOutput = struct {
    /// The type of data collector used to gather this data (currently only offered
    /// for
    /// AGENT).
    data_source: ?DataSource = null,

    /// The unique ID assigned to this export.
    export_id: ?[]const u8 = null,

    /// The name of the s3 bucket where the export data parquet files are stored.
    s_3_bucket: ?[]const u8 = null,

    /// A dictionary which describes how the data is stored.
    ///
    /// * `databaseName` - the name of the Glue database used to store the
    /// schema.
    schema_storage_config: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp representing when the continuous export was started.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .data_source = "dataSource",
        .export_id = "exportId",
        .s_3_bucket = "s3Bucket",
        .schema_storage_config = "schemaStorageConfig",
        .start_time = "startTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartContinuousExportInput, options: CallOptions) !StartContinuousExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "discovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartContinuousExportInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("discovery", "Application Discovery Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.StartContinuousExport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartContinuousExportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartContinuousExportOutput, body, allocator);
}

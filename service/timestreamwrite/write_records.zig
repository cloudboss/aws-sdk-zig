const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Record = @import("record.zig").Record;
const RecordsIngested = @import("records_ingested.zig").RecordsIngested;

pub const WriteRecordsInput = struct {
    /// A record that contains the common measure, dimension, time, and version
    /// attributes
    /// shared across all the records in the request. The measure and dimension
    /// attributes
    /// specified will be merged with the measure and dimension attributes in the
    /// records object
    /// when the data is written into Timestream. Dimensions may not overlap, or a
    /// `ValidationException` will be thrown. In other words, a record must contain
    /// dimensions with unique names.
    common_attributes: ?Record = null,

    /// The name of the Timestream database.
    database_name: []const u8,

    /// An array of records that contain the unique measure, dimension, time, and
    /// version
    /// attributes for each time-series data point.
    records: []const Record,

    /// The name of the Timestream table.
    table_name: []const u8,

    pub const json_field_names = .{
        .common_attributes = "CommonAttributes",
        .database_name = "DatabaseName",
        .records = "Records",
        .table_name = "TableName",
    };
};

pub const WriteRecordsOutput = struct {
    /// Information on the records ingested by this request.
    records_ingested: ?RecordsIngested = null,

    pub const json_field_names = .{
        .records_ingested = "RecordsIngested",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: WriteRecordsInput, options: CallOptions) !WriteRecordsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: WriteRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ingest.timestream", "Timestream Write", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.WriteRecords");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !WriteRecordsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(WriteRecordsOutput, body, allocator);
}

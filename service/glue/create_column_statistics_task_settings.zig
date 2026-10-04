const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateColumnStatisticsTaskSettingsInput = struct {
    /// The ID of the Data Catalog in which the database resides.
    catalog_id: ?[]const u8 = null,

    /// A list of column names for which to run statistics.
    column_name_list: ?[]const []const u8 = null,

    /// The name of the database where the table resides.
    database_name: []const u8,

    /// The role used for running the column statistics.
    role: []const u8,

    /// The percentage of data to sample.
    sample_size: ?f64 = null,

    /// A schedule for running the column statistics, specified in CRON syntax.
    schedule: ?[]const u8 = null,

    /// Name of the security configuration that is used to encrypt CloudWatch logs.
    security_configuration: ?[]const u8 = null,

    /// The name of the table for which to generate column statistics.
    table_name: []const u8,

    /// A map of tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogID",
        .column_name_list = "ColumnNameList",
        .database_name = "DatabaseName",
        .role = "Role",
        .sample_size = "SampleSize",
        .schedule = "Schedule",
        .security_configuration = "SecurityConfiguration",
        .table_name = "TableName",
        .tags = "Tags",
    };
};

pub const CreateColumnStatisticsTaskSettingsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateColumnStatisticsTaskSettingsInput, options: CallOptions) !CreateColumnStatisticsTaskSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateColumnStatisticsTaskSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateColumnStatisticsTaskSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateColumnStatisticsTaskSettingsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

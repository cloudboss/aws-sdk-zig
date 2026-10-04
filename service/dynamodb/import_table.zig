const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputCompressionType = @import("input_compression_type.zig").InputCompressionType;
const InputFormat = @import("input_format.zig").InputFormat;
const InputFormatOptions = @import("input_format_options.zig").InputFormatOptions;
const S3BucketSource = @import("s3_bucket_source.zig").S3BucketSource;
const TableCreationParameters = @import("table_creation_parameters.zig").TableCreationParameters;
const ImportTableDescription = @import("import_table_description.zig").ImportTableDescription;

pub const ImportTableInput = struct {
    /// Providing a `ClientToken` makes the call to `ImportTableInput`
    /// idempotent, meaning that multiple identical calls have the same effect as
    /// one single
    /// call.
    ///
    /// A client token is valid for 8 hours after the first request that uses it is
    /// completed.
    /// After 8 hours, any request with the same client token is treated as a new
    /// request. Do
    /// not resubmit the same request with the same client token for more than 8
    /// hours, or the
    /// result might not be idempotent.
    ///
    /// If you submit a request with the same client token but a change in other
    /// parameters
    /// within the 8-hour idempotency window, DynamoDB returns an
    /// `IdempotentParameterMismatch` exception.
    client_token: ?[]const u8 = null,

    /// Type of compression to be used on the input coming from the imported table.
    input_compression_type: ?InputCompressionType = null,

    /// The format of the source data. Valid values for `ImportFormat` are
    /// `CSV`, `DYNAMODB_JSON` or `ION`.
    input_format: InputFormat,

    /// Additional properties that specify how the input is formatted,
    input_format_options: ?InputFormatOptions = null,

    /// The S3 bucket that provides the source for the import.
    s3_bucket_source: S3BucketSource,

    /// Parameters for the table to import the data into.
    table_creation_parameters: TableCreationParameters,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .input_compression_type = "InputCompressionType",
        .input_format = "InputFormat",
        .input_format_options = "InputFormatOptions",
        .s3_bucket_source = "S3BucketSource",
        .table_creation_parameters = "TableCreationParameters",
    };
};

pub const ImportTableOutput = struct {
    /// Represents the properties of the table created for the import, and
    /// parameters of the
    /// import. The import parameters include import status, how many items were
    /// processed, and
    /// how many errors were encountered.
    import_table_description: ?ImportTableDescription = null,

    pub const json_field_names = .{
        .import_table_description = "ImportTableDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportTableInput, options: CallOptions) !ImportTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.ImportTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportTableOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ImportTableOutput, body, allocator);
}

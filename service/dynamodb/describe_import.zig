const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportTableDescription = @import("import_table_description.zig").ImportTableDescription;

pub const DescribeImportInput = struct {
    /// The Amazon Resource Name (ARN) associated with the table you're importing
    /// to.
    import_arn: []const u8,

    pub const json_field_names = .{
        .import_arn = "ImportArn",
    };
};

pub const DescribeImportOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeImportInput, options: CallOptions) !DescribeImportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeImportInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.DescribeImport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeImportOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeImportOutput, body, allocator);
}

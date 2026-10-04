const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Database = @import("database.zig").Database;

pub const CreateDatabaseInput = struct {
    /// The name of the Timestream database.
    database_name: []const u8,

    /// The KMS key for the database. If the KMS key is not
    /// specified, the database will be encrypted with a Timestream managed KMS key
    /// located in your account. For more information, see [Amazon Web Services
    /// managed
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk).
    kms_key_id: ?[]const u8 = null,

    /// A list of key-value pairs to label the table.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .kms_key_id = "KmsKeyId",
        .tags = "Tags",
    };
};

pub const CreateDatabaseOutput = struct {
    /// The newly created Timestream database.
    database: ?Database = null,

    pub const json_field_names = .{
        .database = "Database",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatabaseInput, options: CallOptions) !CreateDatabaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatabaseInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.CreateDatabase");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatabaseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDatabaseOutput, body, allocator);
}

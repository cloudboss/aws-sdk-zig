const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Database = @import("database.zig").Database;

pub const UpdateDatabaseInput = struct {
    /// The name of the database.
    database_name: []const u8,

    /// The identifier of the new KMS key (`KmsKeyId`) to be used to
    /// encrypt the data stored in the database. If the `KmsKeyId` currently
    /// registered
    /// with the database is the same as the `KmsKeyId` in the request, there will
    /// not
    /// be any update.
    ///
    /// You can specify the `KmsKeyId` using any of the following:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    /// `arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Alias name: `alias/ExampleAlias`
    ///
    /// * Alias ARN:
    /// `arn:aws:kms:us-east-1:111122223333:alias/ExampleAlias`
    kms_key_id: []const u8,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .kms_key_id = "KmsKeyId",
    };
};

pub const UpdateDatabaseOutput = struct {
    database: ?Database = null,

    pub const json_field_names = .{
        .database = "Database",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDatabaseInput, options: CallOptions) !UpdateDatabaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDatabaseInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.UpdateDatabase");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDatabaseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDatabaseOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateLookupTableInput = struct {
    /// An updated description of the lookup table.
    description: ?[]const u8 = null,

    /// The ARN of the KMS key to use to encrypt the lookup table data. You can
    /// use this parameter to add, update, or remove the KMS key. To remove the KMS
    /// key and use an
    /// Amazon Web Services-owned key instead, specify an empty string.
    kms_key_id: ?[]const u8 = null,

    /// The ARN of the lookup table to update.
    lookup_table_arn: []const u8,

    /// The new CSV content to replace the existing data. The first row must be a
    /// header row
    /// with column names. The content must use UTF-8 encoding and not exceed 10 MB.
    table_body: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .lookup_table_arn = "lookupTableArn",
        .table_body = "tableBody",
    };
};

pub const UpdateLookupTableOutput = struct {
    /// The time when the lookup table was last updated, expressed as the number of
    /// milliseconds after `Jan 1, 1970 00:00:00 UTC`.
    last_updated_time: ?i64 = null,

    /// The ARN of the lookup table that was updated.
    lookup_table_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_updated_time = "lastUpdatedTime",
        .lookup_table_arn = "lookupTableArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLookupTableInput, options: CallOptions) !UpdateLookupTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLookupTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.UpdateLookupTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLookupTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateLookupTableOutput, body, allocator);
}

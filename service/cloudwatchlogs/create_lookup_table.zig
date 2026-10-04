const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateLookupTableInput = struct {
    /// A description of the lookup table. The description can be up to 1024
    /// characters
    /// long.
    description: ?[]const u8 = null,

    /// The ARN of the KMS key to use to encrypt the lookup table data. If you
    /// don't specify a key, the data is encrypted with an Amazon Web Services-owned
    /// key.
    kms_key_id: ?[]const u8 = null,

    /// The name of the lookup table. The name must be unique within your account
    /// and Region.
    /// The name can contain only alphanumeric characters and underscores, and can
    /// be up to
    /// 256 characters long.
    lookup_table_name: []const u8,

    /// The CSV content of the lookup table. The first row must be a header row with
    /// column
    /// names. The content must use UTF-8 encoding and not exceed 10 MB.
    table_body: []const u8,

    /// A list of key-value pairs to associate with the lookup table. You can
    /// associate as many
    /// as 50 tags with a lookup table. Tags can help you organize and categorize
    /// your
    /// resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .lookup_table_name = "lookupTableName",
        .table_body = "tableBody",
        .tags = "tags",
    };
};

pub const CreateLookupTableOutput = struct {
    /// The time when the lookup table was created, expressed as the number of
    /// milliseconds
    /// after `Jan 1, 1970 00:00:00 UTC`.
    created_at: ?i64 = null,

    /// The ARN of the lookup table that was created.
    lookup_table_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .lookup_table_arn = "lookupTableArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLookupTableInput, options: CallOptions) !CreateLookupTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLookupTableInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.CreateLookupTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLookupTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLookupTableOutput, body, allocator);
}

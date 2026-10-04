const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportFilter = @import("import_filter.zig").ImportFilter;

pub const CreateImportTaskInput = struct {
    /// Optional filters to constrain the import by CloudTrail event time. Times are
    /// specified in Unix timestamp milliseconds.
    /// The range of data being imported must be within the specified source's
    /// retention period.
    import_filter: ?ImportFilter = null,

    /// The ARN of the IAM role that grants CloudWatch Logs permission to import
    /// from the CloudTrail Lake Event Data Store.
    import_role_arn: []const u8,

    /// The ARN of the source to import from.
    import_source_arn: []const u8,

    pub const json_field_names = .{
        .import_filter = "importFilter",
        .import_role_arn = "importRoleArn",
        .import_source_arn = "importSourceArn",
    };
};

pub const CreateImportTaskOutput = struct {
    /// The timestamp when the import task was created, expressed as the number of
    /// milliseconds after Jan 1, 1970 00:00:00 UTC.
    creation_time: ?i64 = null,

    /// The ARN of the CloudWatch Logs log group created as the destination for the
    /// imported events.
    import_destination_arn: ?[]const u8 = null,

    /// A unique identifier for the import task.
    import_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .import_destination_arn = "importDestinationArn",
        .import_id = "importId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateImportTaskInput, options: CallOptions) !CreateImportTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateImportTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.CreateImportTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateImportTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateImportTaskOutput, body, allocator);
}

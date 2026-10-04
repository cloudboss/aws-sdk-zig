const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportStatus = @import("import_status.zig").ImportStatus;
const MergeStrategy = @import("merge_strategy.zig").MergeStrategy;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const GetImportInput = struct {
    /// The identifier of the import job information to return.
    import_id: []const u8,

    pub const json_field_names = .{
        .import_id = "importId",
    };
};

pub const GetImportOutput = struct {
    /// A timestamp for the date and time that the import job was
    /// created.
    created_date: ?i64 = null,

    /// A string that describes why an import job failed to
    /// complete.
    failure_reason: ?[]const []const u8 = null,

    /// The identifier for the specific import job.
    import_id: ?[]const u8 = null,

    /// The status of the import job. If the status is `FAILED`,
    /// you can get the reason for the failure from the `failureReason`
    /// field.
    import_status: ?ImportStatus = null,

    /// The action taken when there was a conflict between an existing
    /// resource and a resource in the import file.
    merge_strategy: ?MergeStrategy = null,

    /// The name given to the import job.
    name: ?[]const u8 = null,

    /// The type of resource imported.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .failure_reason = "failureReason",
        .import_id = "importId",
        .import_status = "importStatus",
        .merge_strategy = "mergeStrategy",
        .name = "name",
        .resource_type = "resourceType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImportInput, options: CallOptions) !GetImportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetImportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/imports/");
    try path_buf.appendSlice(allocator, input.import_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImportOutput {
    const result: GetImportOutput = try aws.json.parseJsonObject(
        GetImportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

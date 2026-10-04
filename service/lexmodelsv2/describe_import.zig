const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportStatus = @import("import_status.zig").ImportStatus;
const MergeStrategy = @import("merge_strategy.zig").MergeStrategy;
const ImportResourceSpecification = @import("import_resource_specification.zig").ImportResourceSpecification;

pub const DescribeImportInput = struct {
    /// The unique identifier of the import to describe.
    import_id: []const u8,

    pub const json_field_names = .{
        .import_id = "importId",
    };
};

pub const DescribeImportOutput = struct {
    /// The date and time that the import was created.
    creation_date_time: ?i64 = null,

    /// If the `importStatus` field is `Failed`, this
    /// provides one or more reasons for the failure.
    failure_reasons: ?[]const []const u8 = null,

    /// The unique identifier that Amazon Lex assigned to the resource created by
    /// the import.
    imported_resource_id: ?[]const u8 = null,

    /// The name of the imported resource.
    imported_resource_name: ?[]const u8 = null,

    /// The unique identifier of the described import.
    import_id: ?[]const u8 = null,

    /// The status of the import process. When the status is
    /// `Completed` the resource is imported and ready for
    /// use.
    import_status: ?ImportStatus = null,

    /// The date and time that the import was last updated.
    last_updated_date_time: ?i64 = null,

    /// The strategy used when there was a name conflict between the
    /// imported resource and an existing resource. When the merge strategy is
    /// `FailOnConflict` existing resources are not overwritten
    /// and the import fails.
    merge_strategy: ?MergeStrategy = null,

    /// The specifications of the imported bot, bot locale, or custom
    /// vocabulary.
    resource_specification: ?ImportResourceSpecification = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .failure_reasons = "failureReasons",
        .imported_resource_id = "importedResourceId",
        .imported_resource_name = "importedResourceName",
        .import_id = "importId",
        .import_status = "importStatus",
        .last_updated_date_time = "lastUpdatedDateTime",
        .merge_strategy = "mergeStrategy",
        .resource_specification = "resourceSpecification",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeImportInput, options: CallOptions) !DescribeImportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeImportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeImportOutput {
    var result: DescribeImportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeImportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MergeStrategy = @import("merge_strategy.zig").MergeStrategy;
const ImportResourceSpecification = @import("import_resource_specification.zig").ImportResourceSpecification;
const ImportStatus = @import("import_status.zig").ImportStatus;

pub const StartImportInput = struct {
    /// The password used to encrypt the zip archive that contains the
    /// resource definition. You should always encrypt the zip archive to
    /// protect it during transit between your site and Amazon Lex.
    file_password: ?[]const u8 = null,

    /// The unique identifier for the import. It is included in the response
    /// from the
    /// [CreateUploadUrl](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_CreateUploadUrl.html) operation.
    import_id: []const u8,

    /// The strategy to use when there is a name conflict between the
    /// imported resource and an existing resource. When the merge strategy is
    /// `FailOnConflict` existing resources are not overwritten
    /// and the import fails.
    merge_strategy: MergeStrategy,

    /// Parameters for creating the bot, bot locale or custom
    /// vocabulary.
    resource_specification: ImportResourceSpecification,

    pub const json_field_names = .{
        .file_password = "filePassword",
        .import_id = "importId",
        .merge_strategy = "mergeStrategy",
        .resource_specification = "resourceSpecification",
    };
};

pub const StartImportOutput = struct {
    /// The date and time that the import request was created.
    creation_date_time: ?i64 = null,

    /// A unique identifier for the import.
    import_id: ?[]const u8 = null,

    /// The current status of the import. When the status is
    /// `Complete` the bot, bot alias, or custom vocabulary is
    /// ready to use.
    import_status: ?ImportStatus = null,

    /// The strategy used when there was a name conflict between the
    /// imported resource and an existing resource. When the merge strategy is
    /// `FailOnConflict` existing resources are not overwritten
    /// and the import fails.
    merge_strategy: ?MergeStrategy = null,

    /// The parameters used when importing the resource.
    resource_specification: ?ImportResourceSpecification = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .import_id = "importId",
        .import_status = "importStatus",
        .merge_strategy = "mergeStrategy",
        .resource_specification = "resourceSpecification",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartImportInput, options: CallOptions) !StartImportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartImportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/imports";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.file_password) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filePassword\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"importId\":");
    try aws.json.writeValue(@TypeOf(input.import_id), input.import_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"mergeStrategy\":");
    try aws.json.writeValue(@TypeOf(input.merge_strategy), input.merge_strategy, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceSpecification\":");
    try aws.json.writeValue(@TypeOf(input.resource_specification), input.resource_specification, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartImportOutput {
    const result: StartImportOutput = try aws.json.parseJsonObject(
        StartImportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

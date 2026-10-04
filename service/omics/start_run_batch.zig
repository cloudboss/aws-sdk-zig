const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchRunSettings = @import("batch_run_settings.zig").BatchRunSettings;
const DefaultRunSetting = @import("default_run_setting.zig").DefaultRunSetting;
const BatchStatus = @import("batch_status.zig").BatchStatus;

pub const StartRunBatchInput = struct {
    /// An optional user-friendly name for the run batch.
    batch_name: ?[]const u8 = null,

    /// The individual run configurations. Specify exactly one of `inlineSettings`
    /// or `s3UriSettings`. See `BatchRunSettings`.
    batch_run_settings: BatchRunSettings,

    /// Shared configuration applied to all runs in the batch. See
    /// `DefaultRunSetting`.
    default_run_setting: DefaultRunSetting,

    /// A client token used to deduplicate retry requests and prevent duplicate
    /// batches from being created.
    request_id: []const u8,

    /// Amazon Web Services tags to associate with the batch resource. These tags
    /// are not inherited by individual runs. To tag individual runs, use
    /// `defaultRunSetting.runTags`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .batch_name = "batchName",
        .batch_run_settings = "batchRunSettings",
        .default_run_setting = "defaultRunSetting",
        .request_id = "requestId",
        .tags = "tags",
    };
};

pub const StartRunBatchOutput = struct {
    /// The unique ARN of the run batch.
    arn: ?[]const u8 = null,

    /// The identifier portion of the run batch ARN.
    id: ?[]const u8 = null,

    /// The initial status of the run batch. Returns `CREATING` while the batch is
    /// being initialized.
    status: ?BatchStatus = null,

    /// Amazon Web Services tags associated with the run batch.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The universally unique identifier (UUID) for the run batch.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .status = "status",
        .tags = "tags",
        .uuid = "uuid",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartRunBatchInput, options: CallOptions) !StartRunBatchOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartRunBatchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/runBatch";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.batch_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"batchName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"batchRunSettings\":");
    try aws.json.writeValue(@TypeOf(input.batch_run_settings), input.batch_run_settings, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"defaultRunSetting\":");
    try aws.json.writeValue(@TypeOf(input.default_run_setting), input.default_run_setting, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"requestId\":");
    try aws.json.writeValue(@TypeOf(input.request_id), input.request_id, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartRunBatchOutput {
    const result: StartRunBatchOutput = try aws.json.parseJsonObject(
        StartRunBatchOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

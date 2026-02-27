const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChangeType = @import("change_type.zig").ChangeType;

pub const CreateChangesetInput = struct {
    /// The option to indicate how a Changeset will be applied to a Dataset.
    ///
    /// * `REPLACE` – Changeset will be considered as a replacement to all prior
    /// loaded Changesets.
    ///
    /// * `APPEND` – Changeset will be considered as an addition to the end of all
    /// prior loaded Changesets.
    ///
    /// * `MODIFY` – Changeset is considered as a replacement to a specific prior
    ///   ingested Changeset.
    change_type: ChangeType,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// The unique identifier for the FinSpace Dataset where the Changeset will be
    /// created.
    dataset_id: []const u8,

    /// Options that define the structure of the source file(s) including the format
    /// type (`formatType`), header row (`withHeader`), data separation character
    /// (`separator`) and the type of compression (`compression`).
    ///
    /// `formatType` is a required attribute and can have the following values:
    ///
    /// * `PARQUET` – Parquet source file format.
    ///
    /// * `CSV` – CSV source file format.
    ///
    /// * `JSON` – JSON source file format.
    ///
    /// * `XML` – XML source file format.
    ///
    /// Here is an example of how you could specify the `formatParams`:
    ///
    /// `
    /// "formatParams":
    /// {
    /// "formatType": "CSV",
    /// "withHeader": "true",
    /// "separator": ",",
    /// "compression":"None"
    /// }
    /// `
    ///
    /// Note that if you only provide `formatType` as `CSV`, the rest of the
    /// attributes will automatically default to CSV values as following:
    ///
    /// `
    /// {
    /// "withHeader": "true",
    /// "separator": ","
    /// }
    /// `
    ///
    /// For more information about supported file formats, see [Supported Data Types
    /// and File
    /// Formats](https://docs.aws.amazon.com/finspace/latest/userguide/supported-data-types.html) in the FinSpace User Guide.
    format_params: []const aws.map.StringMapEntry,

    /// Options that define the location of the data being ingested (`s3SourcePath`)
    /// and the source of the changeset (`sourceType`).
    ///
    /// Both `s3SourcePath` and `sourceType` are required attributes.
    ///
    /// Here is an example of how you could specify the `sourceParams`:
    ///
    /// `
    /// "sourceParams":
    /// {
    /// "s3SourcePath":
    /// "s3://finspace-landing-us-east-2-bk7gcfvitndqa6ebnvys4d/scratch/wr5hh8pwkpqqkxa4sxrmcw/ingestion/equity.csv",
    /// "sourceType": "S3"
    /// }
    /// `
    ///
    /// The S3 path that you specify must allow the FinSpace role access. To do
    /// that, you first need to configure the IAM policy on S3 bucket. For more
    /// information, see [Loading data from an Amazon S3 Bucket using the FinSpace
    /// API](https://docs.aws.amazon.com/finspace/latest/data-api/fs-using-the-finspace-api.html#access-s3-buckets) section.
    source_params: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .change_type = "changeType",
        .client_token = "clientToken",
        .dataset_id = "datasetId",
        .format_params = "formatParams",
        .source_params = "sourceParams",
    };
};

pub const CreateChangesetOutput = struct {
    /// The unique identifier of the Changeset that is created.
    changeset_id: ?[]const u8 = null,

    /// The unique identifier for the FinSpace Dataset where the Changeset is
    /// created.
    dataset_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .changeset_id = "changesetId",
        .dataset_id = "datasetId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChangesetInput, options: Options) !CreateChangesetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "finspacedata");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateChangesetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspacedata", "finspace data", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/datasets/");
    try path_buf.appendSlice(alloc, input.dataset_id);
    try path_buf.appendSlice(alloc, "/changesetsv2");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"changeType\":");
    try aws.json.writeValue(@TypeOf(input.change_type), input.change_type, alloc, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"formatParams\":");
    try aws.json.writeValue(@TypeOf(input.format_params), input.format_params, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"sourceParams\":");
    try aws.json.writeValue(@TypeOf(input.source_params), input.source_params, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateChangesetOutput {
    var result: CreateChangesetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateChangesetOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

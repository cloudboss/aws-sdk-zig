const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateChangesetInput = struct {
    /// The unique identifier for the Changeset to update.
    changeset_id: []const u8,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// The unique identifier for the FinSpace Dataset in which the Changeset is
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
    /// API](https://docs.aws.amazon.com/finspace/latest/data-api/fs-using-the-finspace-api.html#access-s3-buckets)section.
    source_params: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .changeset_id = "changesetId",
        .client_token = "clientToken",
        .dataset_id = "datasetId",
        .format_params = "formatParams",
        .source_params = "sourceParams",
    };
};

pub const UpdateChangesetOutput = struct {
    /// The unique identifier for the Changeset to update.
    changeset_id: ?[]const u8 = null,

    /// The unique identifier for the FinSpace Dataset in which the Changeset is
    /// created.
    dataset_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .changeset_id = "changesetId",
        .dataset_id = "datasetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChangesetInput, options: CallOptions) !UpdateChangesetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace-api", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChangesetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    try path_buf.appendSlice(allocator, "/changesetsv2/");
    try path_buf.appendSlice(allocator, input.changeset_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"formatParams\":");
    try aws.json.writeValue(@TypeOf(input.format_params), input.format_params, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceParams\":");
    try aws.json.writeValue(@TypeOf(input.source_params), input.source_params, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChangesetOutput {
    var result: UpdateChangesetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateChangesetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

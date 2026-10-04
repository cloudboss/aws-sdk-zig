const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetSource = @import("dataset_source.zig").DatasetSource;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

pub const CreateDatasetInput = struct {
    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// A description about the dataset, and its functionality.
    dataset_description: ?[]const u8 = null,

    /// The ID of the dataset.
    dataset_id: ?[]const u8 = null,

    /// The name of the dataset.
    dataset_name: []const u8,

    /// The data source for the dataset.
    dataset_source: DatasetSource,

    /// A list of key-value pairs that contain metadata for the access policy. For
    /// more
    /// information, see [Tagging your
    /// IoT SiteWise
    /// resources](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/tag-resources.html) in the *IoT SiteWise User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .dataset_description = "datasetDescription",
        .dataset_id = "datasetId",
        .dataset_name = "datasetName",
        .dataset_source = "datasetSource",
        .tags = "tags",
    };
};

pub const CreateDatasetOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// of the dataset.
    /// The format is
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:dataset/${DatasetId}`.
    dataset_arn: []const u8,

    /// The ID of the dataset.
    dataset_id: []const u8,

    /// The status of the dataset. This contains the state and any error messages.
    /// State is `CREATING` after a successfull call to this API, and any associated
    /// error message. The state is
    /// `ACTIVE` when ready to use.
    dataset_status: ?DatasetStatus = null,

    pub const json_field_names = .{
        .dataset_arn = "datasetArn",
        .dataset_id = "datasetId",
        .dataset_status = "datasetStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetInput, options: CallOptions) !CreateDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/datasets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dataset_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"datasetDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dataset_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"datasetId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"datasetName\":");
    try aws.json.writeValue(@TypeOf(input.dataset_name), input.dataset_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"datasetSource\":");
    try aws.json.writeValue(@TypeOf(input.dataset_source), input.dataset_source, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetOutput {
    var result: CreateDatasetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDatasetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

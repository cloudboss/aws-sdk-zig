const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LosslessStorageFormat = @import("lossless_storage_format.zig").LosslessStorageFormat;
const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;

pub const CreateDatastoreInput = struct {
    /// A unique identifier for API idempotency.
    client_token: []const u8,

    /// The data store name.
    datastore_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) assigned to the Key Management Service (KMS)
    /// key for accessing encrypted data.
    kms_key_arn: ?[]const u8 = null,

    /// The ARN of the authorizer's Lambda function.
    lambda_authorizer_arn: ?[]const u8 = null,

    /// The lossless storage format for the datastore.
    lossless_storage_format: ?LosslessStorageFormat = null,

    /// The tags provided when creating a data store.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .datastore_name = "datastoreName",
        .kms_key_arn = "kmsKeyArn",
        .lambda_authorizer_arn = "lambdaAuthorizerArn",
        .lossless_storage_format = "losslessStorageFormat",
        .tags = "tags",
    };
};

pub const CreateDatastoreOutput = struct {
    /// The data store identifier.
    datastore_id: []const u8,

    /// The data store status.
    datastore_status: DatastoreStatus,

    pub const json_field_names = .{
        .datastore_id = "datastoreId",
        .datastore_status = "datastoreStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatastoreInput, options: CallOptions) !CreateDatastoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medical-imaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatastoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medical-imaging", "Medical Imaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/datastore";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.datastore_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"datastoreName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lambda_authorizer_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"lambdaAuthorizerArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lossless_storage_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"losslessStorageFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatastoreOutput {
    var result: CreateDatastoreOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDatastoreOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

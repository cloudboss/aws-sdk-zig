const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3SseAlgorithm = @import("s3_sse_algorithm.zig").S3SseAlgorithm;

pub const StartDomainExportInput = struct {
    /// Providing a ClientToken makes the call to StartDomainExport API idempotent,
    /// meaning that multiple identical calls have the same effect as one single
    /// call. A client token is valid for
    /// 8 hours after the first request that uses it is completed. After 8 hours,
    /// any request with the same client token
    /// is treated as a new request. Do not resubmit the same request with the same
    /// client token for more than 8 hours,
    /// or the result might not be idempotent. If you submit a request with the same
    /// client token but a change
    /// in other parameters within the 8-hour idempotency window, a
    /// ConflictException will be returned.
    client_token: ?[]const u8 = null,

    /// The name of the domain to export.
    domain_name: []const u8,

    /// The name of the S3 bucket where the domain data will be exported.
    s_3_bucket: []const u8,

    /// The ID of the AWS account that owns the bucket the export will be stored in.
    s_3_bucket_owner: ?[]const u8 = null,

    /// The prefix string to be used to generate the S3 object keys for export
    /// artifacts.
    s_3_key_prefix: ?[]const u8 = null,

    /// The server-side encryption algorithm to use for the exported data in S3.
    /// Valid values are: AES256 (SSE-S3) and KMS (SSE-KMS). If not specified,
    /// bucket's default encryption will apply.
    s_3_sse_algorithm: ?S3SseAlgorithm = null,

    /// The KMS key ID to use for server-side encryption with AWS KMS-managed keys
    /// (SSE-KMS).
    /// This parameter is only expected with KMS as the S3 SSE algorithm.
    s_3_sse_kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_name = "domainName",
        .s_3_bucket = "s3Bucket",
        .s_3_bucket_owner = "s3BucketOwner",
        .s_3_key_prefix = "s3KeyPrefix",
        .s_3_sse_algorithm = "s3SseAlgorithm",
        .s_3_sse_kms_key_id = "s3SseKmsKeyId",
    };
};

pub const StartDomainExportOutput = struct {
    /// The client token that was provided in the request.
    client_token: []const u8,

    /// Unique ARN identifier of the export.
    export_arn: []const u8,

    /// Timestamp when the export request was received by the service.
    requested_at: i64,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .export_arn = "exportArn",
        .requested_at = "requestedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDomainExportInput, options: CallOptions) !StartDomainExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sdb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDomainExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sdb", "SimpleDBv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/StartDomainExport";

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
    try body_buf.appendSlice(allocator, "\"domainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"s3Bucket\":");
    try aws.json.writeValue(@TypeOf(input.s_3_bucket), input.s_3_bucket, allocator, &body_buf);
    has_prev = true;
    if (input.s_3_bucket_owner) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"s3BucketOwner\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s_3_key_prefix) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"s3KeyPrefix\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s_3_sse_algorithm) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"s3SseAlgorithm\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s_3_sse_kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"s3SseKmsKeyId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDomainExportOutput {
    const result: StartDomainExportOutput = try aws.json.parseJsonObject(
        StartDomainExportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

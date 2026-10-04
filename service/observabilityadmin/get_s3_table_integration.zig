const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Encryption = @import("encryption.zig").Encryption;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;

pub const GetS3TableIntegrationInput = struct {
    /// The Amazon Resource Name (ARN) of the S3 Table integration to retrieve.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const GetS3TableIntegrationOutput = struct {
    /// The Amazon Resource Name (ARN) of the S3 Table integration.
    arn: ?[]const u8 = null,

    /// The timestamp when the S3 Table integration was created.
    created_time_stamp: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the S3 bucket used as the destination for
    /// the table data.
    destination_table_bucket_arn: ?[]const u8 = null,

    /// The encryption configuration for the S3 Table integration.
    encryption: ?Encryption = null,

    /// The Amazon Resource Name (ARN) of the IAM role used by the S3 Table
    /// integration.
    role_arn: ?[]const u8 = null,

    /// The current status of the S3 Table integration.
    status: ?IntegrationStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time_stamp = "CreatedTimeStamp",
        .destination_table_bucket_arn = "DestinationTableBucketArn",
        .encryption = "Encryption",
        .role_arn = "RoleArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetS3TableIntegrationInput, options: CallOptions) !GetS3TableIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "observabilityadmin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetS3TableIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetS3TableIntegration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetS3TableIntegrationOutput {
    var result: GetS3TableIntegrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetS3TableIntegrationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

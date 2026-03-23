const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const VerifiedAccessLogOptions = @import("verified_access_log_options.zig").VerifiedAccessLogOptions;
const VerifiedAccessInstanceLoggingConfiguration = @import("verified_access_instance_logging_configuration.zig").VerifiedAccessInstanceLoggingConfiguration;
const serde = @import("serde.zig");

pub const ModifyVerifiedAccessInstanceLoggingConfigurationInput = struct {
    /// The configuration options for Verified Access instances.
    access_logs: VerifiedAccessLogOptions,

    /// A unique, case-sensitive token that you provide to ensure idempotency of
    /// your
    /// modification request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the Verified Access instance.
    verified_access_instance_id: []const u8,
};

pub const ModifyVerifiedAccessInstanceLoggingConfigurationOutput = struct {
    /// The logging configuration for the Verified Access instance.
    logging_configuration: ?VerifiedAccessInstanceLoggingConfiguration = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyVerifiedAccessInstanceLoggingConfigurationInput, options: CallOptions) !ModifyVerifiedAccessInstanceLoggingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyVerifiedAccessInstanceLoggingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyVerifiedAccessInstanceLoggingConfiguration&Version=2016-11-15");
    if (input.access_logs.cloud_watch_logs) |sv| {
        try body_buf.appendSlice(allocator, "&AccessLogs.CloudWatchLogs.Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv.enabled) "true" else "false");
        if (sv.log_group) |sv2| {
            try body_buf.appendSlice(allocator, "&AccessLogs.CloudWatchLogs.LogGroup=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.access_logs.include_trust_context) |sv| {
        try body_buf.appendSlice(allocator, "&AccessLogs.IncludeTrustContext=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.access_logs.kinesis_data_firehose) |sv| {
        if (sv.delivery_stream) |sv2| {
            try body_buf.appendSlice(allocator, "&AccessLogs.KinesisDataFirehose.DeliveryStream=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        try body_buf.appendSlice(allocator, "&AccessLogs.KinesisDataFirehose.Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv.enabled) "true" else "false");
    }
    if (input.access_logs.log_version) |sv| {
        try body_buf.appendSlice(allocator, "&AccessLogs.LogVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.access_logs.s3) |sv| {
        if (sv.bucket_name) |sv2| {
            try body_buf.appendSlice(allocator, "&AccessLogs.S3.BucketName=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.bucket_owner) |sv2| {
            try body_buf.appendSlice(allocator, "&AccessLogs.S3.BucketOwner=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        try body_buf.appendSlice(allocator, "&AccessLogs.S3.Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv.enabled) "true" else "false");
        if (sv.prefix) |sv2| {
            try body_buf.appendSlice(allocator, "&AccessLogs.S3.Prefix=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&VerifiedAccessInstanceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.verified_access_instance_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyVerifiedAccessInstanceLoggingConfigurationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVerifiedAccessInstanceLoggingConfigurationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "loggingConfiguration")) {
                    result.logging_configuration = try serde.deserializeVerifiedAccessInstanceLoggingConfiguration(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

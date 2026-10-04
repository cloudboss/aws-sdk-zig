const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogDestinationType = @import("log_destination_type.zig").LogDestinationType;
const serde = @import("serde.zig");

pub const EnableLoggingInput = struct {
    /// The name of an existing S3 bucket where the log files are to be stored.
    ///
    /// Constraints:
    ///
    /// * Must be in the same region as the cluster
    ///
    /// * The cluster must have read bucket and put object permissions
    bucket_name: ?[]const u8 = null,

    /// The identifier of the cluster on which logging is to be started.
    ///
    /// Example: `examplecluster`
    cluster_identifier: []const u8,

    /// The log destination type. An enum with possible values of `s3` and
    /// `cloudwatch`.
    log_destination_type: ?LogDestinationType = null,

    /// The collection of exported log types. Possible values are `connectionlog`,
    /// `useractivitylog`, and `userlog`.
    log_exports: ?[]const []const u8 = null,

    /// The prefix applied to the log file names.
    ///
    /// Valid characters are any letter from any language, any whitespace character,
    /// any numeric character, and the following characters:
    /// underscore (`_`), period (`.`), colon (`:`), slash (`/`), equal (`=`), plus
    /// (`+`), backslash (`\`),
    /// hyphen (`-`), at symbol (`@`).
    s3_key_prefix: ?[]const u8 = null,
};

pub const EnableLoggingOutput = struct {
    /// The name of the S3 bucket where the log files are stored.
    bucket_name: ?[]const u8 = null,

    /// The message indicating that logs failed to be delivered.
    last_failure_message: ?[]const u8 = null,

    /// The last time when logs failed to be delivered.
    last_failure_time: ?i64 = null,

    /// The last time that logs were delivered.
    last_successful_delivery_time: ?i64 = null,

    /// The log destination type. An enum with possible values of `s3` and
    /// `cloudwatch`.
    log_destination_type: ?LogDestinationType = null,

    /// The collection of exported log types. Possible values are `connectionlog`,
    /// `useractivitylog`, and
    /// `userlog`.
    log_exports: ?[]const []const u8 = null,

    /// `true` if logging is on, `false` if logging is off.
    logging_enabled: ?bool = null,

    /// The prefix applied to the log file names.
    s3_key_prefix: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableLoggingInput, options: CallOptions) !EnableLoggingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableLoggingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=EnableLogging&Version=2012-12-01");
    if (input.bucket_name) |v| {
        try body_buf.appendSlice(allocator, "&BucketName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.log_destination_type) |v| {
        try body_buf.appendSlice(allocator, "&LogDestinationType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.log_exports) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogExports.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.s3_key_prefix) |v| {
        try body_buf.appendSlice(allocator, "&S3KeyPrefix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableLoggingOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnableLoggingResult")) break;
            },
            else => {},
        }
    }

    var result: EnableLoggingOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BucketName")) {
                    result.bucket_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastFailureMessage")) {
                    result.last_failure_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastFailureTime")) {
                    result.last_failure_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LastSuccessfulDeliveryTime")) {
                    result.last_successful_delivery_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LogDestinationType")) {
                    result.log_destination_type = LogDestinationType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogExports")) {
                    result.log_exports = try serde.deserializeLogTypeList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "LoggingEnabled")) {
                    result.logging_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "S3KeyPrefix")) {
                    result.s3_key_prefix = try allocator.dupe(u8, try reader.readElementText());
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

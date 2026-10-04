const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActivityStreamMode = @import("activity_stream_mode.zig").ActivityStreamMode;
const ActivityStreamStatus = @import("activity_stream_status.zig").ActivityStreamStatus;

pub const StartActivityStreamInput = struct {
    /// Specifies whether or not the database activity stream is to start as soon as
    /// possible, regardless of the maintenance window for the database.
    apply_immediately: ?bool = null,

    /// Specifies whether the database activity stream includes engine-native audit
    /// fields. This option applies to an Oracle or Microsoft SQL Server DB
    /// instance. By default, no engine-native audit fields are included.
    engine_native_audit_fields_included: ?bool = null,

    /// The Amazon Web Services KMS key identifier for encrypting messages in the
    /// database activity stream. The Amazon Web Services KMS key identifier is the
    /// key ARN, key ID, alias ARN, or alias name for the KMS key.
    kms_key_id: []const u8,

    /// Specifies the mode of the database activity stream. Database events such as
    /// a change or access generate an activity stream event. The database session
    /// can handle these events either synchronously or asynchronously.
    mode: ActivityStreamMode,

    /// The Amazon Resource Name (ARN) of the DB cluster, for example,
    /// `arn:aws:rds:us-east-1:12345667890:cluster:das-cluster`.
    resource_arn: []const u8,
};

pub const StartActivityStreamOutput = struct {
    /// Indicates whether or not the database activity stream will start as soon as
    /// possible, regardless of the maintenance window for the database.
    apply_immediately: ?bool = null,

    /// Indicates whether engine-native audit fields are included in the database
    /// activity stream.
    engine_native_audit_fields_included: ?bool = null,

    /// The name of the Amazon Kinesis data stream to be used for the database
    /// activity stream.
    kinesis_stream_name: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier for encryption of messages in the
    /// database activity stream.
    kms_key_id: ?[]const u8 = null,

    /// The mode of the database activity stream.
    mode: ?ActivityStreamMode = null,

    /// The status of the database activity stream.
    status: ?ActivityStreamStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartActivityStreamInput, options: CallOptions) !StartActivityStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartActivityStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=StartActivityStream&Version=2014-10-31");
    if (input.apply_immediately) |v| {
        try body_buf.appendSlice(allocator, "&ApplyImmediately=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.engine_native_audit_fields_included) |v| {
        try body_buf.appendSlice(allocator, "&EngineNativeAuditFieldsIncluded=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&KmsKeyId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.kms_key_id);
    try body_buf.appendSlice(allocator, "&Mode=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.mode.wireName());
    try body_buf.appendSlice(allocator, "&ResourceArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartActivityStreamOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StartActivityStreamResult")) break;
            },
            else => {},
        }
    }

    var result: StartActivityStreamOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplyImmediately")) {
                    result.apply_immediately = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EngineNativeAuditFieldsIncluded")) {
                    result.engine_native_audit_fields_included = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KinesisStreamName")) {
                    result.kinesis_stream_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = ActivityStreamMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ActivityStreamStatus.fromWireName(try reader.readElementText());
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

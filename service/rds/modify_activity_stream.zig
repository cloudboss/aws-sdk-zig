const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditPolicyState = @import("audit_policy_state.zig").AuditPolicyState;
const ActivityStreamMode = @import("activity_stream_mode.zig").ActivityStreamMode;
const ActivityStreamPolicyStatus = @import("activity_stream_policy_status.zig").ActivityStreamPolicyStatus;
const ActivityStreamStatus = @import("activity_stream_status.zig").ActivityStreamStatus;

pub const ModifyActivityStreamInput = struct {
    /// The audit policy state. When a policy is unlocked, it is read/write. When it
    /// is locked, it is read-only. You can edit your audit policy only when the
    /// activity stream is unlocked or stopped.
    audit_policy_state: ?AuditPolicyState = null,

    /// The Amazon Resource Name (ARN) of the RDS for Oracle or Microsoft SQL Server
    /// DB instance. For example, `arn:aws:rds:us-east-1:12345667890:db:my-orcl-db`.
    resource_arn: ?[]const u8 = null,
};

pub const ModifyActivityStreamOutput = struct {
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

    /// The status of the modification to the policy state of the database activity
    /// stream.
    policy_status: ?ActivityStreamPolicyStatus = null,

    /// The status of the modification to the database activity stream.
    status: ?ActivityStreamStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyActivityStreamInput, options: CallOptions) !ModifyActivityStreamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyActivityStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyActivityStream&Version=2014-10-31");
    if (input.audit_policy_state) |v| {
        try body_buf.appendSlice(allocator, "&AuditPolicyState=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.resource_arn) |v| {
        try body_buf.appendSlice(allocator, "&ResourceArn=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyActivityStreamOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyActivityStreamResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyActivityStreamOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EngineNativeAuditFieldsIncluded")) {
                    result.engine_native_audit_fields_included = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KinesisStreamName")) {
                    result.kinesis_stream_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = ActivityStreamMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyStatus")) {
                    result.policy_status = ActivityStreamPolicyStatus.fromWireName(try reader.readElementText());
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

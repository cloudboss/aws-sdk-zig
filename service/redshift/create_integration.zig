const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const IntegrationError = @import("integration_error.zig").IntegrationError;
const ZeroETLIntegrationStatus = @import("zero_etl_integration_status.zig").ZeroETLIntegrationStatus;
const serde = @import("serde.zig");

pub const CreateIntegrationInput = struct {
    /// An optional set of non-secret key–value pairs that contains additional
    /// contextual
    /// information about the data. For more information, see [Encryption
    /// context](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context) in the *Amazon Web Services Key Management Service Developer
    /// Guide*.
    ///
    /// You can only include this parameter if you specify the `KMSKeyId` parameter.
    additional_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// A description of the integration.
    description: ?[]const u8 = null,

    /// The name of the integration.
    integration_name: []const u8,

    /// An Key Management Service (KMS) key identifier for the key to use to
    /// encrypt the integration. If you don't specify an encryption key, the default
    /// Amazon Web Services owned key is used.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the database to use as the source for
    /// replication.
    source_arn: []const u8,

    /// A list of tags.
    tag_list: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the Amazon Redshift data warehouse to use
    /// as the target for replication.
    target_arn: []const u8,
};

pub const CreateIntegrationOutput = @import("integration.zig").Integration;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntegrationInput, options: CallOptions) !CreateIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateIntegration&Version=2012-12-01");
    if (input.additional_encryption_context) |entries| {
        for (entries, 0..) |entry, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const key_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalEncryptionContext.entry.{d}.key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, key_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, entry.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const val_prefix = std.fmt.bufPrint(&prefix_buf, "&AdditionalEncryptionContext.entry.{d}.value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, val_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, entry.value);
            }
        }
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&IntegrationName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.integration_name);
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KMSKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SourceArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_arn);
    if (input.tag_list) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagList.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagList.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&TargetArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIntegrationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateIntegrationResult")) break;
            },
            else => {},
        }
    }

    var result: CreateIntegrationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalEncryptionContext")) {
                    result.additional_encryption_context = try serde.deserializeEncryptionContextMap(allocator, &reader, "entry");
                } else if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Errors")) {
                    result.errors = try serde.deserializeIntegrationErrorList(allocator, &reader, "IntegrationError");
                } else if (std.mem.eql(u8, e.local, "IntegrationArn")) {
                    result.integration_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IntegrationName")) {
                    result.integration_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KMSKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceArn")) {
                    result.source_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ZeroETLIntegrationStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try serde.deserializeTagList(allocator, &reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "TargetArn")) {
                    result.target_arn = try allocator.dupe(u8, try reader.readElementText());
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

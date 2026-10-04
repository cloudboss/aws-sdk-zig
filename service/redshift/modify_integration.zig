const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationError = @import("integration_error.zig").IntegrationError;
const ZeroETLIntegrationStatus = @import("zero_etl_integration_status.zig").ZeroETLIntegrationStatus;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const ModifyIntegrationInput = struct {
    /// A new description for the integration.
    description: ?[]const u8 = null,

    /// The unique identifier of the integration to modify.
    integration_arn: []const u8,

    /// A new name for the integration.
    integration_name: ?[]const u8 = null,
};

pub const ModifyIntegrationOutput = @import("integration.zig").Integration;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyIntegrationInput, options: CallOptions) !ModifyIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyIntegration&Version=2012-12-01");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&IntegrationArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.integration_arn);
    if (input.integration_name) |v| {
        try body_buf.appendSlice(allocator, "&IntegrationName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyIntegrationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyIntegrationResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyIntegrationOutput = .{};
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

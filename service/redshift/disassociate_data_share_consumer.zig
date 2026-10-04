const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataShareAssociation = @import("data_share_association.zig").DataShareAssociation;
const DataShareType = @import("data_share_type.zig").DataShareType;
const serde = @import("serde.zig");

pub const DisassociateDataShareConsumerInput = struct {
    /// The Amazon Resource Name (ARN) of the consumer namespace that association
    /// for
    /// the datashare is removed from.
    consumer_arn: ?[]const u8 = null,

    /// From a datashare consumer account, removes association of a datashare from
    /// all the existing and future namespaces in the specified Amazon Web Services
    /// Region.
    consumer_region: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the datashare to remove association for.
    data_share_arn: []const u8,

    /// A value that specifies whether association for the datashare is removed from
    /// the
    /// entire account.
    disassociate_entire_account: ?bool = null,
};

pub const DisassociateDataShareConsumerOutput = @import("data_share.zig").DataShare;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateDataShareConsumerInput, options: CallOptions) !DisassociateDataShareConsumerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateDataShareConsumerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DisassociateDataShareConsumer&Version=2012-12-01");
    if (input.consumer_arn) |v| {
        try body_buf.appendSlice(allocator, "&ConsumerArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.consumer_region) |v| {
        try body_buf.appendSlice(allocator, "&ConsumerRegion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DataShareArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.data_share_arn);
    if (input.disassociate_entire_account) |v| {
        try body_buf.appendSlice(allocator, "&DisassociateEntireAccount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateDataShareConsumerOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DisassociateDataShareConsumerResult")) break;
            },
            else => {},
        }
    }

    var result: DisassociateDataShareConsumerOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowPubliclyAccessibleConsumers")) {
                    result.allow_publicly_accessible_consumers = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DataShareArn")) {
                    result.data_share_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataShareAssociations")) {
                    result.data_share_associations = try serde.deserializeDataShareAssociationList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "DataShareType")) {
                    result.data_share_type = DataShareType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ManagedBy")) {
                    result.managed_by = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProducerArn")) {
                    result.producer_arn = try allocator.dupe(u8, try reader.readElementText());
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

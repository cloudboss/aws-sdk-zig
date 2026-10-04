const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const ListTagsForResourceInput = struct {
    /// The ARN of the CloudWatch resource that you want to view tags for.
    ///
    /// The ARN format of an alarm is
    /// `arn:aws:cloudwatch:*Region*:*account-id*:alarm:*alarm-name*
    /// `
    ///
    /// The ARN format of a Contributor Insights rule is
    /// `arn:aws:cloudwatch:*Region*:*account-id*:insight-rule/*insight-rule-name*
    /// `
    ///
    /// The ARN format of a dashboard is
    /// `arn:aws:cloudwatch::*account-id*:dashboard/*dashboard-name*
    /// `
    ///
    /// The ARN format of a metric stream is
    /// `arn:aws:cloudwatch:*Region*:*account-id*:metric-stream/*metric-stream-name*
    /// `
    ///
    /// For more information about ARN format, see [ Resource Types Defined by
    /// Amazon
    /// CloudWatch](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatch.html#amazoncloudwatch-resources-for-iam-policies) in the *Amazon Web
    /// Services General Reference*.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};

pub const ListTagsForResourceOutput = struct {
    /// The list of tag keys and values associated with the resource you specified.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTagsForResourceInput, options: CallOptions) !ListTagsForResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTagsForResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListTagsForResource&Version=2010-08-01");
    try body_buf.appendSlice(allocator, "&ResourceARN=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTagsForResourceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListTagsForResourceResult")) break;
            },
            else => {},
        }
    }

    var result: ListTagsForResourceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try serde.deserializeTagList(allocator, &reader, "member");
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

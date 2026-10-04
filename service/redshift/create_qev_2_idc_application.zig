const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Qev2IdcApplication = @import("qev_2_idc_application.zig").Qev2IdcApplication;
const serde = @import("serde.zig");

pub const CreateQev2IdcApplicationInput = struct {
    /// The display name for the Amazon Redshift Query Editor (QEV2) IAM Identity
    /// Center application. It appears in the console.
    idc_display_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center instance used to
    /// create the Amazon Redshift Query Editor (QEV2) managed application.
    idc_instance_arn: []const u8,

    /// The name of the Amazon Redshift Query Editor (QEV2) application in IAM
    /// Identity Center.
    qev_2_idc_application_name: []const u8,

    /// A list of tags to associate with the application. Tags are key-value pairs
    /// that you can use to organize and identify your resources.
    tags: ?[]const Tag = null,
};

pub const CreateQev2IdcApplicationOutput = struct {
    qev_2_idc_application: ?Qev2IdcApplication = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQev2IdcApplicationInput, options: CallOptions) !CreateQev2IdcApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQev2IdcApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateQev2IdcApplication&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&IdcDisplayName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.idc_display_name);
    try body_buf.appendSlice(allocator, "&IdcInstanceArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.idc_instance_arn);
    try body_buf.appendSlice(allocator, "&Qev2IdcApplicationName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.qev_2_idc_application_name);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQev2IdcApplicationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateQev2IdcApplicationResult")) break;
            },
            else => {},
        }
    }

    var result: CreateQev2IdcApplicationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Qev2IdcApplication")) {
                    result.qev_2_idc_application = try serde.deserializeQev2IdcApplication(allocator, &reader);
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

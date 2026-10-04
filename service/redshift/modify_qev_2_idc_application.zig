const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Qev2IdcApplication = @import("qev_2_idc_application.zig").Qev2IdcApplication;
const serde = @import("serde.zig");

pub const ModifyQev2IdcApplicationInput = struct {
    /// The display name for the Amazon Redshift Query Editor (QEV2) IAM Identity
    /// Center application. It appears in the console.
    idc_display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the Amazon Redshift Query Editor (QEV2)
    /// application that integrates with IAM Identity Center.
    qev_2_idc_application_arn: []const u8,
};

pub const ModifyQev2IdcApplicationOutput = struct {
    qev_2_idc_application: ?Qev2IdcApplication = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyQev2IdcApplicationInput, options: CallOptions) !ModifyQev2IdcApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyQev2IdcApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyQev2IdcApplication&Version=2012-12-01");
    if (input.idc_display_name) |v| {
        try body_buf.appendSlice(allocator, "&IdcDisplayName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Qev2IdcApplicationArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.qev_2_idc_application_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyQev2IdcApplicationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyQev2IdcApplicationResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyQev2IdcApplicationOutput = .{};
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

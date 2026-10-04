const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplateMetadata = @import("template_metadata.zig").TemplateMetadata;
const serde = @import("serde.zig");

pub const ListTemplatesInput = struct {
    /// The maximum number of templates to return. This value must be at least 1 and
    /// less than
    /// or equal to 100. If more than 100 items are requested, the page size will
    /// automatically
    /// set to 100. If you do not specify a value, 10 is the default page size.
    max_items: ?i32 = null,

    /// A token returned from a previous call to `ListTemplates` to indicate the
    /// position in the list of email templates.
    next_token: ?[]const u8 = null,
};

pub const ListTemplatesOutput = struct {
    /// A token indicating that there are additional email templates available to be
    /// listed.
    /// Pass this token to a subsequent call to `ListTemplates` to retrieve the next
    /// set of email templates within your page size.
    next_token: ?[]const u8 = null,

    /// An array the contains the name and creation time stamp for each template in
    /// your Amazon SES
    /// account.
    templates_metadata: ?[]const TemplateMetadata = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTemplatesInput, options: CallOptions) !ListTemplatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTemplatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListTemplates&Version=2010-12-01");
    if (input.max_items) |v| {
        try body_buf.appendSlice(allocator, "&MaxItems=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTemplatesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListTemplatesResult")) break;
            },
            else => {},
        }
    }

    var result: ListTemplatesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplatesMetadata")) {
                    result.templates_metadata = try serde.deserializeTemplateMetadataList(allocator, &reader, "member");
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

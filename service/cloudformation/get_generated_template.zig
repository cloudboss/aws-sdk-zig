const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplateFormat = @import("template_format.zig").TemplateFormat;
const GeneratedTemplateStatus = @import("generated_template_status.zig").GeneratedTemplateStatus;

pub const GetGeneratedTemplateInput = struct {
    /// The language to use to retrieve for the generated template. Supported values
    /// are:
    ///
    /// * `JSON`
    ///
    /// * `YAML`
    format: ?TemplateFormat = null,

    /// The name or Amazon Resource Name (ARN) of the generated template. The format
    /// is
    /// `arn:${Partition}:cloudformation:${Region}:${Account}:generatedtemplate/${Id}`.
    /// For example,
    /// `arn:aws:cloudformation:*us-east-1*:*123456789012*:generatedtemplate/*2e8465c1-9a80-43ea-a3a3-4f2d692fe6dc*
    /// `.
    generated_template_name: []const u8,
};

pub const GetGeneratedTemplateOutput = struct {
    /// The status of the template generation. Supported values are:
    ///
    /// * `CreatePending` - the creation of the template is pending.
    ///
    /// * `CreateInProgress` - the creation of the template is in progress.
    ///
    /// * `DeletePending` - the deletion of the template is pending.
    ///
    /// * `DeleteInProgress` - the deletion of the template is in progress.
    ///
    /// * `UpdatePending` - the update of the template is pending.
    ///
    /// * `UpdateInProgress` - the update of the template is in progress.
    ///
    /// * `Failed` - the template operation failed.
    ///
    /// * `Complete` - the template operation is complete.
    status: ?GeneratedTemplateStatus = null,

    /// The template body of the generated template, in the language specified by
    /// the
    /// `Language` parameter.
    template_body: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGeneratedTemplateInput, options: CallOptions) !GetGeneratedTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGeneratedTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetGeneratedTemplate&Version=2010-05-15");
    if (input.format) |v| {
        try body_buf.appendSlice(allocator, "&Format=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&GeneratedTemplateName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.generated_template_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGeneratedTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetGeneratedTemplateResult")) break;
            },
            else => {},
        }
    }

    var result: GetGeneratedTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = GeneratedTemplateStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateBody")) {
                    result.template_body = try allocator.dupe(u8, try reader.readElementText());
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

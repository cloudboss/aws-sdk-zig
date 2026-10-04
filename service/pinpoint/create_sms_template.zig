const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SMSTemplateRequest = @import("sms_template_request.zig").SMSTemplateRequest;
const CreateTemplateMessageBody = @import("create_template_message_body.zig").CreateTemplateMessageBody;

pub const CreateSmsTemplateInput = struct {
    sms_template_request: SMSTemplateRequest,

    /// The name of the message template. A template name must start with an
    /// alphanumeric character and can contain a maximum of 128 characters. The
    /// characters can be alphanumeric characters, underscores (_), or hyphens (-).
    /// Template names are case sensitive.
    template_name: []const u8,

    pub const json_field_names = .{
        .sms_template_request = "SMSTemplateRequest",
        .template_name = "TemplateName",
    };
};

pub const CreateSmsTemplateOutput = struct {
    create_template_message_body: ?CreateTemplateMessageBody = null,

    pub const json_field_names = .{
        .create_template_message_body = "CreateTemplateMessageBody",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSmsTemplateInput, options: CallOptions) !CreateSmsTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mobiletargeting", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSmsTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/templates/");
    try path_buf.appendSlice(allocator, input.template_name);
    try path_buf.appendSlice(allocator, "/sms");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.sms_template_request, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSmsTemplateOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateSmsTemplateOutput = .{};

    return result;
}

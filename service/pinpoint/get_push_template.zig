const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PushNotificationTemplateResponse = @import("push_notification_template_response.zig").PushNotificationTemplateResponse;

pub const GetPushTemplateInput = struct {
    /// The name of the message template. A template name must start with an
    /// alphanumeric character and can contain a maximum of 128 characters. The
    /// characters can be alphanumeric characters, underscores (_), or hyphens (-).
    /// Template names are case sensitive.
    template_name: []const u8,

    /// The unique identifier for the version of the message template to update,
    /// retrieve information about, or delete. To retrieve identifiers and other
    /// information for all the versions of a template, use the Template Versions
    /// resource.
    ///
    /// If specified, this value must match the identifier for an existing template
    /// version. If specified for an update operation, this value must match the
    /// identifier for the latest existing version of the template. This restriction
    /// helps ensure that race conditions don't occur.
    ///
    /// If you don't specify a value for this parameter, Amazon Pinpoint does the
    /// following:
    ///
    /// * For a get operation, retrieves information about the active version of the
    ///   template.
    /// * For an update operation, saves the updates to (overwrites) the latest
    ///   existing version of the template, if the create-new-version parameter
    ///   isn't used or is set to false.
    /// * For a delete operation, deletes the template, including all versions of
    ///   the template.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .template_name = "TemplateName",
        .version = "Version",
    };
};

pub const GetPushTemplateOutput = struct {
    push_notification_template_response: ?PushNotificationTemplateResponse = null,

    pub const json_field_names = .{
        .push_notification_template_response = "PushNotificationTemplateResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPushTemplateInput, options: CallOptions) !GetPushTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPushTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/templates/");
    try path_buf.appendSlice(allocator, input.template_name);
    try path_buf.appendSlice(allocator, "/push");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPushTemplateOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: GetPushTemplateOutput = .{};

    return result;
}

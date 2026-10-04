const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessControlEntry = @import("access_control_entry.zig").AccessControlEntry;

pub const GetTemplateGroupAccessControlEntryInput = struct {
    /// Security identifier (SID) of the group object from Active Directory. The SID
    /// starts with
    /// "S-".
    group_security_identifier: []const u8,

    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateTemplate](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateTemplate.html).
    template_arn: []const u8,

    pub const json_field_names = .{
        .group_security_identifier = "GroupSecurityIdentifier",
        .template_arn = "TemplateArn",
    };
};

pub const GetTemplateGroupAccessControlEntryOutput = struct {
    /// An access control entry allows or denies an Active Directory group from
    /// enrolling and/or
    /// autoenrolling with a template.
    access_control_entry: ?AccessControlEntry = null,

    pub const json_field_names = .{
        .access_control_entry = "AccessControlEntry",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTemplateGroupAccessControlEntryInput, options: CallOptions) !GetTemplateGroupAccessControlEntryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pca-connector-ad", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTemplateGroupAccessControlEntryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pca-connector-ad", "Pca Connector Ad", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/templates/");
    try path_buf.appendSlice(allocator, input.template_arn);
    try path_buf.appendSlice(allocator, "/accessControlEntries/");
    try path_buf.appendSlice(allocator, input.group_security_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTemplateGroupAccessControlEntryOutput {
    const result: GetTemplateGroupAccessControlEntryOutput = try aws.json.parseJsonObject(
        GetTemplateGroupAccessControlEntryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

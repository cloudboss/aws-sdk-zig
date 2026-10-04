const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrivacyBudgetTemplate = @import("privacy_budget_template.zig").PrivacyBudgetTemplate;

pub const GetPrivacyBudgetTemplateInput = struct {
    /// A unique identifier for one of your memberships for a collaboration. The
    /// privacy budget template is retrieved from the collaboration that this
    /// membership belongs to. Accepts a membership ID.
    membership_identifier: []const u8,

    /// A unique identifier for your privacy budget template.
    privacy_budget_template_identifier: []const u8,

    pub const json_field_names = .{
        .membership_identifier = "membershipIdentifier",
        .privacy_budget_template_identifier = "privacyBudgetTemplateIdentifier",
    };
};

pub const GetPrivacyBudgetTemplateOutput = struct {
    /// Returns the details of the privacy budget template that you requested.
    privacy_budget_template: ?PrivacyBudgetTemplate = null,

    pub const json_field_names = .{
        .privacy_budget_template = "privacyBudgetTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPrivacyBudgetTemplateInput, options: CallOptions) !GetPrivacyBudgetTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPrivacyBudgetTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/privacybudgettemplates/");
    try path_buf.appendSlice(allocator, input.privacy_budget_template_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPrivacyBudgetTemplateOutput {
    const result: GetPrivacyBudgetTemplateOutput = try aws.json.parseJsonObject(
        GetPrivacyBudgetTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

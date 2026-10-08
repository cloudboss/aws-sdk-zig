const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AcceptCodeValidation = @import("accept_code_validation.zig").AcceptCodeValidation;
const AcceptType = @import("accept_type.zig").AcceptType;

pub const AcceptPageInput = struct {
    /// A 6-digit code used to acknowledge the page.
    accept_code: []const u8,

    /// An optional field that Incident Manager uses to `ENFORCE`
    /// `AcceptCode` validation when acknowledging an page. Acknowledgement can
    /// occur by
    /// replying to a page, or when entering the AcceptCode in the console.
    /// Enforcing AcceptCode
    /// validation causes Incident Manager to verify that the code entered by the
    /// user matches the
    /// code sent by Incident Manager with the page.
    ///
    /// Incident Manager can also `IGNORE`
    /// `AcceptCode` validation. Ignoring `AcceptCode` validation causes
    /// Incident Manager to accept any value entered for the `AcceptCode`.
    accept_code_validation: ?AcceptCodeValidation = null,

    /// The type indicates if the page was `DELIVERED` or `READ`.
    accept_type: AcceptType,

    /// The ARN of the contact channel.
    contact_channel_id: ?[]const u8 = null,

    /// Information provided by the user when the user acknowledges the page.
    note: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the engagement to a contact channel.
    page_id: []const u8,

    pub const json_field_names = .{
        .accept_code = "AcceptCode",
        .accept_code_validation = "AcceptCodeValidation",
        .accept_type = "AcceptType",
        .contact_channel_id = "ContactChannelId",
        .note = "Note",
        .page_id = "PageId",
    };
};

pub const AcceptPageOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptPageInput, options: CallOptions) !AcceptPageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-contacts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptPageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-contacts", "SSM Contacts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.AcceptPage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptPageOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

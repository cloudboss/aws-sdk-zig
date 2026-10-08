const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Permit = @import("permit.zig").Permit;
const SigningKeyInfo = @import("signing_key_info.zig").SigningKeyInfo;
const SupportPermitStatus = @import("support_permit_status.zig").SupportPermitStatus;

pub const GetSupportPermitInput = struct {
    /// The ARN or name of the support permit to retrieve.
    support_permit_identifier: []const u8,

    pub const json_field_names = .{
        .support_permit_identifier = "supportPermitIdentifier",
    };
};

pub const GetSupportPermitOutput = struct {
    /// The ARN of the support permit.
    arn: []const u8,

    /// The timestamp when the permit was created.
    created_at: i64,

    /// The description of the support permit.
    description: ?[]const u8 = null,

    /// The name of the support permit.
    name: []const u8,

    /// The permit definition.
    permit: ?Permit = null,

    /// The signing key information for the permit.
    signing_key_info: ?SigningKeyInfo = null,

    /// The current status of the support permit.
    status: SupportPermitStatus,

    /// The display identifier of the support case associated with the permit.
    support_case_display_id: ?[]const u8 = null,

    /// The tags associated with the support permit.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .permit = "permit",
        .signing_key_info = "signingKeyInfo",
        .status = "status",
        .support_case_display_id = "supportCaseDisplayId",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSupportPermitInput, options: CallOptions) !GetSupportPermitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "supportauthz", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSupportPermitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("supportauthz", "SupportAuthZ", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/support-permits/");
    try path_buf.appendSlice(allocator, input.support_permit_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSupportPermitOutput {
    const result: GetSupportPermitOutput = try aws.json.parseJsonObject(
        GetSupportPermitOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

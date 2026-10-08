const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserDesignation = @import("user_designation.zig").UserDesignation;
const Member = @import("member.zig").Member;

pub const CreateProjectMembershipInput = struct {
    /// The designation of the project membership.
    designation: UserDesignation,

    /// The ID of the Amazon DataZone domain in which project membership is created.
    domain_identifier: []const u8,

    /// The project member whose project membership was created.
    member: Member,

    /// The ID of the project for which this project membership was created.
    project_identifier: []const u8,

    pub const json_field_names = .{
        .designation = "designation",
        .domain_identifier = "domainIdentifier",
        .member = "member",
        .project_identifier = "projectIdentifier",
    };
};

pub const CreateProjectMembershipOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProjectMembershipInput, options: CallOptions) !CreateProjectMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProjectMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project_identifier);
    try path_buf.appendSlice(allocator, "/createMembership");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"designation\":");
    try aws.json.writeValue(@TypeOf(input.designation), input.designation, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"member\":");
    try aws.json.writeValue(@TypeOf(input.member), input.member, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProjectMembershipOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateProjectMembershipOutput = .{};

    return result;
}

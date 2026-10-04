const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupMembers = @import("group_members.zig").GroupMembers;
const MembershipType = @import("membership_type.zig").MembershipType;

pub const PutGroupInput = struct {
    /// The identifier of the application in which the user and group mapping
    /// belongs.
    application_id: []const u8,

    /// The identifier of the data source for which you want to map users to their
    /// groups. This is useful if a group is tied to multiple data sources, but you
    /// only want the group to access documents of a certain data source. For
    /// example, the groups "Research", "Engineering", and "Sales and Marketing" are
    /// all tied to the company's documents stored in the data sources Confluence
    /// and Salesforce. However, "Sales and Marketing" team only needs access to
    /// customer-related documents stored in Salesforce.
    data_source_id: ?[]const u8 = null,

    group_members: GroupMembers,

    /// The list that contains your users or sub groups that belong the same group.
    /// For example, the group "Company" includes the user "CEO" and the sub groups
    /// "Research", "Engineering", and "Sales and Marketing".
    group_name: []const u8,

    /// The identifier of the index in which you want to map users to their groups.
    index_id: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role that has access to the S3 file
    /// that contains your list of users that belong to a group.
    role_arn: ?[]const u8 = null,

    /// The type of the group.
    @"type": MembershipType,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_id = "dataSourceId",
        .group_members = "groupMembers",
        .group_name = "groupName",
        .index_id = "indexId",
        .role_arn = "roleArn",
        .@"type" = "type",
    };
};

pub const PutGroupOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutGroupInput, options: CallOptions) !PutGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_id);
    try path_buf.appendSlice(allocator, "/groups");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_source_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataSourceId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"groupMembers\":");
    try aws.json.writeValue(@TypeOf(input.group_members), input.group_members, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"groupName\":");
    try aws.json.writeValue(@TypeOf(input.group_name), input.group_name, allocator, &body_buf);
    has_prev = true;
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutGroupOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutGroupOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberType = @import("member_type.zig").MemberType;
const FolderMember = @import("folder_member.zig").FolderMember;

pub const CreateFolderMembershipInput = struct {
    /// The ID for the Amazon Web Services account that contains the folder.
    aws_account_id: []const u8,

    /// The ID of the folder.
    folder_id: []const u8,

    /// The ID of the asset that you want to add to the folder.
    member_id: []const u8,

    /// The member type of the asset that you want to add to a folder.
    member_type: MemberType,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .folder_id = "FolderId",
        .member_id = "MemberId",
        .member_type = "MemberType",
    };
};

pub const CreateFolderMembershipOutput = struct {
    /// Information about the member in the folder.
    folder_member: ?FolderMember = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .folder_member = "FolderMember",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFolderMembershipInput, options: CallOptions) !CreateFolderMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFolderMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/folders/");
    try path_buf.appendSlice(allocator, input.folder_id);
    try path_buf.appendSlice(allocator, "/members/");
    try path_buf.appendSlice(allocator, input.member_type.wireName());
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.member_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFolderMembershipOutput {
    const result: CreateFolderMembershipOutput = try aws.json.parseJsonObject(
        CreateFolderMembershipOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

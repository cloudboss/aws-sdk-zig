const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const UserStackAssociation = @import("user_stack_association.zig").UserStackAssociation;

pub const DescribeUserStackAssociationsInput = struct {
    /// The authentication type for the user who is associated with the stack. You
    /// must specify USERPOOL.
    authentication_type: ?AuthenticationType = null,

    /// The maximum size of each page of results.
    max_results: ?i32 = null,

    /// The pagination token to use to retrieve the next page of results for this
    /// operation. If this value is null, it retrieves the first page.
    next_token: ?[]const u8 = null,

    /// The name of the stack that is associated with the user.
    stack_name: ?[]const u8 = null,

    /// The email address of the user who is associated with the stack.
    ///
    /// Users' email addresses are case-sensitive.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .stack_name = "StackName",
        .user_name = "UserName",
    };
};

pub const DescribeUserStackAssociationsOutput = struct {
    /// The pagination token to use to retrieve the next page of results for this
    /// operation. If there are no more pages, this value is null.
    next_token: ?[]const u8 = null,

    /// The UserStackAssociation objects.
    user_stack_associations: ?[]const UserStackAssociation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .user_stack_associations = "UserStackAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUserStackAssociationsInput, options: CallOptions) !DescribeUserStackAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUserStackAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.DescribeUserStackAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUserStackAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeUserStackAssociationsOutput, body, allocator);
}

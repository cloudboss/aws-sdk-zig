const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Identity = @import("identity.zig").Identity;
const Permission = @import("permission.zig").Permission;
const Resource = @import("resource.zig").Resource;

pub const DescribeAccessPolicyInput = struct {
    /// The ID of the access policy.
    access_policy_id: []const u8,

    pub const json_field_names = .{
        .access_policy_id = "accessPolicyId",
    };
};

pub const DescribeAccessPolicyOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the access policy, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:access-policy/${AccessPolicyId}`
    access_policy_arn: []const u8,

    /// The date the access policy was created, in Unix epoch time.
    access_policy_creation_date: i64,

    /// The ID of the access policy.
    access_policy_id: []const u8,

    /// The identity (IAM Identity Center user, IAM Identity Center group, or IAM
    /// user) to which this access policy
    /// applies.
    access_policy_identity: ?Identity = null,

    /// The date the access policy was last updated, in Unix epoch time.
    access_policy_last_update_date: i64,

    /// The access policy permission. Note that a project `ADMINISTRATOR` is also
    /// known
    /// as a project owner.
    access_policy_permission: Permission,

    /// The IoT SiteWise Monitor resource (portal or project) to which this access
    /// policy provides
    /// access.
    access_policy_resource: ?Resource = null,

    pub const json_field_names = .{
        .access_policy_arn = "accessPolicyArn",
        .access_policy_creation_date = "accessPolicyCreationDate",
        .access_policy_id = "accessPolicyId",
        .access_policy_identity = "accessPolicyIdentity",
        .access_policy_last_update_date = "accessPolicyLastUpdateDate",
        .access_policy_permission = "accessPolicyPermission",
        .access_policy_resource = "accessPolicyResource",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccessPolicyInput, options: CallOptions) !DescribeAccessPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccessPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/access-policies/");
    try path_buf.appendSlice(allocator, input.access_policy_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccessPolicyOutput {
    const result: DescribeAccessPolicyOutput = try aws.json.parseJsonObject(
        DescribeAccessPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

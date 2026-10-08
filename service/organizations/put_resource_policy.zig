const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const PutResourcePolicyInput = struct {
    /// If provided, the new content for the resource policy. The text must be
    /// correctly
    /// formatted JSON that complies with the syntax for the resource policy's type.
    /// For more
    /// information, see [SCP
    /// syntax](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_syntax.html) in the
    /// *Organizations User Guide*.
    content: []const u8,

    /// A list of tags that you want to attach to the newly created resource policy.
    /// For each
    /// tag in the list, you must specify both a tag key and a value. You can set
    /// the value to
    /// an empty string, but you can't set it to `null`. For more information about
    /// tagging, see [Tagging
    /// Organizations
    /// resources](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tagging.html) in the Organizations User Guide.
    ///
    /// Calls with tags apply to the initial creation of the resource policy,
    /// otherwise an
    /// exception is thrown. If any one of the tags is not valid or if you exceed
    /// the
    /// allowed number of tags for the resource policy, then the entire request
    /// fails and
    /// the resource policy is not created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .content = "Content",
        .tags = "Tags",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// A structure that contains details about the resource policy.
    resource_policy: ?ResourcePolicy = null,

    pub const json_field_names = .{
        .resource_policy = "ResourcePolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.PutResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutResourcePolicyOutput, body, allocator);
}

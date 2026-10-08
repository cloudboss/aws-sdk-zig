const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateManagedInstanceRoleInput = struct {
    /// The name of the Identity and Access Management (IAM) role that you want to
    /// assign to
    /// the managed node. This IAM role must provide AssumeRole permissions for the
    /// Amazon Web Services Systems Manager service principal `ssm.amazonaws.com`.
    /// For more information, see [Create the IAM service role required for Systems
    /// Manager in hybrid and multicloud
    /// environments](https://docs.aws.amazon.com/systems-manager/latest/userguide/hybrid-multicloud-service-role.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// You can't specify an IAM service-linked role for this parameter. You must
    /// create a unique role.
    iam_role: []const u8,

    /// The ID of the managed node where you want to update the role.
    instance_id: []const u8,

    pub const json_field_names = .{
        .iam_role = "IamRole",
        .instance_id = "InstanceId",
    };
};

pub const UpdateManagedInstanceRoleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateManagedInstanceRoleInput, options: CallOptions) !UpdateManagedInstanceRoleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateManagedInstanceRoleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateManagedInstanceRole");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateManagedInstanceRoleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

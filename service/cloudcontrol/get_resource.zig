const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceDescription = @import("resource_description.zig").ResourceDescription;

pub const GetResourceInput = struct {
    /// The identifier for the resource.
    ///
    /// You can specify the primary identifier, or any secondary identifier
    /// defined for the resource type in its resource schema. You can only specify
    /// one identifier. Primary identifiers can be specified as a string or JSON;
    /// secondary identifiers must be specified as JSON.
    ///
    /// For compound primary identifiers (that is, one that consists of
    /// multiple resource properties strung together), to specify the primary
    /// identifier as a string, list the property values *in the order
    /// they are specified* in the primary identifier definition,
    /// separated by `|`.
    ///
    /// For more information, see [Identifying
    /// resources](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-identifier.html) in the *Amazon Web Services Cloud Control API User Guide*.
    identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management
    /// (IAM) role for Cloud Control API to use when performing this resource
    /// operation. The role specified must have the permissions required for this
    /// operation. The necessary permissions for each event handler are defined in
    /// the
    /// `
    /// [handlers](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html#schema-properties-handlers)
    /// `
    /// section of the [resource type
    /// definition
    /// schema](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html).
    ///
    /// If you do not specify a role, Cloud Control API uses a temporary session
    /// created using
    /// your Amazon Web Services user credentials.
    ///
    /// For more information, see [Specifying
    /// credentials](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations.html#resource-operations-permissions) in the *Amazon Web Services Cloud Control API User Guide*.
    role_arn: ?[]const u8 = null,

    /// The name of the resource type.
    type_name: []const u8,

    /// For private resource types, the type version to use in this resource
    /// operation. If you do not specify a resource version, CloudFormation
    /// uses the default version.
    type_version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .role_arn = "RoleArn",
        .type_name = "TypeName",
        .type_version_id = "TypeVersionId",
    };
};

pub const GetResourceOutput = struct {
    resource_description: ?ResourceDescription = null,

    /// The name of the resource type.
    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_description = "ResourceDescription",
        .type_name = "TypeName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceInput, options: CallOptions) !GetResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudapiservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudcontrolapi", "CloudControl", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CloudApiService.GetResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourceOutput, body, allocator);
}

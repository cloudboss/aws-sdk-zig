const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceDescription = @import("resource_description.zig").ResourceDescription;

pub const ListResourcesInput = struct {
    /// Reserved.
    max_results: ?i32 = null,

    /// If the previous paginated request didn't return all of the remaining
    /// results,
    /// the response object's `NextToken` parameter value is set to a token.
    /// To retrieve the next set of results, call this action again and assign that
    /// token to
    /// the request object's `NextToken` parameter. If there are no remaining
    /// results, the previous response object's `NextToken` parameter is set to
    /// `null`.
    next_token: ?[]const u8 = null,

    /// The resource model to use to select the resources to return.
    resource_model: ?[]const u8 = null,

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
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_model = "ResourceModel",
        .role_arn = "RoleArn",
        .type_name = "TypeName",
        .type_version_id = "TypeVersionId",
    };
};

pub const ListResourcesOutput = struct {
    /// If the request doesn't return all of the remaining results,
    /// `NextToken` is set to a token. To retrieve the next set of results, call
    /// `ListResources` again and assign that token to the request object's
    /// `NextToken` parameter. If the request returns all results,
    /// `NextToken` is set to null.
    next_token: ?[]const u8 = null,

    /// Information about the specified resources, including primary identifier and
    /// resource
    /// model.
    resource_descriptions: ?[]const ResourceDescription = null,

    /// The name of the resource type.
    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_descriptions = "ResourceDescriptions",
        .type_name = "TypeName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourcesInput, options: CallOptions) !ListResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourcesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudApiService.ListResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResourcesOutput, body, allocator);
}

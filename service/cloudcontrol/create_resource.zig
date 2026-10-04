const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProgressEvent = @import("progress_event.zig").ProgressEvent;

pub const CreateResourceInput = struct {
    /// A unique identifier to ensure the idempotency of the resource request. As a
    /// best practice, specify this token to ensure idempotency, so that Amazon Web
    /// Services Cloud Control API can
    /// accurately distinguish between request retries and new resource requests.
    /// You
    /// might retry a resource request to ensure that it was successfully received.
    ///
    /// A client token is valid for 36 hours once used. After that, a resource
    /// request with the same client token is treated as a new request.
    ///
    /// If you
    /// do not specify a client token, one is generated for inclusion in the
    /// request.
    ///
    /// For more information, see [Ensuring
    /// resource operation requests are
    /// unique](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations.html#resource-operations-idempotency) in the *Amazon Web Services Cloud Control API User
    /// Guide*.
    client_token: ?[]const u8 = null,

    /// Structured data format representing the desired state of the resource,
    /// consisting of that
    /// resource's properties and their desired values.
    ///
    /// Cloud Control API currently supports JSON as a structured data format.
    ///
    /// Specify the desired state as one of the following:
    ///
    /// * A JSON blob
    ///
    /// * A local path containing the desired state in JSON data format
    ///
    /// For more information, see [Composing the desired state of the
    /// resource](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-create.html#resource-operations-create-desiredstate) in the *Amazon Web Services Cloud Control API User
    /// Guide*.
    ///
    /// For more information about the properties of a specific resource, refer to
    /// the related
    /// topic for the resource in the [Resource and property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *CloudFormation Users Guide*.
    desired_state: []const u8,

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
        .client_token = "ClientToken",
        .desired_state = "DesiredState",
        .role_arn = "RoleArn",
        .type_name = "TypeName",
        .type_version_id = "TypeVersionId",
    };
};

pub const CreateResourceOutput = struct {
    /// Represents the current status of the resource creation request.
    ///
    /// After you have initiated a resource creation request, you can monitor the
    /// progress of your
    /// request by calling
    /// [GetResourceRequestStatus](https://docs.aws.amazon.com/cloudcontrolapi/latest/APIReference/API_GetResourceRequestStatus.html) using the `RequestToken` of the
    /// `ProgressEvent` returned by `CreateResource`.
    progress_event: ?ProgressEvent = null,

    pub const json_field_names = .{
        .progress_event = "ProgressEvent",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceInput, options: CallOptions) !CreateResourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudApiService.CreateResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateResourceOutput, body, allocator);
}

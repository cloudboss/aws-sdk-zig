const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const PutDraftAppVersionTemplateInput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// A JSON string that provides information about your application structure. To
    /// learn more
    /// about the `appTemplateBody` template, see the sample template provided in
    /// the
    /// *Examples* section.
    ///
    /// The `appTemplateBody` JSON string has the following structure:
    ///
    /// * **
    /// `resources`
    /// **
    ///
    /// The list of logical resources that must be included in the Resilience Hub
    /// application.
    ///
    /// Type: Array
    ///
    /// Don't add the resources that you want to exclude.
    ///
    /// Each `resources` array item includes the following fields:
    ///
    /// * *
    /// `logicalResourceId`
    /// *
    ///
    /// Logical identifier of the resource.
    ///
    /// Type: Object
    ///
    /// Each `logicalResourceId` object includes the following fields:
    ///
    /// * `identifier`
    ///
    /// Identifier of the resource.
    ///
    /// Type: String
    ///
    /// * `logicalStackName`
    ///
    /// The name of the CloudFormation stack this resource belongs to.
    ///
    /// Type: String
    ///
    /// * `resourceGroupName`
    ///
    /// The name of the resource group this resource belongs to.
    ///
    /// Type: String
    ///
    /// * `terraformSourceName`
    ///
    /// The name of the Terraform S3 state file this resource belongs to.
    ///
    /// Type: String
    ///
    /// * `eksSourceName`
    ///
    /// Name of the Amazon Elastic Kubernetes Service cluster and namespace this
    /// resource belongs to.
    ///
    /// This parameter accepts values in "eks-cluster/namespace" format.
    ///
    /// Type: String
    ///
    /// * *
    /// `type`
    /// *
    ///
    /// The type of resource.
    ///
    /// Type: string
    ///
    /// * *
    /// `name`
    /// *
    ///
    /// The name of the resource.
    ///
    /// Type: String
    ///
    /// * `additionalInfo`
    ///
    /// Additional configuration parameters for an Resilience Hub application. If
    /// you want to implement `additionalInfo` through the Resilience Hub console
    /// rather than using an API call, see [Configure the application configuration
    /// parameters](https://docs.aws.amazon.com/resilience-hub/latest/userguide/app-config-param.html).
    ///
    /// Currently, this parameter accepts a key-value mapping (in a string format)
    /// of only one failover region and one associated account.
    ///
    /// Key: `"failover-regions"`
    ///
    /// Value: `"[{"region":"<REGION>", "accounts":[{"id":"<ACCOUNT_ID>"}]}]"`
    ///
    /// * **
    /// `appComponents`
    /// **
    ///
    /// List of Application Components that this resource belongs to. If an
    /// Application Component is not part of the Resilience Hub application, it will
    /// be added.
    ///
    /// Type: Array
    ///
    /// Each `appComponents` array item includes the following fields:
    ///
    /// * `name`
    ///
    /// Name of the Application Component.
    ///
    /// Type: String
    ///
    /// * `type`
    ///
    /// Type of Application Component. For more information about the types of
    /// Application Component, see [Grouping resources in an
    /// AppComponent](https://docs.aws.amazon.com/resilience-hub/latest/userguide/AppComponent.grouping.html).
    ///
    /// Type: String
    ///
    /// * `resourceNames`
    ///
    /// The list of included resources that are assigned to the Application
    /// Component.
    ///
    /// Type: Array of strings
    ///
    /// * `additionalInfo`
    ///
    /// Additional configuration parameters for an Resilience Hub application. If
    /// you want to implement `additionalInfo` through the Resilience Hub console
    /// rather than using an API call, see [Configure the application configuration
    /// parameters](https://docs.aws.amazon.com/resilience-hub/latest/userguide/app-config-param.html).
    ///
    /// Currently, this parameter accepts a key-value mapping (in a string format)
    /// of only one failover region and one associated account.
    ///
    /// Key: `"failover-regions"`
    ///
    /// Value: `"[{"region":"<REGION>", "accounts":[{"id":"<ACCOUNT_ID>"}]}]"`
    ///
    /// * **
    /// `excludedResources`
    /// **
    ///
    /// The list of logical resource identifiers to be excluded from the
    /// application.
    ///
    /// Type: Array
    ///
    /// Don't add the resources that you want to include.
    ///
    /// Each `excludedResources` array item includes the following fields:
    ///
    /// * *
    /// `logicalResourceIds`
    /// *
    ///
    /// Logical identifier of the resource.
    ///
    /// Type: Object
    ///
    /// You can configure only one of the following fields:
    ///
    /// * `logicalStackName`
    ///
    /// * `resourceGroupName`
    ///
    /// * `terraformSourceName`
    ///
    /// * `eksSourceName`
    ///
    /// Each `logicalResourceIds` object includes the following fields:
    ///
    /// * `identifier`
    ///
    /// Identifier of the resource.
    ///
    /// Type: String
    ///
    /// * `logicalStackName`
    ///
    /// The name of the CloudFormation stack this resource belongs to.
    ///
    /// Type: String
    ///
    /// * `resourceGroupName`
    ///
    /// The name of the resource group this resource belongs to.
    ///
    /// Type: String
    ///
    /// * `terraformSourceName`
    ///
    /// The name of the Terraform S3 state file this resource belongs to.
    ///
    /// Type: String
    ///
    /// * `eksSourceName`
    ///
    /// Name of the Amazon Elastic Kubernetes Service cluster and namespace this
    /// resource belongs to.
    ///
    /// This parameter accepts values in "eks-cluster/namespace" format.
    ///
    /// Type: String
    ///
    /// * **
    /// `version`
    /// **
    ///
    /// Resilience Hub application version.
    ///
    /// * `additionalInfo`
    ///
    /// Additional configuration parameters for an Resilience Hub application. If
    /// you want to implement `additionalInfo` through the Resilience Hub console
    /// rather than using an API call, see [Configure the application configuration
    /// parameters](https://docs.aws.amazon.com/resilience-hub/latest/userguide/app-config-param.html).
    ///
    /// Currently, this parameter accepts a key-value mapping (in a string format)
    /// of only one failover region and one associated account.
    ///
    /// Key: `"failover-regions"`
    ///
    /// Value: `"[{"region":"<REGION>", "accounts":[{"id":"<ACCOUNT_ID>"}]}]"`
    app_template_body: []const u8,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_template_body = "appTemplateBody",
    };
};

pub const PutDraftAppVersionTemplateOutput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: ?[]const u8 = null,

    /// The version of the application.
    app_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_version = "appVersion",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDraftAppVersionTemplateInput, options: Options) !PutDraftAppVersionTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "resiliencehub");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutDraftAppVersionTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/put-draft-app-version-template";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"appArn\":");
    try aws.json.writeValue(@TypeOf(input.app_arn), input.app_arn, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"appTemplateBody\":");
    try aws.json.writeValue(@TypeOf(input.app_template_body), input.app_template_body, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutDraftAppVersionTemplateOutput {
    var result: PutDraftAppVersionTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutDraftAppVersionTemplateOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

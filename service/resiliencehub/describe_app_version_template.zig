const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeAppVersionTemplateInput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// The version of the application.
    app_version: []const u8,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_version = "appVersion",
    };
};

pub const DescribeAppVersionTemplateOutput = struct {
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

    /// The version of the application.
    app_version: []const u8,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_template_body = "appTemplateBody",
        .app_version = "appVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAppVersionTemplateInput, options: CallOptions) !DescribeAppVersionTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAppVersionTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describe-app-version-template";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appArn\":");
    try aws.json.writeValue(@TypeOf(input.app_arn), input.app_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appVersion\":");
    try aws.json.writeValue(@TypeOf(input.app_version), input.app_version, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAppVersionTemplateOutput {
    const result: DescribeAppVersionTemplateOutput = try aws.json.parseJsonObject(
        DescribeAppVersionTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

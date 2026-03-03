const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoDeployment = @import("auto_deployment.zig").AutoDeployment;
const CallAs = @import("call_as.zig").CallAs;
const Capability = @import("capability.zig").Capability;
const ManagedExecution = @import("managed_execution.zig").ManagedExecution;
const Parameter = @import("parameter.zig").Parameter;
const PermissionModels = @import("permission_models.zig").PermissionModels;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateStackSetInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM role to use to create this
    /// StackSet.
    ///
    /// Specify an IAM role only if you are using customized administrator roles to
    /// control
    /// which users or groups can manage specific StackSets within the same
    /// administrator account. For
    /// more information, see [Grant
    /// self-managed
    /// permissions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs-self-managed.html) in the *CloudFormation User Guide*.
    ///
    /// Valid only if the permissions model is `SELF_MANAGED`.
    administration_role_arn: ?[]const u8 = null,

    /// Describes whether StackSets automatically deploys to Organizations accounts
    /// that
    /// are added to the target organization or organizational unit (OU). For more
    /// information, see
    /// [Enable or disable automatic deployments for StackSets in
    /// Organizations](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-manage-auto-deployment.html)
    /// in the *CloudFormation User Guide*.
    ///
    /// Required if the permissions model is `SERVICE_MANAGED`. (Not used with
    /// self-managed permissions.)
    auto_deployment: ?AutoDeployment = null,

    /// Specifies whether you are acting as an account administrator in the
    /// organization's management account or as a delegated administrator in a
    /// member account.
    ///
    /// By default, `SELF` is specified. Use `SELF` for StackSets with
    /// self-managed permissions.
    ///
    /// * To create a StackSet with service-managed permissions while signed in to
    ///   the management account, specify `SELF`.
    ///
    /// * To create a StackSet with service-managed permissions while signed in to a
    ///   delegated
    /// administrator account, specify `DELEGATED_ADMIN`.
    ///
    /// Your Amazon Web Services account must be registered as a delegated admin in
    /// the management account. For more information, see [Register a
    /// delegated
    /// administrator](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-delegated-admin.html) in the *CloudFormation User Guide*.
    ///
    /// StackSets with service-managed permissions are created in the management
    /// account, including StackSets that are created by delegated administrators.
    ///
    /// Valid only if the permissions model is `SERVICE_MANAGED`.
    call_as: ?CallAs = null,

    /// In some cases, you must explicitly acknowledge that your StackSet template
    /// contains
    /// certain capabilities in order for CloudFormation to create the StackSet and
    /// related stack
    /// instances.
    ///
    /// * `CAPABILITY_IAM` and `CAPABILITY_NAMED_IAM`
    ///
    /// Some stack templates might include resources that can affect permissions in
    /// your
    /// Amazon Web Services account; for example, by creating new IAM users. For
    /// those StackSets, you must
    /// explicitly acknowledge this by specifying one of these capabilities.
    ///
    /// The following IAM resources require you to specify either the
    /// `CAPABILITY_IAM` or `CAPABILITY_NAMED_IAM` capability.
    ///
    /// * If you have IAM resources, you can specify either capability.
    ///
    /// * If you have IAM resources with custom names, you *must*
    /// specify `CAPABILITY_NAMED_IAM`.
    ///
    /// * If you don't specify either of these capabilities, CloudFormation returns
    ///   an
    /// `InsufficientCapabilities` error.
    ///
    /// If your stack template contains these resources, we recommend that you
    /// review all
    /// permissions associated with them and edit their permissions if necessary.
    ///
    /// *
    ///   [AWS::IAM::AccessKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-accesskey.html)
    ///
    /// *
    ///   [AWS::IAM::Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-group.html)
    ///
    /// *
    ///   [AWS::IAM::InstanceProfile](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-instanceprofile.html)
    ///
    /// *
    ///   [AWS::IAM::Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-policy.html)
    ///
    /// *
    ///   [AWS::IAM::Role](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-role.html)
    ///
    /// *
    ///   [AWS::IAM::User](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-user.html)
    ///
    /// *
    ///   [AWS::IAM::UserToGroupAddition](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-usertogroupaddition.html)
    ///
    /// For more information, see [Acknowledging IAM resources in CloudFormation
    /// templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/control-access-with-iam.html#using-iam-capabilities).
    ///
    /// * `CAPABILITY_AUTO_EXPAND`
    ///
    /// Some templates reference macros. If your StackSet template references one or
    /// more
    /// macros, you must create the StackSet directly from the processed template,
    /// without first
    /// reviewing the resulting changes in a change set. To create the StackSet
    /// directly, you must
    /// acknowledge this capability. For more information, see [Perform custom
    /// processing
    /// on CloudFormation templates with template
    /// macros](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-macros.html).
    ///
    /// StackSets with service-managed permissions don't currently support the use
    /// of macros
    /// in templates. (This includes the
    /// [AWS::Include](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-include.html) and [AWS::Serverless](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-serverless.html) transforms, which are macros hosted by CloudFormation.) Even if
    /// you specify this capability for a StackSet with service-managed permissions,
    /// if you
    /// reference a macro in your template the StackSet operation will fail.
    capabilities: ?[]const Capability = null,

    /// A unique identifier for this `CreateStackSet` request. Specify this token if
    /// you plan to retry requests so that CloudFormation knows that you're not
    /// attempting to create
    /// another StackSet with the same name. You might retry `CreateStackSet`
    /// requests to
    /// ensure that CloudFormation successfully received them.
    ///
    /// If you don't specify an operation ID, the SDK generates one
    /// automatically.
    client_request_token: ?[]const u8 = null,

    /// A description of the StackSet. You can use the description to identify the
    /// StackSet's
    /// purpose or other important information.
    description: ?[]const u8 = null,

    /// The name of the IAM execution role to use to create the StackSet. If you do
    /// not specify
    /// an execution role, CloudFormation uses the
    /// `AWSCloudFormationStackSetExecutionRole`
    /// role for the StackSet operation.
    ///
    /// Specify an IAM role only if you are using customized execution roles to
    /// control which
    /// stack resources users and groups can include in their StackSets.
    ///
    /// Valid only if the permissions model is `SELF_MANAGED`.
    execution_role_name: ?[]const u8 = null,

    /// Describes whether CloudFormation performs non-conflicting operations
    /// concurrently and queues
    /// conflicting operations.
    managed_execution: ?ManagedExecution = null,

    /// The input parameters for the StackSet template.
    parameters: ?[]const Parameter = null,

    /// Describes how the IAM roles required for StackSet operations are created. By
    /// default,
    /// `SELF-MANAGED` is specified.
    ///
    /// * With `self-managed` permissions, you must create the administrator and
    /// execution roles required to deploy to target accounts. For more information,
    /// see [Grant
    /// self-managed
    /// permissions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs-self-managed.html).
    ///
    /// * With `service-managed` permissions, StackSets automatically creates the
    /// IAM roles required to deploy to accounts managed by Organizations. For more
    /// information, see [Activate trusted access for StackSets with
    /// Organizations](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-activate-trusted-access.html).
    permission_model: ?PermissionModels = null,

    /// The stack ID you are importing into a new StackSet. Specify the Amazon
    /// Resource Name (ARN)
    /// of the stack.
    stack_id: ?[]const u8 = null,

    /// The name to associate with the StackSet. The name must be unique in the
    /// Region where you
    /// create your StackSet.
    ///
    /// A stack name can contain only alphanumeric characters (case-sensitive) and
    /// hyphens. It
    /// must start with an alphabetic character and can't be longer than 128
    /// characters.
    stack_set_name: []const u8,

    /// The key-value pairs to associate with this StackSet and the stacks created
    /// from it.
    /// CloudFormation also propagates these tags to supported resources that are
    /// created in the stacks. A
    /// maximum number of 50 tags can be specified.
    ///
    /// If you specify tags as part of a `CreateStackSet` action, CloudFormation
    /// checks to
    /// see if you have the required IAM permission to tag resources. If you don't,
    /// the entire
    /// `CreateStackSet` action fails with an `access denied` error, and the
    /// StackSet is not created.
    tags: ?[]const Tag = null,

    /// The structure that contains the template body, with a minimum length of 1
    /// byte and a
    /// maximum length of 51,200 bytes.
    ///
    /// Conditional: You must specify either the `TemplateBody` or the
    /// `TemplateURL` parameter, but not both.
    template_body: ?[]const u8 = null,

    /// The URL of a file that contains the template body. The URL must point to a
    /// template
    /// (maximum size: 1 MB) that's located in an Amazon S3 bucket or a Systems
    /// Manager document. The
    /// location for an Amazon S3 bucket must start with `https://`. S3 static
    /// website URLs are
    /// not supported.
    ///
    /// Conditional: You must specify either the `TemplateBody` or the
    /// `TemplateURL` parameter, but not both.
    template_url: ?[]const u8 = null,
};

pub const CreateStackSetOutput = struct {
    /// The ID of the StackSet that you're creating.
    stack_set_id: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStackSetInput, options: Options) !CreateStackSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudformation");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStackSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateStackSet&Version=2010-05-15");
    if (input.administration_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&AdministrationRoleARN=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.auto_deployment) |v| {
        if (v.depends_on) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AutoDeployment.DependsOn.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
        if (v.enabled) |sv| {
            try body_buf.appendSlice(allocator, "&AutoDeployment.Enabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.retain_stacks_on_account_removal) |sv| {
            try body_buf.appendSlice(allocator, "&AutoDeployment.RetainStacksOnAccountRemoval=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.call_as) |v| {
        try body_buf.appendSlice(allocator, "&CallAs=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.capabilities) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Capabilities.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.client_request_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientRequestToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.execution_role_name) |v| {
        try body_buf.appendSlice(allocator, "&ExecutionRoleName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.managed_execution) |v| {
        if (v.active) |sv| {
            try body_buf.appendSlice(allocator, "&ManagedExecution.Active=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.parameters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.member.{d}.ParameterKey=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.parameter_key) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.member.{d}.ParameterValue=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.parameter_value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.member.{d}.ResolvedValue=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resolved_value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.member.{d}.UsePreviousValue=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.use_previous_value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
        }
    }
    if (input.permission_model) |v| {
        try body_buf.appendSlice(allocator, "&PermissionModel=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.stack_id) |v| {
        try body_buf.appendSlice(allocator, "&StackId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&StackSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_set_name);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
    }
    if (input.template_body) |v| {
        try body_buf.appendSlice(allocator, "&TemplateBody=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.template_url) |v| {
        try body_buf.appendSlice(allocator, "&TemplateURL=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStackSetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateStackSetResult")) break;
            },
            else => {},
        }
    }

    var result: CreateStackSetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CFNRegistryException")) {
        return .{ .arena = arena, .kind = .{ .cfn_registry_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChangeSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .change_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentResourcesLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_resources_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreatedButModifiedException")) {
        return .{ .arena = arena, .kind = .{ .created_but_modified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GeneratedTemplateNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .generated_template_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HookResultNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .hook_result_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapabilitiesException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capabilities_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidChangeSetStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_change_set_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_transition_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NameAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .name_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationIdAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .operation_id_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationInProgressException")) {
        return .{ .arena = arena, .kind = .{ .operation_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationStatusCheckFailedException")) {
        return .{ .arena = arena, .kind = .{ .operation_status_check_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanInProgressException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackInstanceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_instance_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackRefactorNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_refactor_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackSetNotEmptyException")) {
        return .{ .arena = arena, .kind = .{ .stack_set_not_empty_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StaleRequestException")) {
        return .{ .arena = arena, .kind = .{ .stale_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TokenAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .token_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeConfigurationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .type_configuration_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .type_not_found_exception = .{
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

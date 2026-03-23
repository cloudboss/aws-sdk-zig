const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Capability = @import("capability.zig").Capability;
const ChangeSetType = @import("change_set_type.zig").ChangeSetType;
const DeploymentMode = @import("deployment_mode.zig").DeploymentMode;
const OnStackFailure = @import("on_stack_failure.zig").OnStackFailure;
const Parameter = @import("parameter.zig").Parameter;
const ResourceToImport = @import("resource_to_import.zig").ResourceToImport;
const RollbackConfiguration = @import("rollback_configuration.zig").RollbackConfiguration;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateChangeSetInput = struct {
    /// In some cases, you must explicitly acknowledge that your stack template
    /// contains certain
    /// capabilities in order for CloudFormation to create the stack.
    ///
    /// * `CAPABILITY_IAM` and `CAPABILITY_NAMED_IAM`
    ///
    /// Some stack templates might include resources that can affect permissions in
    /// your
    /// Amazon Web Services account, for example, by creating new IAM users. For
    /// those stacks, you must
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
    /// If your stack template contains these resources, we suggest that you review
    /// all
    /// permissions associated with them and edit their permissions if necessary.
    ///
    /// * [
    /// AWS::IAM::AccessKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-accesskey.html)
    ///
    /// * [
    /// AWS::IAM::Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-group.html)
    ///
    /// *
    ///   [AWS::IAM::InstanceProfile](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-instanceprofile.html)
    ///
    /// * [
    ///   AWS::IAM::ManagedPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-managedpolicy.html)
    ///
    /// * [
    /// AWS::IAM::Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-policy.html)
    ///
    /// * [
    /// AWS::IAM::Role](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-role.html)
    ///
    /// * [
    /// AWS::IAM::User](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-user.html)
    ///
    /// *
    ///   [AWS::IAM::UserToGroupAddition](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-usertogroupaddition.html)
    ///
    /// For more information, see [Acknowledging IAM resources in CloudFormation
    /// templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/control-access-with-iam.html#using-iam-capabilities).
    ///
    /// * `CAPABILITY_AUTO_EXPAND`
    ///
    /// Some template contain macros. Macros perform custom processing on templates;
    /// this can
    /// include simple actions like find-and-replace operations, all the way to
    /// extensive
    /// transformations of entire templates. Because of this, users typically create
    /// a change set
    /// from the processed template, so that they can review the changes resulting
    /// from the macros
    /// before actually creating the stack. If your stack template contains one or
    /// more macros,
    /// and you choose to create a stack directly from the processed template,
    /// without first
    /// reviewing the resulting changes in a change set, you must acknowledge this
    /// capability.
    /// This includes the
    /// [AWS::Include](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-include.html)
    /// and
    /// [AWS::Serverless](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-serverless.html) transforms, which are macros hosted by CloudFormation.
    ///
    /// This capacity doesn't apply to creating change sets, and specifying it when
    /// creating
    /// change sets has no effect.
    ///
    /// If you want to create a stack from a stack template that contains macros
    /// *and* nested stacks, you must create or update the stack directly
    /// from the template using the CreateStack or UpdateStack action, and
    /// specifying this capability.
    ///
    /// For more information about macros, see [Perform custom processing
    /// on CloudFormation templates with template
    /// macros](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-macros.html).
    ///
    /// Only one of the `Capabilities` and `ResourceType` parameters can
    /// be specified.
    capabilities: ?[]const Capability = null,

    /// The name of the change set. The name must be unique among all change sets
    /// that are
    /// associated with the specified stack.
    ///
    /// A change set name can contain only alphanumeric, case sensitive characters,
    /// and hyphens.
    /// It must start with an alphabetical character and can't exceed 128
    /// characters.
    change_set_name: []const u8,

    /// The type of change set operation. To create a change set for a new stack,
    /// specify
    /// `CREATE`. To create a change set for an existing stack, specify
    /// `UPDATE`. To create a change set for an import operation, specify
    /// `IMPORT`.
    ///
    /// If you create a change set for a new stack, CloudFormation creates a stack
    /// with a unique stack
    /// ID, but no template or resources. The stack will be in the
    /// `REVIEW_IN_PROGRESS`
    /// state until you execute the change set.
    ///
    /// By default, CloudFormation specifies `UPDATE`. You can't use the
    /// `UPDATE` type to create a change set for a new stack or the `CREATE`
    /// type to create a change set for an existing stack.
    change_set_type: ?ChangeSetType = null,

    /// A unique identifier for this `CreateChangeSet` request. Specify this token
    /// if
    /// you plan to retry requests so that CloudFormation knows that you're not
    /// attempting to create
    /// another change set with the same name. You might retry `CreateChangeSet`
    /// requests
    /// to ensure that CloudFormation successfully received them.
    client_token: ?[]const u8 = null,

    /// Determines how CloudFormation handles configuration drift during deployment.
    ///
    /// * `REVERT_DRIFT` – Creates a drift-aware change set that brings actual
    /// resource states in line with template definitions. Provides a three-way
    /// comparison between
    /// actual state, previous deployment state, and desired state.
    ///
    /// For more information, see [Using drift-aware
    /// change
    /// sets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/drift-aware-change-sets.html) in the *CloudFormation User Guide*.
    deployment_mode: ?DeploymentMode = null,

    /// A description to help you identify this change set.
    description: ?[]const u8 = null,

    /// Indicates if the change set auto-imports resources that already exist. For
    /// more
    /// information, see [Import Amazon Web Services
    /// resources into a CloudFormation stack
    /// automatically](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/import-resources-automatically.html) in the
    /// *CloudFormation User Guide*.
    ///
    /// This parameter can only import resources that have custom names in
    /// templates. For more
    /// information, see [name
    /// type](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-properties-name.html) in the *CloudFormation User Guide*. To import resources that do not
    /// accept custom names, such as EC2 instances, use the `ResourcesToImport`
    /// parameter
    /// instead.
    import_existing_resources: ?bool = null,

    /// Creates a change set for the all nested stacks specified in the template.
    /// The default
    /// behavior of this action is set to `False`. To include nested sets in a
    /// change set,
    /// specify `True`.
    include_nested_stacks: ?bool = null,

    /// The Amazon Resource Names (ARNs) of Amazon SNS topics that CloudFormation
    /// associates with the
    /// stack. To remove all associated notification topics, specify an empty list.
    notification_ar_ns: ?[]const []const u8 = null,

    /// Determines what action will be taken if stack creation fails. If this
    /// parameter is
    /// specified, the `DisableRollback` parameter to the
    /// [ExecuteChangeSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ExecuteChangeSet.html) API operation must not be specified. This must be one of these
    /// values:
    ///
    /// * `DELETE` - Deletes the change set if the stack creation fails. This is
    ///   only
    /// valid when the `ChangeSetType` parameter is set to `CREATE`. If the
    /// deletion of the stack fails, the status of the stack is `DELETE_FAILED`.
    ///
    /// * `DO_NOTHING` - if the stack creation fails, do nothing. This is equivalent
    /// to specifying `true` for the `DisableRollback` parameter to the
    /// [ExecuteChangeSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ExecuteChangeSet.html) API operation.
    ///
    /// * `ROLLBACK` - if the stack creation fails, roll back the stack. This is
    /// equivalent to specifying `false` for the `DisableRollback` parameter
    /// to the
    /// [ExecuteChangeSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ExecuteChangeSet.html) API operation.
    ///
    /// For nested stacks, when the `OnStackFailure` parameter is set to
    /// `DELETE` for the change set for the parent stack, any failure in a child
    /// stack
    /// will cause the parent stack creation to fail and all stacks to be deleted.
    on_stack_failure: ?OnStackFailure = null,

    /// A list of `Parameter` structures that specify input parameters for the
    /// change
    /// set. For more information, see the Parameter data type.
    parameters: ?[]const Parameter = null,

    /// The resources to import into your stack.
    resources_to_import: ?[]const ResourceToImport = null,

    /// Specifies which resource types you can work with, such as
    /// `AWS::EC2::Instance`
    /// or `Custom::MyCustomInstance`.
    ///
    /// If the list of resource types doesn't include a resource type that you're
    /// updating, the
    /// stack update fails. By default, CloudFormation grants permissions to all
    /// resource types. IAM
    /// uses this parameter for condition keys in IAM policies for CloudFormation.
    /// For more information,
    /// see [Control CloudFormation
    /// access with Identity and Access
    /// Management](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/control-access-with-iam.html) in the *CloudFormation User Guide*.
    ///
    /// Only one of the `Capabilities` and `ResourceType` parameters can
    /// be specified.
    resource_types: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that CloudFormation assumes
    /// when executing the
    /// change set. CloudFormation uses the role's credentials to make calls on your
    /// behalf. CloudFormation
    /// uses this role for all future operations on the stack. Provided that users
    /// have permission to
    /// operate on the stack, CloudFormation uses this role even if the users don't
    /// have permission to
    /// pass it. Ensure that the role grants least permission.
    ///
    /// If you don't specify a value, CloudFormation uses the role that was
    /// previously associated with
    /// the stack. If no role is available, CloudFormation uses a temporary session
    /// that is generated from
    /// your user credentials.
    role_arn: ?[]const u8 = null,

    /// The rollback triggers for CloudFormation to monitor during stack creation
    /// and updating
    /// operations, and for the specified monitoring period afterwards.
    rollback_configuration: ?RollbackConfiguration = null,

    /// The name or the unique ID of the stack for which you are creating a change
    /// set. CloudFormation
    /// generates the change set by comparing this stack's information with the
    /// information that you
    /// submit, such as a modified template or different parameter input values.
    stack_name: []const u8,

    /// Key-value pairs to associate with this stack. CloudFormation also propagates
    /// these tags to
    /// resources in the stack. You can specify a maximum of 50 tags.
    tags: ?[]const Tag = null,

    /// A structure that contains the body of the revised template, with a minimum
    /// length of 1
    /// byte and a maximum length of 51,200 bytes. CloudFormation generates the
    /// change set by comparing
    /// this template with the template of the stack that you specified.
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `TemplateBody`, `TemplateURL`, or set the
    /// `UsePreviousTemplate` to `true`.
    template_body: ?[]const u8 = null,

    /// The URL of the file that contains the revised template. The URL must point
    /// to a template
    /// (max size: 1 MB) that's located in an Amazon S3 bucket or a Systems Manager
    /// document. CloudFormation
    /// generates the change set by comparing this template with the stack that you
    /// specified. The
    /// location for an Amazon S3 bucket must start with `https://`. URLs from S3
    /// static
    /// websites are not supported.
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `TemplateBody`, `TemplateURL`, or set the
    /// `UsePreviousTemplate` to `true`.
    template_url: ?[]const u8 = null,

    /// Whether to reuse the template that's associated with the stack to create the
    /// change
    /// set.
    ///
    /// When using templates with the `AWS::LanguageExtensions` transform, provide
    /// the
    /// template instead of using `UsePreviousTemplate` to ensure new parameter
    /// values and
    /// Systems Manager parameter updates are applied correctly. For more
    /// information, see [AWS::LanguageExtensions
    /// transform](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/transform-aws-languageextensions.html).
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `TemplateBody`, `TemplateURL`, or set the
    /// `UsePreviousTemplate` to `true`.
    use_previous_template: ?bool = null,
};

pub const CreateChangeSetOutput = struct {
    /// The Amazon Resource Name (ARN) of the change set.
    id: ?[]const u8 = null,

    /// The unique ID of the stack.
    stack_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChangeSetInput, options: CallOptions) !CreateChangeSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChangeSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateChangeSet&Version=2010-05-15");
    if (input.capabilities) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Capabilities.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    try body_buf.appendSlice(allocator, "&ChangeSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.change_set_name);
    if (input.change_set_type) |v| {
        try body_buf.appendSlice(allocator, "&ChangeSetType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.deployment_mode) |v| {
        try body_buf.appendSlice(allocator, "&DeploymentMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.import_existing_resources) |v| {
        try body_buf.appendSlice(allocator, "&ImportExistingResources=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.include_nested_stacks) |v| {
        try body_buf.appendSlice(allocator, "&IncludeNestedStacks=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.notification_ar_ns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NotificationARNs.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.on_stack_failure) |v| {
        try body_buf.appendSlice(allocator, "&OnStackFailure=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.parameters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.parameter_key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.member.{d}.ParameterKey=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.parameter_value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.member.{d}.ParameterValue=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resolved_value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.member.{d}.ResolvedValue=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.use_previous_value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.member.{d}.UsePreviousValue=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
        }
    }
    if (input.resources_to_import) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourcesToImport.member.{d}.LogicalResourceId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.logical_resource_id);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourcesToImport.member.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.resource_type);
            }
        }
    }
    if (input.resource_types) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourceTypes.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.role_arn) |v| {
        try body_buf.appendSlice(allocator, "&RoleARN=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.rollback_configuration) |v| {
        if (v.monitoring_time_in_minutes) |sv| {
            try body_buf.appendSlice(allocator, "&RollbackConfiguration.MonitoringTimeInMinutes=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.rollback_triggers) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RollbackConfiguration.RollbackTriggers.member.{d}.Arn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.arn);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RollbackConfiguration.RollbackTriggers.member.{d}.Type=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.@"type");
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&StackName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_name);
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
    if (input.use_previous_template) |v| {
        try body_buf.appendSlice(allocator, "&UsePreviousTemplate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChangeSetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateChangeSetResult")) break;
            },
            else => {},
        }
    }

    var result: CreateChangeSetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
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

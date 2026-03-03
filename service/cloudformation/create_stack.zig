const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Capability = @import("capability.zig").Capability;
const OnFailure = @import("on_failure.zig").OnFailure;
const Parameter = @import("parameter.zig").Parameter;
const RollbackConfiguration = @import("rollback_configuration.zig").RollbackConfiguration;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateStackInput = struct {
    /// In some cases, you must explicitly acknowledge that your stack template
    /// contains certain
    /// capabilities in order for CloudFormation to create the stack.
    ///
    /// * `CAPABILITY_IAM` and `CAPABILITY_NAMED_IAM`
    ///
    /// Some stack templates might include resources that can affect permissions in
    /// your
    /// Amazon Web Services account; for example, by creating new IAM users. For
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
    /// * [
    ///   AWS::IAM::ManagedPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-iam-managedpolicy.html)
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
    /// If you want to create a stack from a stack template that contains macros
    /// *and* nested stacks, you must create the stack directly from the
    /// template using this capability.
    ///
    /// You should only create stacks directly from a stack template that contains
    /// macros if
    /// you know what processing the macro performs.
    ///
    /// Each macro relies on an underlying Lambda service function for processing
    /// stack
    /// templates. Be aware that the Lambda function owner can update the function
    /// operation
    /// without CloudFormation being notified.
    ///
    /// For more information, see [Perform custom processing
    /// on CloudFormation templates with template
    /// macros](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-macros.html).
    ///
    /// Only one of the `Capabilities` and `ResourceType` parameters can
    /// be specified.
    capabilities: ?[]const Capability = null,

    /// A unique identifier for this `CreateStack` request. Specify this token if
    /// you
    /// plan to retry requests so that CloudFormation knows that you're not
    /// attempting to create a stack
    /// with the same name. You might retry `CreateStack` requests to ensure that
    /// CloudFormation successfully received them.
    ///
    /// All events initiated by a given stack operation are assigned the same client
    /// request
    /// token, which you can use to track operations. For example, if you execute a
    /// `CreateStack` operation with the token `token1`, then all the
    /// `StackEvents` generated by that operation will have
    /// `ClientRequestToken` set as `token1`.
    ///
    /// In the console, stack operations display the client request token on the
    /// Events tab. Stack
    /// operations that are initiated from the console use the token format
    /// *Console-StackOperation-ID*, which helps you easily identify the stack
    /// operation . For example, if you create a stack using the console, each stack
    /// event would be
    /// assigned the same token in the following format:
    /// `Console-CreateStack-7f59c3cf-00d2-40c7-b2ff-e75db0987002`.
    client_request_token: ?[]const u8 = null,

    /// Set to `true` to disable rollback of the stack if stack creation failed. You
    /// can specify either `DisableRollback` or `OnFailure`, but not
    /// both.
    ///
    /// Default: `false`
    disable_rollback: ?bool = null,

    /// Whether to enable termination protection on the specified stack. If a user
    /// attempts to
    /// delete a stack with termination protection enabled, the operation fails and
    /// the stack remains
    /// unchanged. For more information, see [Protect CloudFormation
    /// stacks from being
    /// deleted](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-protect-stacks.html) in the *CloudFormation User Guide*. Termination
    /// protection is deactivated on stacks by default.
    ///
    /// For [nested
    /// stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html),
    /// termination protection is set on the root stack and can't be changed
    /// directly on the nested
    /// stack.
    enable_termination_protection: ?bool = null,

    /// The Amazon SNS topic ARNs to publish stack related events. You can find your
    /// Amazon SNS topic ARNs
    /// using the Amazon SNS console or your Command Line Interface (CLI).
    notification_ar_ns: ?[]const []const u8 = null,

    /// Determines what action will be taken if stack creation fails. This must be
    /// one of:
    /// `DO_NOTHING`, `ROLLBACK`, or `DELETE`. You can specify
    /// either `OnFailure` or `DisableRollback`, but not both.
    ///
    /// Although the default setting is `ROLLBACK`, there is one exception. This
    /// exception occurs when a StackSet attempts to deploy a stack instance and the
    /// stack instance
    /// fails to create successfully. In this case, the `CreateStack` call overrides
    /// the
    /// default setting and sets the value of `OnFailure` to `DELETE`.
    ///
    /// Default: `ROLLBACK`
    on_failure: ?OnFailure = null,

    /// A list of `Parameter` structures that specify input parameters for the
    /// stack.
    /// For more information, see the
    /// [Parameter](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_Parameter.html) data
    /// type.
    parameters: ?[]const Parameter = null,

    /// Specifies which resource types you can work with, such as
    /// `AWS::EC2::Instance`
    /// or `Custom::MyCustomInstance`.
    ///
    /// If the list of resource types doesn't include a resource that you're
    /// creating, the stack
    /// creation fails. By default, CloudFormation grants permissions to all
    /// resource types. IAM uses
    /// this parameter for CloudFormation-specific condition keys in IAM policies.
    /// For more information,
    /// see [Control CloudFormation
    /// access with Identity and Access
    /// Management](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/control-access-with-iam.html).
    ///
    /// Only one of the `Capabilities` and `ResourceType` parameters can
    /// be specified.
    resource_types: ?[]const []const u8 = null,

    /// When set to `true`, newly created resources are deleted when the operation
    /// rolls back. This includes newly created resources marked with a deletion
    /// policy of
    /// `Retain`.
    ///
    /// Default: `false`
    retain_except_on_create: ?bool = null,

    /// The Amazon Resource Name (ARN) of an IAM role that CloudFormation assumes to
    /// create the
    /// stack. CloudFormation uses the role's credentials to make calls on your
    /// behalf. CloudFormation always
    /// uses this role for all future operations on the stack. Provided that users
    /// have permission to
    /// operate on the stack, CloudFormation uses this role even if the users don't
    /// have permission to
    /// pass it. Ensure that the role grants least privilege.
    ///
    /// If you don't specify a value, CloudFormation uses the role that was
    /// previously associated with
    /// the stack. If no role is available, CloudFormation uses a temporary session
    /// that's generated from
    /// your user credentials.
    role_arn: ?[]const u8 = null,

    /// The rollback triggers for CloudFormation to monitor during stack creation
    /// and updating
    /// operations, and for the specified monitoring period afterwards.
    rollback_configuration: ?RollbackConfiguration = null,

    /// The name that's associated with the stack. The name must be unique in the
    /// Region in which
    /// you are creating the stack.
    ///
    /// A stack name can contain only alphanumeric characters (case sensitive) and
    /// hyphens. It
    /// must start with an alphabetical character and can't be longer than 128
    /// characters.
    stack_name: []const u8,

    /// Structure that contains the stack policy body. For more information, see
    /// [Prevent updates to stack
    /// resources](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/protect-stack-resources.html) in the *CloudFormation User Guide*.
    /// You can specify either the `StackPolicyBody` or the `StackPolicyURL`
    /// parameter, but not both.
    stack_policy_body: ?[]const u8 = null,

    /// Location of a file that contains the stack policy. The URL must point to a
    /// policy (maximum
    /// size: 16 KB) located in an S3 bucket in the same Region as the stack. The
    /// location for an Amazon S3
    /// bucket must start with `https://`. URLs from S3 static websites are not
    /// supported.
    ///
    /// You can specify either the `StackPolicyBody` or the `StackPolicyURL`
    /// parameter, but not both.
    stack_policy_url: ?[]const u8 = null,

    /// Key-value pairs to associate with this stack. CloudFormation also propagates
    /// these tags to the
    /// resources created in the stack. A maximum number of 50 tags can be
    /// specified.
    tags: ?[]const Tag = null,

    /// Structure that contains the template body with a minimum length of 1 byte
    /// and a maximum
    /// length of 51,200 bytes.
    ///
    /// Conditional: You must specify either `TemplateBody` or
    /// `TemplateURL`, but not both.
    template_body: ?[]const u8 = null,

    /// The URL of a file that contains the template body. The URL must point to a
    /// template (max
    /// size: 1 MB) that's located in an Amazon S3 bucket or a Systems Manager
    /// document. The location for
    /// an Amazon S3 bucket must start with `https://`. URLs from S3 static websites
    /// are not
    /// supported.
    ///
    /// Conditional: You must specify either the `TemplateBody` or the
    /// `TemplateURL` parameter, but not both.
    template_url: ?[]const u8 = null,

    /// The amount of time that can pass before the stack status becomes
    /// `CREATE_FAILED`; if `DisableRollback` is not set or is set to
    /// `false`, the stack will be rolled back.
    timeout_in_minutes: ?i32 = null,
};

pub const CreateStackOutput = struct {
    /// A unique identifier for this stack operation that can be used to track the
    /// operation's
    /// progress and events.
    operation_id: ?[]const u8 = null,

    /// Unique identifier of the stack.
    stack_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStackInput, options: CallOptions) !CreateStackOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateStack&Version=2010-05-15");
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
    if (input.disable_rollback) |v| {
        try body_buf.appendSlice(allocator, "&DisableRollback=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_termination_protection) |v| {
        try body_buf.appendSlice(allocator, "&EnableTerminationProtection=");
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
    if (input.on_failure) |v| {
        try body_buf.appendSlice(allocator, "&OnFailure=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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
    if (input.resource_types) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourceTypes.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.retain_except_on_create) |v| {
        try body_buf.appendSlice(allocator, "&RetainExceptOnCreate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
    if (input.stack_policy_body) |v| {
        try body_buf.appendSlice(allocator, "&StackPolicyBody=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.stack_policy_url) |v| {
        try body_buf.appendSlice(allocator, "&StackPolicyURL=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
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
    if (input.timeout_in_minutes) |v| {
        try body_buf.appendSlice(allocator, "&TimeoutInMinutes=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStackOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateStackResult")) break;
            },
            else => {},
        }
    }

    var result: CreateStackOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try allocator.dupe(u8, try reader.readElementText());
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

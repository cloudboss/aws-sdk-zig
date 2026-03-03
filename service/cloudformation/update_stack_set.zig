const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoDeployment = @import("auto_deployment.zig").AutoDeployment;
const CallAs = @import("call_as.zig").CallAs;
const Capability = @import("capability.zig").Capability;
const DeploymentTargets = @import("deployment_targets.zig").DeploymentTargets;
const ManagedExecution = @import("managed_execution.zig").ManagedExecution;
const StackSetOperationPreferences = @import("stack_set_operation_preferences.zig").StackSetOperationPreferences;
const Parameter = @import("parameter.zig").Parameter;
const PermissionModels = @import("permission_models.zig").PermissionModels;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const UpdateStackSetInput = struct {
    /// [Self-managed permissions] The accounts in which to update associated stack
    /// instances. If
    /// you specify accounts, you must also specify the Amazon Web Services Regions
    /// in which to update StackSet
    /// instances.
    ///
    /// To update *all* the stack instances associated with this StackSet,
    /// don't specify the `Accounts` or `Regions` properties.
    ///
    /// If the StackSet update includes changes to the template (that is, if the
    /// `TemplateBody` or `TemplateURL` properties are specified), or the
    /// `Parameters` property, CloudFormation marks all stack instances with a
    /// status of
    /// `OUTDATED` prior to updating the stack instances in the specified accounts
    /// and
    /// Amazon Web Services Regions. If the StackSet update does not include changes
    /// to the template or parameters,
    /// CloudFormation updates the stack instances in the specified accounts and
    /// Amazon Web Services Regions, while
    /// leaving all other stack instances with their existing stack instance status.
    accounts: ?[]const []const u8 = null,

    /// [Self-managed permissions] The Amazon Resource Name (ARN) of the IAM role to
    /// use to
    /// update this StackSet.
    ///
    /// Specify an IAM role only if you are using customized administrator roles to
    /// control
    /// which users or groups can manage specific StackSets within the same
    /// administrator account. For
    /// more information, see [Grant
    /// self-managed
    /// permissions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs-self-managed.html) in the *CloudFormation User Guide*.
    ///
    /// If you specified a customized administrator role when you created the
    /// StackSet, you must
    /// specify a customized administrator role, even if it is the same customized
    /// administrator role
    /// used with this StackSet previously.
    administration_role_arn: ?[]const u8 = null,

    /// [Service-managed permissions] Describes whether StackSets automatically
    /// deploys to Organizations accounts that are added to a target organization or
    /// organizational unit (OU).
    /// For more information, see [Enable or disable automatic deployments for
    /// StackSets in
    /// Organizations](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-manage-auto-deployment.html)
    /// in the *CloudFormation User Guide*.
    ///
    /// If you specify `AutoDeployment`, don't specify `DeploymentTargets`
    /// or `Regions`.
    auto_deployment: ?AutoDeployment = null,

    /// [Service-managed permissions] Specifies whether you are acting as an account
    /// administrator
    /// in the organization's management account or as a delegated administrator in
    /// a
    /// member account.
    ///
    /// By default, `SELF` is specified. Use `SELF` for StackSets with
    /// self-managed permissions.
    ///
    /// * If you are signed in to the management account, specify
    /// `SELF`.
    ///
    /// * If you are signed in to a delegated administrator account, specify
    /// `DELEGATED_ADMIN`.
    ///
    /// Your Amazon Web Services account must be registered as a delegated
    /// administrator in the management account. For more information, see [Register
    /// a
    /// delegated
    /// administrator](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-delegated-admin.html) in the *CloudFormation User Guide*.
    call_as: ?CallAs = null,

    /// In some cases, you must explicitly acknowledge that your stack template
    /// contains certain
    /// capabilities in order for CloudFormation to update the StackSet and its
    /// associated stack
    /// instances.
    ///
    /// * `CAPABILITY_IAM` and `CAPABILITY_NAMED_IAM`
    ///
    /// Some stack templates might include resources that can affect permissions in
    /// your
    /// Amazon Web Services account, for example, by creating new IAM users. For
    /// those stacks sets, you must
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
    /// macros, you must update the StackSet directly from the processed template,
    /// without first
    /// reviewing the resulting changes in a change set. To update the StackSet
    /// directly, you must
    /// acknowledge this capability. For more information, see [Perform custom
    /// processing
    /// on CloudFormation templates with template
    /// macros](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-macros.html).
    ///
    /// StackSets with service-managed permissions do not currently support the use
    /// of
    /// macros in templates. (This includes the
    /// [AWS::Include](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-include.html) and [AWS::Serverless](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-serverless.html) transforms, which are macros hosted by CloudFormation.) Even if
    /// you specify this capability for a StackSet with service-managed permissions,
    /// if you
    /// reference a macro in your template the StackSet operation will fail.
    capabilities: ?[]const Capability = null,

    /// [Service-managed permissions] The Organizations accounts in which to update
    /// associated stack instances.
    ///
    /// To update all the stack instances associated with this StackSet, do not
    /// specify
    /// `DeploymentTargets` or `Regions`.
    ///
    /// If the StackSet update includes changes to the template (that is, if
    /// `TemplateBody` or `TemplateURL` is specified), or the
    /// `Parameters`, CloudFormation marks all stack instances with a status of
    /// `OUTDATED` prior to updating the stack instances in the specified accounts
    /// and
    /// Amazon Web Services Regions. If the StackSet update doesn't include changes
    /// to the template or parameters,
    /// CloudFormation updates the stack instances in the specified accounts and
    /// Regions, while leaving
    /// all other stack instances with their existing stack instance status.
    deployment_targets: ?DeploymentTargets = null,

    /// A brief description of updates that you are making.
    description: ?[]const u8 = null,

    /// [Self-managed permissions] The name of the IAM execution role to use to
    /// update the stack
    /// set. If you do not specify an execution role, CloudFormation uses the
    /// `AWSCloudFormationStackSetExecutionRole` role for the StackSet operation.
    ///
    /// Specify an IAM role only if you are using customized execution roles to
    /// control which
    /// stack resources users and groups can include in their StackSets.
    ///
    /// If you specify a customized execution role, CloudFormation uses that role to
    /// update the stack.
    /// If you do not specify a customized execution role, CloudFormation performs
    /// the update using the
    /// role previously associated with the StackSet, so long as you have
    /// permissions to perform
    /// operations on the StackSet.
    execution_role_name: ?[]const u8 = null,

    /// Describes whether CloudFormation performs non-conflicting operations
    /// concurrently and queues
    /// conflicting operations.
    managed_execution: ?ManagedExecution = null,

    /// The unique ID for this StackSet operation.
    ///
    /// The operation ID also functions as an idempotency token, to ensure that
    /// CloudFormation
    /// performs the StackSet operation only once, even if you retry the request
    /// multiple times. You
    /// might retry StackSet operation requests to ensure that CloudFormation
    /// successfully received
    /// them.
    ///
    /// If you don't specify an operation ID, CloudFormation generates one
    /// automatically.
    ///
    /// Repeating this StackSet operation with a new operation ID retries all stack
    /// instances
    /// whose status is `OUTDATED`.
    operation_id: ?[]const u8 = null,

    /// Preferences for how CloudFormation performs this StackSet operation.
    operation_preferences: ?StackSetOperationPreferences = null,

    /// A list of input parameters for the StackSet template.
    parameters: ?[]const Parameter = null,

    /// Describes how the IAM roles required for StackSet operations are created.
    /// You cannot
    /// modify `PermissionModel` if there are stack instances associated with your
    /// stack
    /// set.
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

    /// The Amazon Web Services Regions in which to update associated stack
    /// instances. If you specify Regions,
    /// you must also specify accounts in which to update StackSet instances.
    ///
    /// To update *all* the stack instances associated with this StackSet, do
    /// not specify the `Accounts` or `Regions` properties.
    ///
    /// If the StackSet update includes changes to the template (that is, if the
    /// `TemplateBody` or `TemplateURL` properties are specified), or the
    /// `Parameters` property, CloudFormation marks all stack instances with a
    /// status of
    /// `OUTDATED` prior to updating the stack instances in the specified accounts
    /// and
    /// Regions. If the StackSet update does not include changes to the template or
    /// parameters,
    /// CloudFormation updates the stack instances in the specified accounts and
    /// Regions, while leaving
    /// all other stack instances with their existing stack instance status.
    regions: ?[]const []const u8 = null,

    /// The name or unique ID of the StackSet that you want to update.
    stack_set_name: []const u8,

    /// The key-value pairs to associate with this StackSet and the stacks created
    /// from it.
    /// CloudFormation also propagates these tags to supported resources that are
    /// created in the stacks.
    /// You can specify a maximum number of 50 tags.
    ///
    /// If you specify tags for this parameter, those tags replace any list of tags
    /// that are
    /// currently associated with this StackSet. This means:
    ///
    /// * If you don't specify this parameter, CloudFormation doesn't modify the
    ///   stack's
    /// tags.
    ///
    /// * If you specify *any* tags using this parameter, you must specify
    /// *all* the tags that you want associated with this StackSet, even tags
    /// you've specified before (for example, when creating the StackSet or during a
    /// previous
    /// update of the StackSet.). Any tags that you don't include in the updated
    /// list of tags are
    /// removed from the StackSet, and therefore from the stacks and resources as
    /// well.
    ///
    /// * If you specify an empty value, CloudFormation removes all currently
    ///   associated
    /// tags.
    ///
    /// If you specify new tags as part of an `UpdateStackSet` action,
    /// CloudFormation
    /// checks to see if you have the required IAM permission to tag resources. If
    /// you omit tags
    /// that are currently associated with the StackSet from the list of tags you
    /// specify, CloudFormation
    /// assumes that you want to remove those tags from the StackSet, and checks to
    /// see if you have
    /// permission to untag resources. If you don't have the necessary
    /// permission(s), the entire
    /// `UpdateStackSet` action fails with an `access denied` error, and the
    /// StackSet is not updated.
    tags: ?[]const Tag = null,

    /// The structure that contains the template body, with a minimum length of 1
    /// byte and a
    /// maximum length of 51,200 bytes.
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `TemplateBody` or `TemplateURL`—or set
    /// `UsePreviousTemplate` to true.
    template_body: ?[]const u8 = null,

    /// The URL of a file that contains the template body. The URL must point to a
    /// template
    /// (maximum size: 1 MB) that is located in an Amazon S3 bucket or a Systems
    /// Manager document. The
    /// location for an Amazon S3 bucket must start with `https://`. S3 static
    /// website URLs are
    /// not supported.
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `TemplateBody` or `TemplateURL`—or set
    /// `UsePreviousTemplate` to true.
    template_url: ?[]const u8 = null,

    /// Use the existing template that's associated with the StackSet that you're
    /// updating.
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `TemplateBody` or `TemplateURL`—or set
    /// `UsePreviousTemplate` to true.
    use_previous_template: ?bool = null,
};

pub const UpdateStackSetOutput = struct {
    /// The unique ID for this StackSet operation.
    operation_id: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStackSetInput, options: Options) !UpdateStackSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStackSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=UpdateStackSet&Version=2010-05-15");
    if (input.accounts) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Accounts.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
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
    if (input.deployment_targets) |v| {
        if (v.account_filter_type) |sv| {
            try body_buf.appendSlice(allocator, "&DeploymentTargets.AccountFilterType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.accounts) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DeploymentTargets.Accounts.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
        if (v.accounts_url) |sv| {
            try body_buf.appendSlice(allocator, "&DeploymentTargets.AccountsUrl=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.organizational_unit_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DeploymentTargets.OrganizationalUnitIds.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
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
    if (input.operation_id) |v| {
        try body_buf.appendSlice(allocator, "&OperationId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.operation_preferences) |v| {
        if (v.concurrency_mode) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.ConcurrencyMode=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.failure_tolerance_count) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.FailureToleranceCount=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.failure_tolerance_percentage) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.FailureTolerancePercentage=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.max_concurrent_count) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.MaxConcurrentCount=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.max_concurrent_percentage) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.MaxConcurrentPercentage=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.region_concurrency_type) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.RegionConcurrencyType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.region_order) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OperationPreferences.RegionOrder.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
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
    if (input.regions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Regions.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStackSetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UpdateStackSetResult")) break;
            },
            else => {},
        }
    }

    var result: UpdateStackSetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try allocator.dupe(u8, try reader.readElementText());
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

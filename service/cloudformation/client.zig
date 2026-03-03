const aws = @import("aws");
const std = @import("std");

const activate_organizations_access = @import("activate_organizations_access.zig");
const activate_type = @import("activate_type.zig");
const batch_describe_type_configurations = @import("batch_describe_type_configurations.zig");
const cancel_update_stack = @import("cancel_update_stack.zig");
const continue_update_rollback = @import("continue_update_rollback.zig");
const create_change_set = @import("create_change_set.zig");
const create_generated_template = @import("create_generated_template.zig");
const create_stack = @import("create_stack.zig");
const create_stack_instances = @import("create_stack_instances.zig");
const create_stack_refactor = @import("create_stack_refactor.zig");
const create_stack_set = @import("create_stack_set.zig");
const deactivate_organizations_access = @import("deactivate_organizations_access.zig");
const deactivate_type = @import("deactivate_type.zig");
const delete_change_set = @import("delete_change_set.zig");
const delete_generated_template = @import("delete_generated_template.zig");
const delete_stack = @import("delete_stack.zig");
const delete_stack_instances = @import("delete_stack_instances.zig");
const delete_stack_set = @import("delete_stack_set.zig");
const deregister_type = @import("deregister_type.zig");
const describe_account_limits = @import("describe_account_limits.zig");
const describe_change_set = @import("describe_change_set.zig");
const describe_change_set_hooks = @import("describe_change_set_hooks.zig");
const describe_events = @import("describe_events.zig");
const describe_generated_template = @import("describe_generated_template.zig");
const describe_organizations_access = @import("describe_organizations_access.zig");
const describe_publisher = @import("describe_publisher.zig");
const describe_resource_scan = @import("describe_resource_scan.zig");
const describe_stack_drift_detection_status = @import("describe_stack_drift_detection_status.zig");
const describe_stack_events = @import("describe_stack_events.zig");
const describe_stack_instance = @import("describe_stack_instance.zig");
const describe_stack_refactor = @import("describe_stack_refactor.zig");
const describe_stack_resource = @import("describe_stack_resource.zig");
const describe_stack_resource_drifts = @import("describe_stack_resource_drifts.zig");
const describe_stack_resources = @import("describe_stack_resources.zig");
const describe_stack_set = @import("describe_stack_set.zig");
const describe_stack_set_operation = @import("describe_stack_set_operation.zig");
const describe_stacks = @import("describe_stacks.zig");
const describe_type = @import("describe_type.zig");
const describe_type_registration = @import("describe_type_registration.zig");
const detect_stack_drift = @import("detect_stack_drift.zig");
const detect_stack_resource_drift = @import("detect_stack_resource_drift.zig");
const detect_stack_set_drift = @import("detect_stack_set_drift.zig");
const estimate_template_cost = @import("estimate_template_cost.zig");
const execute_change_set = @import("execute_change_set.zig");
const execute_stack_refactor = @import("execute_stack_refactor.zig");
const get_generated_template = @import("get_generated_template.zig");
const get_hook_result = @import("get_hook_result.zig");
const get_stack_policy = @import("get_stack_policy.zig");
const get_template = @import("get_template.zig");
const get_template_summary = @import("get_template_summary.zig");
const import_stacks_to_stack_set = @import("import_stacks_to_stack_set.zig");
const list_change_sets = @import("list_change_sets.zig");
const list_exports = @import("list_exports.zig");
const list_generated_templates = @import("list_generated_templates.zig");
const list_hook_results = @import("list_hook_results.zig");
const list_imports = @import("list_imports.zig");
const list_resource_scan_related_resources = @import("list_resource_scan_related_resources.zig");
const list_resource_scan_resources = @import("list_resource_scan_resources.zig");
const list_resource_scans = @import("list_resource_scans.zig");
const list_stack_instance_resource_drifts = @import("list_stack_instance_resource_drifts.zig");
const list_stack_instances = @import("list_stack_instances.zig");
const list_stack_refactor_actions = @import("list_stack_refactor_actions.zig");
const list_stack_refactors = @import("list_stack_refactors.zig");
const list_stack_resources = @import("list_stack_resources.zig");
const list_stack_set_auto_deployment_targets = @import("list_stack_set_auto_deployment_targets.zig");
const list_stack_set_operation_results = @import("list_stack_set_operation_results.zig");
const list_stack_set_operations = @import("list_stack_set_operations.zig");
const list_stack_sets = @import("list_stack_sets.zig");
const list_stacks = @import("list_stacks.zig");
const list_type_registrations = @import("list_type_registrations.zig");
const list_type_versions = @import("list_type_versions.zig");
const list_types = @import("list_types.zig");
const publish_type = @import("publish_type.zig");
const record_handler_progress = @import("record_handler_progress.zig");
const register_publisher = @import("register_publisher.zig");
const register_type = @import("register_type.zig");
const rollback_stack = @import("rollback_stack.zig");
const set_stack_policy = @import("set_stack_policy.zig");
const set_type_configuration = @import("set_type_configuration.zig");
const set_type_default_version = @import("set_type_default_version.zig");
const signal_resource = @import("signal_resource.zig");
const start_resource_scan = @import("start_resource_scan.zig");
const stop_stack_set_operation = @import("stop_stack_set_operation.zig");
const test_type = @import("test_type.zig");
const update_generated_template = @import("update_generated_template.zig");
const update_stack = @import("update_stack.zig");
const update_stack_instances = @import("update_stack_instances.zig");
const update_stack_set = @import("update_stack_set.zig");
const update_termination_protection = @import("update_termination_protection.zig");
const validate_template = @import("validate_template.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudFormation";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Activate trusted access with Organizations. With trusted access between
    /// StackSets
    /// and Organizations activated, the management account has permissions to
    /// create
    /// and manage StackSets for your organization.
    pub fn activateOrganizationsAccess(self: *Self, allocator: std.mem.Allocator, input: activate_organizations_access.ActivateOrganizationsAccessInput, options: CallOptions) !activate_organizations_access.ActivateOrganizationsAccessOutput {
        return activate_organizations_access.execute(self, allocator, input, options);
    }

    /// Activates a public third-party extension, such as a resource or module, to
    /// make it
    /// available for use in stack templates in your current account and Region. It
    /// can also create
    /// CloudFormation Hooks, which allow you to evaluate resource configurations
    /// before CloudFormation
    /// provisions them. Hooks integrate with both CloudFormation and Cloud Control
    /// API operations.
    ///
    /// After you activate an extension, you can use
    /// [SetTypeConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_SetTypeConfiguration.html) to set specific properties for the extension.
    ///
    /// To see which extensions have been activated, use
    /// [ListTypes](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ListTypes.html). To see
    /// configuration details for an extension, use
    /// [DescribeType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DescribeType.html).
    ///
    /// For more information, see [Activate a
    /// third-party public extension in your
    /// account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-public-activate-extension.html) in the
    /// *CloudFormation User Guide*. For information about creating Hooks, see the
    /// [CloudFormation Hooks User
    /// Guide](https://docs.aws.amazon.com/cloudformation-cli/latest/hooks-userguide/what-is-cloudformation-hooks.html).
    pub fn activateType(self: *Self, allocator: std.mem.Allocator, input: activate_type.ActivateTypeInput, options: CallOptions) !activate_type.ActivateTypeOutput {
        return activate_type.execute(self, allocator, input, options);
    }

    /// Returns configuration data for the specified CloudFormation extensions, from
    /// the CloudFormation
    /// registry in your current account and Region.
    ///
    /// For more information, see [Edit configuration
    /// data for extensions in your
    /// account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-set-configuration.html) in the
    /// *CloudFormation User Guide*.
    pub fn batchDescribeTypeConfigurations(self: *Self, allocator: std.mem.Allocator, input: batch_describe_type_configurations.BatchDescribeTypeConfigurationsInput, options: CallOptions) !batch_describe_type_configurations.BatchDescribeTypeConfigurationsOutput {
        return batch_describe_type_configurations.execute(self, allocator, input, options);
    }

    /// Cancels an update on the specified stack. If the call completes
    /// successfully, the stack
    /// rolls back the update and reverts to the previous stack configuration.
    ///
    /// You can cancel only stacks that are in the `UPDATE_IN_PROGRESS` state.
    pub fn cancelUpdateStack(self: *Self, allocator: std.mem.Allocator, input: cancel_update_stack.CancelUpdateStackInput, options: CallOptions) !cancel_update_stack.CancelUpdateStackOutput {
        return cancel_update_stack.execute(self, allocator, input, options);
    }

    /// Continues rolling back a stack from `UPDATE_ROLLBACK_FAILED` to
    /// `UPDATE_ROLLBACK_COMPLETE` state. Depending on the cause of the failure, you
    /// can
    /// manually fix the error and continue the rollback. By continuing the
    /// rollback, you can return
    /// your stack to a working state (the `UPDATE_ROLLBACK_COMPLETE` state) and
    /// then try
    /// to update the stack again.
    ///
    /// A stack enters the `UPDATE_ROLLBACK_FAILED` state when CloudFormation can't
    /// roll
    /// back all changes after a failed stack update. For example, this might occur
    /// when a stack
    /// attempts to roll back to an old database that was deleted outside of
    /// CloudFormation. Because
    /// CloudFormation doesn't know the instance was deleted, it assumes the
    /// instance still exists and
    /// attempts to roll back to it, causing the update rollback to fail.
    ///
    /// For more information, see [Continue rolling back an
    /// update](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-continueupdaterollback.html) in the *CloudFormation User Guide*. For
    /// information for troubleshooting a failed update rollback, see [Update
    /// rollback
    /// failed](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html#troubleshooting-errors-update-rollback-failed).
    pub fn continueUpdateRollback(self: *Self, allocator: std.mem.Allocator, input: continue_update_rollback.ContinueUpdateRollbackInput, options: CallOptions) !continue_update_rollback.ContinueUpdateRollbackOutput {
        return continue_update_rollback.execute(self, allocator, input, options);
    }

    /// Creates a list of changes that will be applied to a stack so that you can
    /// review the
    /// changes before executing them. You can create a change set for a stack that
    /// doesn't exist or
    /// an existing stack. If you create a change set for a stack that doesn't
    /// exist, the change set
    /// shows all of the resources that CloudFormation will create. If you create a
    /// change set for an
    /// existing stack, CloudFormation compares the stack's information with the
    /// information that you
    /// submit in the change set and lists the differences. Use change sets to
    /// understand which
    /// resources CloudFormation will create or change, and how it will change
    /// resources in an existing
    /// stack, before you create or update a stack.
    ///
    /// To create a change set for a stack that doesn't exist, for the
    /// `ChangeSetType`
    /// parameter, specify `CREATE`. To create a change set for an existing stack,
    /// specify
    /// `UPDATE` for the `ChangeSetType` parameter. To create a change set for
    /// an import operation, specify `IMPORT` for the `ChangeSetType` parameter.
    /// After the `CreateChangeSet` call successfully completes, CloudFormation
    /// starts creating
    /// the change set. To check the status of the change set or to review it, use
    /// the DescribeChangeSet action.
    ///
    /// When you are satisfied with the changes the change set will make, execute
    /// the change set
    /// by using the ExecuteChangeSet action. CloudFormation doesn't make changes
    /// until
    /// you execute the change set.
    ///
    /// To create a change set for the entire stack hierarchy, set
    /// `IncludeNestedStacks` to `True`.
    pub fn createChangeSet(self: *Self, allocator: std.mem.Allocator, input: create_change_set.CreateChangeSetInput, options: CallOptions) !create_change_set.CreateChangeSetOutput {
        return create_change_set.execute(self, allocator, input, options);
    }

    /// Creates a template from existing resources that are not already managed with
    /// CloudFormation.
    /// You can check the status of the template generation using the
    /// `DescribeGeneratedTemplate` API action.
    pub fn createGeneratedTemplate(self: *Self, allocator: std.mem.Allocator, input: create_generated_template.CreateGeneratedTemplateInput, options: CallOptions) !create_generated_template.CreateGeneratedTemplateOutput {
        return create_generated_template.execute(self, allocator, input, options);
    }

    /// Creates a stack as specified in the template. After the call completes
    /// successfully, the
    /// stack creation starts. You can check the status of the stack through the
    /// DescribeStacks operation.
    ///
    /// For more information about creating a stack and monitoring stack progress,
    /// see [Managing Amazon Web Services
    /// resources as a single unit with CloudFormation
    /// stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacks.html) in the
    /// *CloudFormation User Guide*.
    pub fn createStack(self: *Self, allocator: std.mem.Allocator, input: create_stack.CreateStackInput, options: CallOptions) !create_stack.CreateStackOutput {
        return create_stack.execute(self, allocator, input, options);
    }

    /// Creates stack instances for the specified accounts, within the specified
    /// Amazon Web Services Regions. A
    /// stack instance refers to a stack in a specific account and Region. You must
    /// specify at least
    /// one value for either `Accounts` or `DeploymentTargets`, and you must
    /// specify at least one value for `Regions`.
    ///
    /// The maximum number of organizational unit (OUs) supported by a
    /// `CreateStackInstances` operation is 50.
    ///
    /// If you need more than 50, consider the following options:
    ///
    /// * *Batch processing:* If you don't want to expose your OU
    /// hierarchy, split up the operations into multiple calls with less than 50 OUs
    /// each.
    ///
    /// * *Parent OU strategy:* If you don't mind exposing the OU
    /// hierarchy, target a parent OU that contains all desired child OUs.
    pub fn createStackInstances(self: *Self, allocator: std.mem.Allocator, input: create_stack_instances.CreateStackInstancesInput, options: CallOptions) !create_stack_instances.CreateStackInstancesOutput {
        return create_stack_instances.execute(self, allocator, input, options);
    }

    /// Creates a refactor across multiple stacks, with the list of stacks and
    /// resources that are
    /// affected.
    pub fn createStackRefactor(self: *Self, allocator: std.mem.Allocator, input: create_stack_refactor.CreateStackRefactorInput, options: CallOptions) !create_stack_refactor.CreateStackRefactorOutput {
        return create_stack_refactor.execute(self, allocator, input, options);
    }

    /// Creates a StackSet.
    pub fn createStackSet(self: *Self, allocator: std.mem.Allocator, input: create_stack_set.CreateStackSetInput, options: CallOptions) !create_stack_set.CreateStackSetOutput {
        return create_stack_set.execute(self, allocator, input, options);
    }

    /// Deactivates trusted access with Organizations. If trusted access is
    /// deactivated,
    /// the management account does not have permissions to create and manage
    /// service-managed StackSets for your organization.
    pub fn deactivateOrganizationsAccess(self: *Self, allocator: std.mem.Allocator, input: deactivate_organizations_access.DeactivateOrganizationsAccessInput, options: CallOptions) !deactivate_organizations_access.DeactivateOrganizationsAccessOutput {
        return deactivate_organizations_access.execute(self, allocator, input, options);
    }

    /// Deactivates a public third-party extension, such as a resource or module, or
    /// a CloudFormation
    /// Hook when you no longer use it.
    ///
    /// Deactivating an extension deletes the configuration details that are
    /// associated with it.
    /// To temporarily disable a CloudFormation Hook instead, you can use
    /// [SetTypeConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_SetTypeConfiguration.html).
    ///
    /// Once deactivated, an extension can't be used in any CloudFormation
    /// operation. This includes
    /// stack update operations where the stack template includes the extension,
    /// even if no updates
    /// are being made to the extension. In addition, deactivated extensions aren't
    /// automatically
    /// updated if a new version of the extension is released.
    ///
    /// To see which extensions are currently activated, use
    /// [ListTypes](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ListTypes.html).
    pub fn deactivateType(self: *Self, allocator: std.mem.Allocator, input: deactivate_type.DeactivateTypeInput, options: CallOptions) !deactivate_type.DeactivateTypeOutput {
        return deactivate_type.execute(self, allocator, input, options);
    }

    /// Deletes the specified change set. Deleting change sets ensures that no one
    /// executes the
    /// wrong change set.
    ///
    /// If the call successfully completes, CloudFormation successfully deleted the
    /// change set.
    ///
    /// If `IncludeNestedStacks` specifies `True` during the creation of the
    /// nested change set, then `DeleteChangeSet` will delete all change sets that
    /// belong
    /// to the stacks hierarchy and will also delete all change sets for nested
    /// stacks with the status
    /// of `REVIEW_IN_PROGRESS`.
    pub fn deleteChangeSet(self: *Self, allocator: std.mem.Allocator, input: delete_change_set.DeleteChangeSetInput, options: CallOptions) !delete_change_set.DeleteChangeSetOutput {
        return delete_change_set.execute(self, allocator, input, options);
    }

    /// Deleted a generated template.
    pub fn deleteGeneratedTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_generated_template.DeleteGeneratedTemplateInput, options: CallOptions) !delete_generated_template.DeleteGeneratedTemplateOutput {
        return delete_generated_template.execute(self, allocator, input, options);
    }

    /// Deletes a specified stack. Once the call completes successfully, stack
    /// deletion starts.
    /// Deleted stacks don't show up in the DescribeStacks operation if the deletion
    /// has been completed successfully.
    ///
    /// For more information about deleting a stack, see [Delete a stack from
    /// the CloudFormation
    /// console](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-delete-stack.html) in the *CloudFormation User Guide*.
    pub fn deleteStack(self: *Self, allocator: std.mem.Allocator, input: delete_stack.DeleteStackInput, options: CallOptions) !delete_stack.DeleteStackOutput {
        return delete_stack.execute(self, allocator, input, options);
    }

    /// Deletes stack instances for the specified accounts, in the specified Amazon
    /// Web Services Regions.
    ///
    /// The maximum number of organizational unit (OUs) supported by a
    /// `DeleteStackInstances` operation is 50.
    ///
    /// If you need more than 50, consider the following options:
    ///
    /// * *Batch processing:* If you don't want to expose your OU
    /// hierarchy, split up the operations into multiple calls with less than 50 OUs
    /// each.
    ///
    /// * *Parent OU strategy:* If you don't mind exposing the OU
    /// hierarchy, target a parent OU that contains all desired child OUs.
    pub fn deleteStackInstances(self: *Self, allocator: std.mem.Allocator, input: delete_stack_instances.DeleteStackInstancesInput, options: CallOptions) !delete_stack_instances.DeleteStackInstancesOutput {
        return delete_stack_instances.execute(self, allocator, input, options);
    }

    /// Deletes a StackSet. Before you can delete a StackSet, all its member stack
    /// instances must
    /// be deleted. For more information about how to complete this, see
    /// DeleteStackInstances.
    pub fn deleteStackSet(self: *Self, allocator: std.mem.Allocator, input: delete_stack_set.DeleteStackSetInput, options: CallOptions) !delete_stack_set.DeleteStackSetOutput {
        return delete_stack_set.execute(self, allocator, input, options);
    }

    /// Marks an extension or extension version as `DEPRECATED` in the
    /// CloudFormation
    /// registry, removing it from active use. Deprecated extensions or extension
    /// versions cannot be
    /// used in CloudFormation operations.
    ///
    /// To deregister an entire extension, you must individually deregister all
    /// active versions of
    /// that extension. If an extension has only a single active version,
    /// deregistering that version
    /// results in the extension itself being deregistered and marked as deprecated
    /// in the
    /// registry.
    ///
    /// You can't deregister the default version of an extension if there are other
    /// active version
    /// of that extension. If you do deregister the default version of an extension,
    /// the extension
    /// type itself is deregistered as well and marked as deprecated.
    ///
    /// To view the deprecation status of an extension or extension version, use
    /// [DescribeType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DescribeType.html).
    ///
    /// For more information, see [Remove
    /// third-party private extensions from your
    /// account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-private-deregister-extension.html) in the
    /// *CloudFormation User Guide*.
    pub fn deregisterType(self: *Self, allocator: std.mem.Allocator, input: deregister_type.DeregisterTypeInput, options: CallOptions) !deregister_type.DeregisterTypeOutput {
        return deregister_type.execute(self, allocator, input, options);
    }

    /// Retrieves your account's CloudFormation limits, such as the maximum number
    /// of stacks that you
    /// can create in your account. For more information about account limits, see
    /// [Understand CloudFormation
    /// quotas](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cloudformation-limits.html) in the *CloudFormation User Guide*.
    pub fn describeAccountLimits(self: *Self, allocator: std.mem.Allocator, input: describe_account_limits.DescribeAccountLimitsInput, options: CallOptions) !describe_account_limits.DescribeAccountLimitsOutput {
        return describe_account_limits.execute(self, allocator, input, options);
    }

    /// Returns the inputs for the change set and a list of changes that
    /// CloudFormation will make if
    /// you execute the change set. For more information, see [Update
    /// CloudFormation stacks using change
    /// sets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-changesets.html) in the
    /// *CloudFormation User Guide*.
    pub fn describeChangeSet(self: *Self, allocator: std.mem.Allocator, input: describe_change_set.DescribeChangeSetInput, options: CallOptions) !describe_change_set.DescribeChangeSetOutput {
        return describe_change_set.execute(self, allocator, input, options);
    }

    /// Returns Hook-related information for the change set and a list of changes
    /// that
    /// CloudFormation makes when you run the change set.
    pub fn describeChangeSetHooks(self: *Self, allocator: std.mem.Allocator, input: describe_change_set_hooks.DescribeChangeSetHooksInput, options: CallOptions) !describe_change_set_hooks.DescribeChangeSetHooksOutput {
        return describe_change_set_hooks.execute(self, allocator, input, options);
    }

    /// Returns CloudFormation events based on flexible query criteria. Groups
    /// events by operation ID,
    /// enabling you to focus on individual stack operations during deployment.
    ///
    /// An operation is any action performed on a stack, including stack lifecycle
    /// actions
    /// (Create, Update, Delete, Rollback), change set creation, nested stack
    /// creation, and automatic
    /// rollbacks triggered by failures. Each operation has a unique identifier
    /// (Operation ID) and
    /// represents a discrete change attempt on the stack.
    ///
    /// Returns different types of events including:
    ///
    /// * **Progress events** - Status updates during stack operation
    /// execution.
    ///
    /// * **Validation errors** - Failures from CloudFormation Early
    /// Validations.
    ///
    /// * **Provisioning errors** - Resource creation and update
    /// failures.
    ///
    /// * **Hook invocation errors** - Failures from CloudFormation
    /// Hook during stack operations.
    ///
    /// One of `ChangeSetName`, `OperationId` or `StackName`
    /// must be specified as input.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: CallOptions) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Describes a generated template. The output includes details about the
    /// progress of the
    /// creation of a generated template started by a `CreateGeneratedTemplate` API
    /// action
    /// or the update of a generated template started with an
    /// `UpdateGeneratedTemplate` API
    /// action.
    pub fn describeGeneratedTemplate(self: *Self, allocator: std.mem.Allocator, input: describe_generated_template.DescribeGeneratedTemplateInput, options: CallOptions) !describe_generated_template.DescribeGeneratedTemplateOutput {
        return describe_generated_template.execute(self, allocator, input, options);
    }

    /// Retrieves information about the account's `OrganizationAccess` status. This
    /// API
    /// can be called either by the management account or the delegated
    /// administrator by using the
    /// `CallAs` parameter. This API can also be called without the `CallAs`
    /// parameter by the management account.
    pub fn describeOrganizationsAccess(self: *Self, allocator: std.mem.Allocator, input: describe_organizations_access.DescribeOrganizationsAccessInput, options: CallOptions) !describe_organizations_access.DescribeOrganizationsAccessOutput {
        return describe_organizations_access.execute(self, allocator, input, options);
    }

    /// Returns information about a CloudFormation extension publisher.
    ///
    /// If you don't supply a `PublisherId`, and you have registered as an extension
    /// publisher, `DescribePublisher` returns information about your own publisher
    /// account.
    ///
    /// For more information about registering as a publisher, see:
    ///
    /// *
    ///   [RegisterPublisher](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterPublisher.html)
    ///
    /// * [Publishing extensions
    /// to make them available for public
    /// use](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/publish-extension.html) in the
    /// *CloudFormation Command Line Interface (CLI) User Guide*
    pub fn describePublisher(self: *Self, allocator: std.mem.Allocator, input: describe_publisher.DescribePublisherInput, options: CallOptions) !describe_publisher.DescribePublisherOutput {
        return describe_publisher.execute(self, allocator, input, options);
    }

    /// Describes details of a resource scan.
    pub fn describeResourceScan(self: *Self, allocator: std.mem.Allocator, input: describe_resource_scan.DescribeResourceScanInput, options: CallOptions) !describe_resource_scan.DescribeResourceScanOutput {
        return describe_resource_scan.execute(self, allocator, input, options);
    }

    /// Returns information about a stack drift detection operation. A stack drift
    /// detection
    /// operation detects whether a stack's actual configuration differs, or has
    /// *drifted*, from its expected configuration, as defined in the stack
    /// template and any values specified as template parameters. A stack is
    /// considered to have
    /// drifted if one or more of its resources have drifted. For more information
    /// about stack and
    /// resource drift, see [Detect unmanaged
    /// configuration changes to stacks and resources with drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).
    ///
    /// Use DetectStackDrift to initiate a stack drift detection operation.
    /// `DetectStackDrift` returns a `StackDriftDetectionId` you can use to
    /// monitor the progress of the operation using
    /// `DescribeStackDriftDetectionStatus`.
    /// Once the drift detection operation has completed, use
    /// DescribeStackResourceDrifts to return drift information about the stack and
    /// its
    /// resources.
    pub fn describeStackDriftDetectionStatus(self: *Self, allocator: std.mem.Allocator, input: describe_stack_drift_detection_status.DescribeStackDriftDetectionStatusInput, options: CallOptions) !describe_stack_drift_detection_status.DescribeStackDriftDetectionStatusOutput {
        return describe_stack_drift_detection_status.execute(self, allocator, input, options);
    }

    /// Returns all stack related events for a specified stack in reverse
    /// chronological order. For
    /// more information about a stack's event history, see [Understand
    /// CloudFormation stack creation
    /// events](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stack-resource-configuration-complete.html) in the
    /// *CloudFormation User Guide*.
    ///
    /// You can list events for stacks that have failed to create or have been
    /// deleted by
    /// specifying the unique stack identifier (stack ID).
    pub fn describeStackEvents(self: *Self, allocator: std.mem.Allocator, input: describe_stack_events.DescribeStackEventsInput, options: CallOptions) !describe_stack_events.DescribeStackEventsOutput {
        return describe_stack_events.execute(self, allocator, input, options);
    }

    /// Returns the stack instance that's associated with the specified StackSet,
    /// Amazon Web Services account,
    /// and Amazon Web Services Region.
    ///
    /// For a list of stack instances that are associated with a specific StackSet,
    /// use ListStackInstances.
    pub fn describeStackInstance(self: *Self, allocator: std.mem.Allocator, input: describe_stack_instance.DescribeStackInstanceInput, options: CallOptions) !describe_stack_instance.DescribeStackInstanceOutput {
        return describe_stack_instance.execute(self, allocator, input, options);
    }

    /// Describes the stack refactor status.
    pub fn describeStackRefactor(self: *Self, allocator: std.mem.Allocator, input: describe_stack_refactor.DescribeStackRefactorInput, options: CallOptions) !describe_stack_refactor.DescribeStackRefactorOutput {
        return describe_stack_refactor.execute(self, allocator, input, options);
    }

    /// Returns a description of the specified resource in the specified stack.
    ///
    /// For deleted stacks, DescribeStackResource returns resource information for
    /// up to 90 days
    /// after the stack has been deleted.
    pub fn describeStackResource(self: *Self, allocator: std.mem.Allocator, input: describe_stack_resource.DescribeStackResourceInput, options: CallOptions) !describe_stack_resource.DescribeStackResourceOutput {
        return describe_stack_resource.execute(self, allocator, input, options);
    }

    /// Returns drift information for the resources that have been checked for drift
    /// in the
    /// specified stack. This includes actual and expected configuration values for
    /// resources where
    /// CloudFormation detects configuration drift.
    ///
    /// For a given stack, there will be one `StackResourceDrift` for each stack
    /// resource that has been checked for drift. Resources that haven't yet been
    /// checked for drift
    /// aren't included. Resources that don't currently support drift detection
    /// aren't checked, and so
    /// not included. For a list of resources that support drift detection, see
    /// [Resource
    /// type support for imports and drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html).
    ///
    /// Use DetectStackResourceDrift to detect drift on individual resources, or
    /// DetectStackDrift to detect drift on all supported resources for a given
    /// stack.
    pub fn describeStackResourceDrifts(self: *Self, allocator: std.mem.Allocator, input: describe_stack_resource_drifts.DescribeStackResourceDriftsInput, options: CallOptions) !describe_stack_resource_drifts.DescribeStackResourceDriftsOutput {
        return describe_stack_resource_drifts.execute(self, allocator, input, options);
    }

    /// Returns Amazon Web Services resource descriptions for running and deleted
    /// stacks. If
    /// `StackName` is specified, all the associated resources that are part of the
    /// stack
    /// are returned. If `PhysicalResourceId` is specified, the associated resources
    /// of the
    /// stack that the resource belongs to are returned.
    ///
    /// Only the first 100 resources will be returned. If your stack has more
    /// resources than
    /// this, you should use `ListStackResources` instead.
    ///
    /// For deleted stacks, `DescribeStackResources` returns resource information
    /// for
    /// up to 90 days after the stack has been deleted.
    ///
    /// You must specify either `StackName` or `PhysicalResourceId`, but not
    /// both. In addition, you can specify `LogicalResourceId` to filter the
    /// returned
    /// result. For more information about resources, the `LogicalResourceId` and
    /// `PhysicalResourceId`, see the [CloudFormation User
    /// Guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/).
    ///
    /// A `ValidationError` is returned if you specify both `StackName`
    /// and `PhysicalResourceId` in the same request.
    pub fn describeStackResources(self: *Self, allocator: std.mem.Allocator, input: describe_stack_resources.DescribeStackResourcesInput, options: CallOptions) !describe_stack_resources.DescribeStackResourcesOutput {
        return describe_stack_resources.execute(self, allocator, input, options);
    }

    /// Returns the description of the specified StackSet.
    ///
    /// This API provides *strongly consistent* reads meaning it will always
    /// return the most up-to-date data.
    pub fn describeStackSet(self: *Self, allocator: std.mem.Allocator, input: describe_stack_set.DescribeStackSetInput, options: CallOptions) !describe_stack_set.DescribeStackSetOutput {
        return describe_stack_set.execute(self, allocator, input, options);
    }

    /// Returns the description of the specified StackSet operation.
    ///
    /// This API provides *strongly consistent* reads meaning it will always
    /// return the most up-to-date data.
    pub fn describeStackSetOperation(self: *Self, allocator: std.mem.Allocator, input: describe_stack_set_operation.DescribeStackSetOperationInput, options: CallOptions) !describe_stack_set_operation.DescribeStackSetOperationOutput {
        return describe_stack_set_operation.execute(self, allocator, input, options);
    }

    /// Returns the description for the specified stack; if no stack name was
    /// specified, then it
    /// returns the description for all the stacks created. For more information
    /// about a stack's event
    /// history, see [Understand CloudFormation stack creation
    /// events](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stack-resource-configuration-complete.html) in the
    /// *CloudFormation User Guide*.
    ///
    /// If the stack doesn't exist, a `ValidationError` is returned.
    pub fn describeStacks(self: *Self, allocator: std.mem.Allocator, input: describe_stacks.DescribeStacksInput, options: CallOptions) !describe_stacks.DescribeStacksOutput {
        return describe_stacks.execute(self, allocator, input, options);
    }

    /// Returns detailed information about an extension from the CloudFormation
    /// registry in your
    /// current account and Region.
    ///
    /// If you specify a `VersionId`, `DescribeType` returns information
    /// about that specific extension version. Otherwise, it returns information
    /// about the default
    /// extension version.
    ///
    /// For more information, see [Edit configuration
    /// data for extensions in your
    /// account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-set-configuration.html) in the
    /// *CloudFormation User Guide*.
    pub fn describeType(self: *Self, allocator: std.mem.Allocator, input: describe_type.DescribeTypeInput, options: CallOptions) !describe_type.DescribeTypeOutput {
        return describe_type.execute(self, allocator, input, options);
    }

    /// Returns information about an extension's registration, including its current
    /// status and
    /// type and version identifiers.
    ///
    /// When you initiate a registration request using RegisterType, you can
    /// then use DescribeTypeRegistration to monitor the progress of that
    /// registration request.
    ///
    /// Once the registration request has completed, use DescribeType to return
    /// detailed information about an extension.
    pub fn describeTypeRegistration(self: *Self, allocator: std.mem.Allocator, input: describe_type_registration.DescribeTypeRegistrationInput, options: CallOptions) !describe_type_registration.DescribeTypeRegistrationOutput {
        return describe_type_registration.execute(self, allocator, input, options);
    }

    /// Detects whether a stack's actual configuration differs, or has
    /// *drifted*, from its expected configuration, as defined in the stack
    /// template and any values specified as template parameters. For each resource
    /// in the stack that
    /// supports drift detection, CloudFormation compares the actual configuration
    /// of the resource with
    /// its expected template configuration. Only resource properties explicitly
    /// defined in the stack
    /// template are checked for drift. A stack is considered to have drifted if one
    /// or more of its
    /// resources differ from their expected template configurations. For more
    /// information, see [Detect unmanaged configuration changes to stacks and
    /// resources with drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).
    ///
    /// Use `DetectStackDrift` to detect drift on all supported resources for a
    /// given
    /// stack, or DetectStackResourceDrift to detect drift on individual
    /// resources.
    ///
    /// For a list of stack resources that currently support drift detection, see
    /// [Resource
    /// type support for imports and drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html).
    ///
    /// `DetectStackDrift` can take up to several minutes, depending on the number
    /// of
    /// resources contained within the stack. Use DescribeStackDriftDetectionStatus
    /// to monitor the progress of a detect stack drift operation. Once the drift
    /// detection operation
    /// has completed, use DescribeStackResourceDrifts to return drift information
    /// about the stack and its resources.
    ///
    /// When detecting drift on a stack, CloudFormation doesn't detect drift on any
    /// nested stacks
    /// belonging to that stack. Perform `DetectStackDrift` directly on the nested
    /// stack
    /// itself.
    pub fn detectStackDrift(self: *Self, allocator: std.mem.Allocator, input: detect_stack_drift.DetectStackDriftInput, options: CallOptions) !detect_stack_drift.DetectStackDriftOutput {
        return detect_stack_drift.execute(self, allocator, input, options);
    }

    /// Returns information about whether a resource's actual configuration differs,
    /// or has
    /// *drifted*, from its expected configuration, as defined in the stack
    /// template and any values specified as template parameters. This information
    /// includes actual and
    /// expected property values for resources in which CloudFormation detects
    /// drift. Only resource
    /// properties explicitly defined in the stack template are checked for drift.
    /// For more
    /// information about stack and resource drift, see [Detect unmanaged
    /// configuration changes to stacks and resources with drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).
    ///
    /// Use `DetectStackResourceDrift` to detect drift on individual resources, or
    /// DetectStackDrift to detect drift on all resources in a given stack that
    /// support drift detection.
    ///
    /// Resources that don't currently support drift detection can't be checked. For
    /// a list of
    /// resources that support drift detection, see [Resource
    /// type support for imports and drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html).
    pub fn detectStackResourceDrift(self: *Self, allocator: std.mem.Allocator, input: detect_stack_resource_drift.DetectStackResourceDriftInput, options: CallOptions) !detect_stack_resource_drift.DetectStackResourceDriftOutput {
        return detect_stack_resource_drift.execute(self, allocator, input, options);
    }

    /// Detect drift on a StackSet. When CloudFormation performs drift detection on
    /// a StackSet, it
    /// performs drift detection on the stack associated with each stack instance in
    /// the StackSet. For
    /// more information, see [Performing drift detection on
    /// CloudFormation
    /// StackSets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-drift.html).
    ///
    /// `DetectStackSetDrift` returns the `OperationId` of the StackSet
    /// drift detection operation. Use this operation id with
    /// DescribeStackSetOperation to monitor the progress of the drift detection
    /// operation. The drift detection operation may take some time, depending on
    /// the number of stack
    /// instances included in the StackSet, in addition to the number of resources
    /// included in each
    /// stack.
    ///
    /// Once the operation has completed, use the following actions to return drift
    /// information:
    ///
    /// * Use DescribeStackSet to return detailed information about the stack
    /// set, including detailed information about the last *completed* drift
    /// operation performed on the StackSet. (Information about drift operations
    /// that are in
    /// progress isn't included.)
    ///
    /// * Use ListStackInstances to return a list of stack instances belonging
    /// to the StackSet, including the drift status and last drift time checked of
    /// each
    /// instance.
    ///
    /// * Use DescribeStackInstance to return detailed information about a
    /// specific stack instance, including its drift status and last drift time
    /// checked.
    ///
    /// You can only run a single drift detection operation on a given StackSet at
    /// one
    /// time.
    ///
    /// To stop a drift detection StackSet operation, use StopStackSetOperation.
    pub fn detectStackSetDrift(self: *Self, allocator: std.mem.Allocator, input: detect_stack_set_drift.DetectStackSetDriftInput, options: CallOptions) !detect_stack_set_drift.DetectStackSetDriftOutput {
        return detect_stack_set_drift.execute(self, allocator, input, options);
    }

    /// Returns the estimated monthly cost of a template. The return value is an
    /// Amazon Web Services Simple
    /// Monthly Calculator URL with a query string that describes the resources
    /// required to run the
    /// template.
    pub fn estimateTemplateCost(self: *Self, allocator: std.mem.Allocator, input: estimate_template_cost.EstimateTemplateCostInput, options: CallOptions) !estimate_template_cost.EstimateTemplateCostOutput {
        return estimate_template_cost.execute(self, allocator, input, options);
    }

    /// Updates a stack using the input information that was provided when the
    /// specified change
    /// set was created. After the call successfully completes, CloudFormation
    /// starts updating the stack.
    /// Use the DescribeStacks action to view the status of the update.
    ///
    /// When you execute a change set, CloudFormation deletes all other change sets
    /// associated with
    /// the stack because they aren't valid for the updated stack.
    ///
    /// If a stack policy is associated with the stack, CloudFormation enforces the
    /// policy during the
    /// update. You can't specify a temporary stack policy that overrides the
    /// current policy.
    ///
    /// To create a change set for the entire stack hierarchy, `IncludeNestedStacks`
    /// must have been set to `True`.
    pub fn executeChangeSet(self: *Self, allocator: std.mem.Allocator, input: execute_change_set.ExecuteChangeSetInput, options: CallOptions) !execute_change_set.ExecuteChangeSetOutput {
        return execute_change_set.execute(self, allocator, input, options);
    }

    /// Executes the stack refactor operation.
    pub fn executeStackRefactor(self: *Self, allocator: std.mem.Allocator, input: execute_stack_refactor.ExecuteStackRefactorInput, options: CallOptions) !execute_stack_refactor.ExecuteStackRefactorOutput {
        return execute_stack_refactor.execute(self, allocator, input, options);
    }

    /// Retrieves a generated template. If the template is in an `InProgress` or
    /// `Pending` status then the template returned will be the template when the
    /// template was last in a `Complete` status. If the template has not yet been
    /// in a
    /// `Complete` status then an empty template will be returned.
    pub fn getGeneratedTemplate(self: *Self, allocator: std.mem.Allocator, input: get_generated_template.GetGeneratedTemplateInput, options: CallOptions) !get_generated_template.GetGeneratedTemplateOutput {
        return get_generated_template.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information and remediation guidance for a Hook
    /// invocation
    /// result.
    ///
    /// If the Hook uses a KMS key to encrypt annotations, callers of the
    /// `GetHookResult` operation must have `kms:Decrypt` permissions. For
    /// more information, see [KMS key policy
    /// and permissions for encrypting CloudFormation Hooks results at
    /// rest](https://docs.aws.amazon.com/cloudformation-cli/latest/hooks-userguide/hooks-kms-key-policy.html) in the
    /// *CloudFormation Hooks User Guide*.
    pub fn getHookResult(self: *Self, allocator: std.mem.Allocator, input: get_hook_result.GetHookResultInput, options: CallOptions) !get_hook_result.GetHookResultOutput {
        return get_hook_result.execute(self, allocator, input, options);
    }

    /// Returns the stack policy for a specified stack. If a stack doesn't have a
    /// policy, a null
    /// value is returned.
    pub fn getStackPolicy(self: *Self, allocator: std.mem.Allocator, input: get_stack_policy.GetStackPolicyInput, options: CallOptions) !get_stack_policy.GetStackPolicyOutput {
        return get_stack_policy.execute(self, allocator, input, options);
    }

    /// Returns the template body for a specified stack. You can get the template
    /// for running or
    /// deleted stacks.
    ///
    /// For deleted stacks, `GetTemplate` returns the template for up to 90 days
    /// after
    /// the stack has been deleted.
    ///
    /// If the template doesn't exist, a `ValidationError` is returned.
    pub fn getTemplate(self: *Self, allocator: std.mem.Allocator, input: get_template.GetTemplateInput, options: CallOptions) !get_template.GetTemplateOutput {
        return get_template.execute(self, allocator, input, options);
    }

    /// Returns information about a new or existing template. The
    /// `GetTemplateSummary`
    /// action is useful for viewing parameter information, such as default
    /// parameter values and
    /// parameter types, before you create or update a stack or StackSet.
    ///
    /// You can use the `GetTemplateSummary` action when you submit a template, or
    /// you
    /// can get template information for a StackSet, or a running or deleted stack.
    ///
    /// For deleted stacks, `GetTemplateSummary` returns the template information
    /// for
    /// up to 90 days after the stack has been deleted. If the template doesn't
    /// exist, a
    /// `ValidationError` is returned.
    pub fn getTemplateSummary(self: *Self, allocator: std.mem.Allocator, input: get_template_summary.GetTemplateSummaryInput, options: CallOptions) !get_template_summary.GetTemplateSummaryOutput {
        return get_template_summary.execute(self, allocator, input, options);
    }

    /// Import existing stacks into a new StackSets. Use the stack import operation
    /// to import up
    /// to 10 stacks into a new StackSet in the same account as the source stack or
    /// in a different
    /// administrator account and Region, by specifying the stack ID of the stack
    /// you intend to
    /// import.
    pub fn importStacksToStackSet(self: *Self, allocator: std.mem.Allocator, input: import_stacks_to_stack_set.ImportStacksToStackSetInput, options: CallOptions) !import_stacks_to_stack_set.ImportStacksToStackSetOutput {
        return import_stacks_to_stack_set.execute(self, allocator, input, options);
    }

    /// Returns the ID and status of each active change set for a stack. For
    /// example, CloudFormation
    /// lists change sets that are in the `CREATE_IN_PROGRESS` or
    /// `CREATE_PENDING` state.
    pub fn listChangeSets(self: *Self, allocator: std.mem.Allocator, input: list_change_sets.ListChangeSetsInput, options: CallOptions) !list_change_sets.ListChangeSetsOutput {
        return list_change_sets.execute(self, allocator, input, options);
    }

    /// Lists all exported output values in the account and Region in which you call
    /// this action.
    /// Use this action to see the exported output values that you can import into
    /// other stacks. To
    /// import values, use the [
    /// Fn::ImportValue](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/intrinsic-function-reference-importvalue.html) function.
    ///
    /// For more information, see [Get exported outputs
    /// from a deployed CloudFormation
    /// stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-exports.html).
    pub fn listExports(self: *Self, allocator: std.mem.Allocator, input: list_exports.ListExportsInput, options: CallOptions) !list_exports.ListExportsOutput {
        return list_exports.execute(self, allocator, input, options);
    }

    /// Lists your generated templates in this Region.
    pub fn listGeneratedTemplates(self: *Self, allocator: std.mem.Allocator, input: list_generated_templates.ListGeneratedTemplatesInput, options: CallOptions) !list_generated_templates.ListGeneratedTemplatesOutput {
        return list_generated_templates.execute(self, allocator, input, options);
    }

    /// Returns summaries of invoked Hooks. For more information, see [View
    /// invocation
    /// summaries for CloudFormation
    /// Hooks](https://docs.aws.amazon.com/cloudformation-cli/latest/hooks-userguide/hooks-view-invocations.html) in the *CloudFormation Hooks User Guide*.
    ///
    /// This operation supports the following parameter combinations:
    ///
    /// * No parameters: Returns all Hook invocation summaries.
    ///
    /// * `TypeArn` only: Returns summaries for a specific Hook.
    ///
    /// * `TypeArn` and `Status`: Returns summaries for a specific Hook
    /// filtered by status.
    ///
    /// * `TargetId` and `TargetType`: Returns summaries for a specific
    /// Hook invocation target.
    pub fn listHookResults(self: *Self, allocator: std.mem.Allocator, input: list_hook_results.ListHookResultsInput, options: CallOptions) !list_hook_results.ListHookResultsOutput {
        return list_hook_results.execute(self, allocator, input, options);
    }

    /// Lists all stacks that are importing an exported output value. To modify or
    /// remove an
    /// exported output value, first use this action to see which stacks are using
    /// it. To see the
    /// exported output values in your account, see ListExports.
    ///
    /// For more information about importing an exported output value, see the
    /// [Fn::ImportValue](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/intrinsic-function-reference-importvalue.html) function.
    pub fn listImports(self: *Self, allocator: std.mem.Allocator, input: list_imports.ListImportsInput, options: CallOptions) !list_imports.ListImportsOutput {
        return list_imports.execute(self, allocator, input, options);
    }

    /// Lists the related resources for a list of resources from a resource scan.
    /// The response
    /// indicates whether each returned resource is already managed by
    /// CloudFormation.
    pub fn listResourceScanRelatedResources(self: *Self, allocator: std.mem.Allocator, input: list_resource_scan_related_resources.ListResourceScanRelatedResourcesInput, options: CallOptions) !list_resource_scan_related_resources.ListResourceScanRelatedResourcesOutput {
        return list_resource_scan_related_resources.execute(self, allocator, input, options);
    }

    /// Lists the resources from a resource scan. The results can be filtered by
    /// resource
    /// identifier, resource type prefix, tag key, and tag value. Only resources
    /// that match all
    /// specified filters are returned. The response indicates whether each returned
    /// resource is
    /// already managed by CloudFormation.
    pub fn listResourceScanResources(self: *Self, allocator: std.mem.Allocator, input: list_resource_scan_resources.ListResourceScanResourcesInput, options: CallOptions) !list_resource_scan_resources.ListResourceScanResourcesOutput {
        return list_resource_scan_resources.execute(self, allocator, input, options);
    }

    /// List the resource scans from newest to oldest. By default it will return up
    /// to 10 resource
    /// scans.
    pub fn listResourceScans(self: *Self, allocator: std.mem.Allocator, input: list_resource_scans.ListResourceScansInput, options: CallOptions) !list_resource_scans.ListResourceScansOutput {
        return list_resource_scans.execute(self, allocator, input, options);
    }

    /// Returns drift information for resources in a stack instance.
    ///
    /// `ListStackInstanceResourceDrifts` returns drift information for the most
    /// recent drift detection operation. If an operation is in progress, it may
    /// only return partial
    /// results.
    pub fn listStackInstanceResourceDrifts(self: *Self, allocator: std.mem.Allocator, input: list_stack_instance_resource_drifts.ListStackInstanceResourceDriftsInput, options: CallOptions) !list_stack_instance_resource_drifts.ListStackInstanceResourceDriftsOutput {
        return list_stack_instance_resource_drifts.execute(self, allocator, input, options);
    }

    /// Returns summary information about stack instances that are associated with
    /// the specified
    /// StackSet. You can filter for stack instances that are associated with a
    /// specific Amazon Web Services account
    /// name or Region, or that have a specific status.
    pub fn listStackInstances(self: *Self, allocator: std.mem.Allocator, input: list_stack_instances.ListStackInstancesInput, options: CallOptions) !list_stack_instances.ListStackInstancesOutput {
        return list_stack_instances.execute(self, allocator, input, options);
    }

    /// Lists the stack refactor actions that will be taken after calling the
    /// ExecuteStackRefactor action.
    pub fn listStackRefactorActions(self: *Self, allocator: std.mem.Allocator, input: list_stack_refactor_actions.ListStackRefactorActionsInput, options: CallOptions) !list_stack_refactor_actions.ListStackRefactorActionsOutput {
        return list_stack_refactor_actions.execute(self, allocator, input, options);
    }

    /// Lists all account stack refactor operations and their statuses.
    pub fn listStackRefactors(self: *Self, allocator: std.mem.Allocator, input: list_stack_refactors.ListStackRefactorsInput, options: CallOptions) !list_stack_refactors.ListStackRefactorsOutput {
        return list_stack_refactors.execute(self, allocator, input, options);
    }

    /// Returns descriptions of all resources of the specified stack.
    ///
    /// For deleted stacks, ListStackResources returns resource information for up
    /// to 90 days
    /// after the stack has been deleted.
    pub fn listStackResources(self: *Self, allocator: std.mem.Allocator, input: list_stack_resources.ListStackResourcesInput, options: CallOptions) !list_stack_resources.ListStackResourcesOutput {
        return list_stack_resources.execute(self, allocator, input, options);
    }

    /// Returns summary information about deployment targets for a StackSet.
    pub fn listStackSetAutoDeploymentTargets(self: *Self, allocator: std.mem.Allocator, input: list_stack_set_auto_deployment_targets.ListStackSetAutoDeploymentTargetsInput, options: CallOptions) !list_stack_set_auto_deployment_targets.ListStackSetAutoDeploymentTargetsOutput {
        return list_stack_set_auto_deployment_targets.execute(self, allocator, input, options);
    }

    /// Returns summary information about the results of a StackSet operation.
    ///
    /// This API provides *eventually consistent* reads meaning it may take
    /// some time but will eventually return the most up-to-date data.
    pub fn listStackSetOperationResults(self: *Self, allocator: std.mem.Allocator, input: list_stack_set_operation_results.ListStackSetOperationResultsInput, options: CallOptions) !list_stack_set_operation_results.ListStackSetOperationResultsOutput {
        return list_stack_set_operation_results.execute(self, allocator, input, options);
    }

    /// Returns summary information about operations performed on a StackSet.
    ///
    /// This API provides *eventually consistent* reads meaning it may take
    /// some time but will eventually return the most up-to-date data.
    pub fn listStackSetOperations(self: *Self, allocator: std.mem.Allocator, input: list_stack_set_operations.ListStackSetOperationsInput, options: CallOptions) !list_stack_set_operations.ListStackSetOperationsOutput {
        return list_stack_set_operations.execute(self, allocator, input, options);
    }

    /// Returns summary information about StackSets that are associated with the
    /// user.
    ///
    /// This API provides *strongly consistent* reads meaning it will always
    /// return the most up-to-date data.
    ///
    /// * [Self-managed permissions] If you set the `CallAs` parameter to
    /// `SELF` while signed in to your Amazon Web Services account, `ListStackSets`
    /// returns all self-managed StackSets in your Amazon Web Services account.
    ///
    /// * [Service-managed permissions] If you set the `CallAs` parameter to
    /// `SELF` while signed in to the organization's management account,
    /// `ListStackSets` returns all StackSets in the management account.
    ///
    /// * [Service-managed permissions] If you set the `CallAs` parameter to
    /// `DELEGATED_ADMIN` while signed in to your member account,
    /// `ListStackSets` returns all StackSets with service-managed permissions in
    /// the
    /// management account.
    pub fn listStackSets(self: *Self, allocator: std.mem.Allocator, input: list_stack_sets.ListStackSetsInput, options: CallOptions) !list_stack_sets.ListStackSetsOutput {
        return list_stack_sets.execute(self, allocator, input, options);
    }

    /// Returns the summary information for stacks whose status matches the
    /// specified
    /// `StackStatusFilter`. Summary information for stacks that have been deleted
    /// is
    /// kept for 90 days after the stack is deleted. If no `StackStatusFilter` is
    /// specified, summary information for all stacks is returned (including
    /// existing stacks and
    /// stacks that have been deleted).
    pub fn listStacks(self: *Self, allocator: std.mem.Allocator, input: list_stacks.ListStacksInput, options: CallOptions) !list_stacks.ListStacksOutput {
        return list_stacks.execute(self, allocator, input, options);
    }

    /// Returns a list of registration tokens for the specified extension(s).
    pub fn listTypeRegistrations(self: *Self, allocator: std.mem.Allocator, input: list_type_registrations.ListTypeRegistrationsInput, options: CallOptions) !list_type_registrations.ListTypeRegistrationsOutput {
        return list_type_registrations.execute(self, allocator, input, options);
    }

    /// Returns summary information about the versions of an extension.
    pub fn listTypeVersions(self: *Self, allocator: std.mem.Allocator, input: list_type_versions.ListTypeVersionsInput, options: CallOptions) !list_type_versions.ListTypeVersionsOutput {
        return list_type_versions.execute(self, allocator, input, options);
    }

    /// Returns summary information about all extensions, including your private
    /// resource types,
    /// modules, and Hooks as well as all public extensions from Amazon Web Services
    /// and third-party
    /// publishers.
    pub fn listTypes(self: *Self, allocator: std.mem.Allocator, input: list_types.ListTypesInput, options: CallOptions) !list_types.ListTypesOutput {
        return list_types.execute(self, allocator, input, options);
    }

    /// Publishes the specified extension to the CloudFormation registry as a public
    /// extension in this
    /// Region. Public extensions are available for use by all CloudFormation users.
    /// For more information
    /// about publishing extensions, see [Publishing extensions to
    /// make them available for public
    /// use](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/publish-extension.html) in the
    /// *CloudFormation Command Line Interface (CLI) User Guide*.
    ///
    /// To publish an extension, you must be registered as a publisher with
    /// CloudFormation. For more
    /// information, see
    /// [RegisterPublisher](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterPublisher.html).
    pub fn publishType(self: *Self, allocator: std.mem.Allocator, input: publish_type.PublishTypeInput, options: CallOptions) !publish_type.PublishTypeOutput {
        return publish_type.execute(self, allocator, input, options);
    }

    /// Reports progress of a resource handler to CloudFormation.
    ///
    /// Reserved for use by the [CloudFormation
    /// CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html). Don't use this API in your code.
    pub fn recordHandlerProgress(self: *Self, allocator: std.mem.Allocator, input: record_handler_progress.RecordHandlerProgressInput, options: CallOptions) !record_handler_progress.RecordHandlerProgressOutput {
        return record_handler_progress.execute(self, allocator, input, options);
    }

    /// Registers your account as a publisher of public extensions in the
    /// CloudFormation registry.
    /// Public extensions are available for use by all CloudFormation users. This
    /// publisher ID applies to
    /// your account in all Amazon Web Services Regions.
    ///
    /// For information about requirements for registering as a public extension
    /// publisher, see
    /// [Prerequisite: Registering your account to publish CloudFormation
    /// extensions](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/publish-extension.html#publish-extension-prereqs) in the
    /// *CloudFormation Command Line Interface (CLI) User Guide*.
    pub fn registerPublisher(self: *Self, allocator: std.mem.Allocator, input: register_publisher.RegisterPublisherInput, options: CallOptions) !register_publisher.RegisterPublisherOutput {
        return register_publisher.execute(self, allocator, input, options);
    }

    /// Registers an extension with the CloudFormation service. Registering an
    /// extension makes it
    /// available for use in CloudFormation templates in your Amazon Web Services
    /// account, and includes:
    ///
    /// * Validating the extension schema.
    ///
    /// * Determining which handlers, if any, have been specified for the extension.
    ///
    /// * Making the extension available for use in your account.
    ///
    /// For more information about how to develop extensions and ready them for
    /// registration, see
    /// [Creating resource types using the CloudFormation
    /// CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-types.html) in the
    /// *CloudFormation Command Line Interface (CLI) User Guide*.
    ///
    /// You can have a maximum of 50 resource extension versions registered at a
    /// time. This
    /// maximum is per account and per Region. Use
    /// [DeregisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DeregisterType.html)
    /// to deregister specific extension versions if necessary.
    ///
    /// Once you have initiated a registration request using RegisterType, you
    /// can use DescribeTypeRegistration to monitor the progress of the registration
    /// request.
    ///
    /// Once you have registered a private extension in your account and Region, use
    /// [SetTypeConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_SetTypeConfiguration.html) to specify configuration properties for the extension. For
    /// more information, see [Edit configuration
    /// data for extensions in your
    /// account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-set-configuration.html) in the
    /// *CloudFormation User Guide*.
    pub fn registerType(self: *Self, allocator: std.mem.Allocator, input: register_type.RegisterTypeInput, options: CallOptions) !register_type.RegisterTypeOutput {
        return register_type.execute(self, allocator, input, options);
    }

    /// When specifying `RollbackStack`, you preserve the state of previously
    /// provisioned resources when an operation fails. You can check the status of
    /// the stack through
    /// the DescribeStacks operation.
    ///
    /// Rolls back the specified stack to the last known stable state from
    /// `CREATE_FAILED` or `UPDATE_FAILED` stack statuses.
    ///
    /// This operation will delete a stack if it doesn't contain a last known stable
    /// state. A last
    /// known stable state includes any status in a `*_COMPLETE`. This includes the
    /// following stack statuses.
    ///
    /// * `CREATE_COMPLETE`
    ///
    /// * `UPDATE_COMPLETE`
    ///
    /// * `UPDATE_ROLLBACK_COMPLETE`
    ///
    /// * `IMPORT_COMPLETE`
    ///
    /// * `IMPORT_ROLLBACK_COMPLETE`
    pub fn rollbackStack(self: *Self, allocator: std.mem.Allocator, input: rollback_stack.RollbackStackInput, options: CallOptions) !rollback_stack.RollbackStackOutput {
        return rollback_stack.execute(self, allocator, input, options);
    }

    /// Sets a stack policy for a specified stack.
    pub fn setStackPolicy(self: *Self, allocator: std.mem.Allocator, input: set_stack_policy.SetStackPolicyInput, options: CallOptions) !set_stack_policy.SetStackPolicyOutput {
        return set_stack_policy.execute(self, allocator, input, options);
    }

    /// Specifies the configuration data for a CloudFormation extension, such as a
    /// resource or Hook,
    /// in the given account and Region.
    ///
    /// For more information, see [Edit configuration
    /// data for extensions in your
    /// account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-set-configuration.html) in the
    /// *CloudFormation User Guide*.
    ///
    /// To view the current configuration data for an extension, refer to the
    /// `ConfigurationSchema` element of
    /// [DescribeType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DescribeType.html).
    ///
    /// It's strongly recommended that you use dynamic references to restrict
    /// sensitive
    /// configuration definitions, such as third-party credentials. For more
    /// information, see [Specify values stored in other services using dynamic
    /// references](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/dynamic-references.html) in the
    /// *CloudFormation User Guide*.
    ///
    /// For more information about setting the configuration data for resource
    /// types, see [Defining the account-level configuration of an
    /// extension](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-model.html#resource-type-howto-configuration) in the
    /// *CloudFormation Command Line Interface (CLI) User Guide*. For more
    /// information about setting the configuration
    /// data for Hooks, see the [CloudFormation Hooks User
    /// Guide](https://docs.aws.amazon.com/cloudformation-cli/latest/hooks-userguide/what-is-cloudformation-hooks.html).
    pub fn setTypeConfiguration(self: *Self, allocator: std.mem.Allocator, input: set_type_configuration.SetTypeConfigurationInput, options: CallOptions) !set_type_configuration.SetTypeConfigurationOutput {
        return set_type_configuration.execute(self, allocator, input, options);
    }

    /// Specify the default version of an extension. The default version of an
    /// extension will be
    /// used in CloudFormation operations.
    pub fn setTypeDefaultVersion(self: *Self, allocator: std.mem.Allocator, input: set_type_default_version.SetTypeDefaultVersionInput, options: CallOptions) !set_type_default_version.SetTypeDefaultVersionOutput {
        return set_type_default_version.execute(self, allocator, input, options);
    }

    /// Sends a signal to the specified resource with a success or failure status.
    /// You can use the
    /// `SignalResource` operation in conjunction with a creation policy or update
    /// policy. CloudFormation doesn't proceed with a stack creation or update until
    /// resources receive the
    /// required number of signals or the timeout period is exceeded. The
    /// `SignalResource`
    /// operation is useful in cases where you want to send signals from anywhere
    /// other than an Amazon EC2
    /// instance.
    pub fn signalResource(self: *Self, allocator: std.mem.Allocator, input: signal_resource.SignalResourceInput, options: CallOptions) !signal_resource.SignalResourceOutput {
        return signal_resource.execute(self, allocator, input, options);
    }

    /// Starts a scan of the resources in this account in this Region. You can the
    /// status of a
    /// scan using the `ListResourceScans` API action.
    pub fn startResourceScan(self: *Self, allocator: std.mem.Allocator, input: start_resource_scan.StartResourceScanInput, options: CallOptions) !start_resource_scan.StartResourceScanOutput {
        return start_resource_scan.execute(self, allocator, input, options);
    }

    /// Stops an in-progress operation on a StackSet and its associated stack
    /// instances. StackSets
    /// will cancel all the unstarted stack instance deployments and wait for those
    /// are in-progress to
    /// complete.
    pub fn stopStackSetOperation(self: *Self, allocator: std.mem.Allocator, input: stop_stack_set_operation.StopStackSetOperationInput, options: CallOptions) !stop_stack_set_operation.StopStackSetOperationOutput {
        return stop_stack_set_operation.execute(self, allocator, input, options);
    }

    /// Tests a registered extension to make sure it meets all necessary
    /// requirements for being
    /// published in the CloudFormation registry.
    ///
    /// * For resource types, this includes passing all contracts tests defined for
    ///   the
    /// type.
    ///
    /// * For modules, this includes determining if the module's model meets all
    ///   necessary
    /// requirements.
    ///
    /// For more information, see [Testing your public extension before
    /// publishing](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/publish-extension.html#publish-extension-testing) in the
    /// *CloudFormation Command Line Interface (CLI) User Guide*.
    ///
    /// If you don't specify a version, CloudFormation uses the default version of
    /// the extension in
    /// your account and Region for testing.
    ///
    /// To perform testing, CloudFormation assumes the execution role specified when
    /// the type was
    /// registered. For more information, see
    /// [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html).
    ///
    /// Once you've initiated testing on an extension using `TestType`, you can pass
    /// the returned `TypeVersionArn` into
    /// [DescribeType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DescribeType.html) to
    /// monitor the current test status and test status description for the
    /// extension.
    ///
    /// An extension must have a test status of `PASSED` before it can be published.
    /// For more information, see [Publishing extensions
    /// to make them available for public
    /// use](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-publish.html) in the
    /// *CloudFormation Command Line Interface (CLI) User Guide*.
    pub fn testType(self: *Self, allocator: std.mem.Allocator, input: test_type.TestTypeInput, options: CallOptions) !test_type.TestTypeOutput {
        return test_type.execute(self, allocator, input, options);
    }

    /// Updates a generated template. This can be used to change the name, add and
    /// remove
    /// resources, refresh resources, and change the `DeletionPolicy` and
    /// `UpdateReplacePolicy` settings. You can check the status of the update to
    /// the
    /// generated template using the `DescribeGeneratedTemplate` API action.
    pub fn updateGeneratedTemplate(self: *Self, allocator: std.mem.Allocator, input: update_generated_template.UpdateGeneratedTemplateInput, options: CallOptions) !update_generated_template.UpdateGeneratedTemplateOutput {
        return update_generated_template.execute(self, allocator, input, options);
    }

    /// Updates a stack as specified in the template. After the call completes
    /// successfully, the
    /// stack update starts. You can check the status of the stack through the
    /// DescribeStacks action.
    ///
    /// To get a copy of the template for an existing stack, you can use the
    /// GetTemplate action.
    ///
    /// For more information about updating a stack and monitoring the progress of
    /// the update, see
    /// [Managing
    /// Amazon Web Services resources as a single unit with CloudFormation
    /// stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacks.html) in the
    /// *CloudFormation User Guide*.
    pub fn updateStack(self: *Self, allocator: std.mem.Allocator, input: update_stack.UpdateStackInput, options: CallOptions) !update_stack.UpdateStackOutput {
        return update_stack.execute(self, allocator, input, options);
    }

    /// Updates the parameter values for stack instances for the specified accounts,
    /// within the
    /// specified Amazon Web Services Regions. A stack instance refers to a stack in
    /// a specific account and
    /// Region.
    ///
    /// You can only update stack instances in Amazon Web Services Regions and
    /// accounts where they already
    /// exist; to create additional stack instances, use
    /// [CreateStackInstances](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CreateStackInstances.html).
    ///
    /// During StackSet updates, any parameters overridden for a stack instance
    /// aren't updated,
    /// but retain their overridden value.
    ///
    /// You can only update the parameter *values* that are specified in the
    /// StackSet. To add or delete a parameter itself, use
    /// [UpdateStackSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_UpdateStackSet.html)
    /// to update the StackSet template. If you add a parameter to a template,
    /// before you can override
    /// the parameter value specified in the StackSet you must first use
    /// [UpdateStackSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_UpdateStackSet.html)
    /// to update all stack instances with the updated template and parameter value
    /// specified in the
    /// StackSet. Once a stack instance has been updated with the new parameter, you
    /// can then override
    /// the parameter value using `UpdateStackInstances`.
    ///
    /// The maximum number of organizational unit (OUs) supported by a
    /// `UpdateStackInstances` operation is 50.
    ///
    /// If you need more than 50, consider the following options:
    ///
    /// * *Batch processing:* If you don't want to expose your OU
    /// hierarchy, split up the operations into multiple calls with less than 50 OUs
    /// each.
    ///
    /// * *Parent OU strategy:* If you don't mind exposing the OU
    /// hierarchy, target a parent OU that contains all desired child OUs.
    pub fn updateStackInstances(self: *Self, allocator: std.mem.Allocator, input: update_stack_instances.UpdateStackInstancesInput, options: CallOptions) !update_stack_instances.UpdateStackInstancesOutput {
        return update_stack_instances.execute(self, allocator, input, options);
    }

    /// Updates the StackSet and associated stack instances in the specified
    /// accounts and
    /// Amazon Web Services Regions.
    ///
    /// Even if the StackSet operation created by updating the StackSet fails
    /// (completely or
    /// partially, below or above a specified failure tolerance), the StackSet is
    /// updated with your
    /// changes. Subsequent CreateStackInstances calls on the specified StackSet use
    /// the updated StackSet.
    ///
    /// The maximum number of organizational unit (OUs) supported by a
    /// `UpdateStackSet` operation is 50.
    ///
    /// If you need more than 50, consider the following options:
    ///
    /// * *Batch processing:* If you don't want to expose your OU
    /// hierarchy, split up the operations into multiple calls with less than 50 OUs
    /// each.
    ///
    /// * *Parent OU strategy:* If you don't mind exposing the OU
    /// hierarchy, target a parent OU that contains all desired child OUs.
    pub fn updateStackSet(self: *Self, allocator: std.mem.Allocator, input: update_stack_set.UpdateStackSetInput, options: CallOptions) !update_stack_set.UpdateStackSetOutput {
        return update_stack_set.execute(self, allocator, input, options);
    }

    /// Updates termination protection for the specified stack. If a user attempts
    /// to delete a
    /// stack with termination protection enabled, the operation fails and the stack
    /// remains
    /// unchanged. For more information, see [Protect a CloudFormation
    /// stack from being
    /// deleted](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-protect-stacks.html) in the *CloudFormation User Guide*.
    ///
    /// For [nested
    /// stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html),
    /// termination protection is set on the root stack and can't be changed
    /// directly on the nested
    /// stack.
    pub fn updateTerminationProtection(self: *Self, allocator: std.mem.Allocator, input: update_termination_protection.UpdateTerminationProtectionInput, options: CallOptions) !update_termination_protection.UpdateTerminationProtectionOutput {
        return update_termination_protection.execute(self, allocator, input, options);
    }

    /// Validates a specified template. CloudFormation first checks if the template
    /// is valid JSON. If
    /// it isn't, CloudFormation checks if the template is valid YAML. If both these
    /// checks fail,
    /// CloudFormation returns a template validation error.
    pub fn validateTemplate(self: *Self, allocator: std.mem.Allocator, input: validate_template.ValidateTemplateInput, options: CallOptions) !validate_template.ValidateTemplateOutput {
        return validate_template.execute(self, allocator, input, options);
    }

    pub fn describeAccountLimitsPaginator(self: *Self, params: describe_account_limits.DescribeAccountLimitsInput) paginator.DescribeAccountLimitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeChangeSetPaginator(self: *Self, params: describe_change_set.DescribeChangeSetInput) paginator.DescribeChangeSetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEventsPaginator(self: *Self, params: describe_events.DescribeEventsInput) paginator.DescribeEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeStackEventsPaginator(self: *Self, params: describe_stack_events.DescribeStackEventsInput) paginator.DescribeStackEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeStackResourceDriftsPaginator(self: *Self, params: describe_stack_resource_drifts.DescribeStackResourceDriftsInput) paginator.DescribeStackResourceDriftsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeStacksPaginator(self: *Self, params: describe_stacks.DescribeStacksInput) paginator.DescribeStacksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChangeSetsPaginator(self: *Self, params: list_change_sets.ListChangeSetsInput) paginator.ListChangeSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExportsPaginator(self: *Self, params: list_exports.ListExportsInput) paginator.ListExportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGeneratedTemplatesPaginator(self: *Self, params: list_generated_templates.ListGeneratedTemplatesInput) paginator.ListGeneratedTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImportsPaginator(self: *Self, params: list_imports.ListImportsInput) paginator.ListImportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceScanRelatedResourcesPaginator(self: *Self, params: list_resource_scan_related_resources.ListResourceScanRelatedResourcesInput) paginator.ListResourceScanRelatedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceScanResourcesPaginator(self: *Self, params: list_resource_scan_resources.ListResourceScanResourcesInput) paginator.ListResourceScanResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceScansPaginator(self: *Self, params: list_resource_scans.ListResourceScansInput) paginator.ListResourceScansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStackInstancesPaginator(self: *Self, params: list_stack_instances.ListStackInstancesInput) paginator.ListStackInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStackRefactorActionsPaginator(self: *Self, params: list_stack_refactor_actions.ListStackRefactorActionsInput) paginator.ListStackRefactorActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStackRefactorsPaginator(self: *Self, params: list_stack_refactors.ListStackRefactorsInput) paginator.ListStackRefactorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStackResourcesPaginator(self: *Self, params: list_stack_resources.ListStackResourcesInput) paginator.ListStackResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStackSetOperationResultsPaginator(self: *Self, params: list_stack_set_operation_results.ListStackSetOperationResultsInput) paginator.ListStackSetOperationResultsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStackSetOperationsPaginator(self: *Self, params: list_stack_set_operations.ListStackSetOperationsInput) paginator.ListStackSetOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStackSetsPaginator(self: *Self, params: list_stack_sets.ListStackSetsInput) paginator.ListStackSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStacksPaginator(self: *Self, params: list_stacks.ListStacksInput) paginator.ListStacksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTypeRegistrationsPaginator(self: *Self, params: list_type_registrations.ListTypeRegistrationsInput) paginator.ListTypeRegistrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTypeVersionsPaginator(self: *Self, params: list_type_versions.ListTypeVersionsInput) paginator.ListTypeVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTypesPaginator(self: *Self, params: list_types.ListTypesInput) paginator.ListTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilChangeSetCreateComplete(self: *Self, params: describe_change_set.DescribeChangeSetInput) aws.waiter.WaiterError!void {
        var w = waiters.ChangeSetCreateCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStackCreateComplete(self: *Self, params: describe_stacks.DescribeStacksInput) aws.waiter.WaiterError!void {
        var w = waiters.StackCreateCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStackDeleteComplete(self: *Self, params: describe_stacks.DescribeStacksInput) aws.waiter.WaiterError!void {
        var w = waiters.StackDeleteCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStackExists(self: *Self, params: describe_stacks.DescribeStacksInput) aws.waiter.WaiterError!void {
        var w = waiters.StackExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStackImportComplete(self: *Self, params: describe_stacks.DescribeStacksInput) aws.waiter.WaiterError!void {
        var w = waiters.StackImportCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStackRefactorCreateComplete(self: *Self, params: describe_stack_refactor.DescribeStackRefactorInput) aws.waiter.WaiterError!void {
        var w = waiters.StackRefactorCreateCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStackRefactorExecuteComplete(self: *Self, params: describe_stack_refactor.DescribeStackRefactorInput) aws.waiter.WaiterError!void {
        var w = waiters.StackRefactorExecuteCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStackRollbackComplete(self: *Self, params: describe_stacks.DescribeStacksInput) aws.waiter.WaiterError!void {
        var w = waiters.StackRollbackCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStackUpdateComplete(self: *Self, params: describe_stacks.DescribeStacksInput) aws.waiter.WaiterError!void {
        var w = waiters.StackUpdateCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilTypeRegistrationComplete(self: *Self, params: describe_type_registration.DescribeTypeRegistrationInput) aws.waiter.WaiterError!void {
        var w = waiters.TypeRegistrationCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }
};

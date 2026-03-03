const AutoDeployment = @import("auto_deployment.zig").AutoDeployment;
const StackDriftStatus = @import("stack_drift_status.zig").StackDriftStatus;
const ManagedExecution = @import("managed_execution.zig").ManagedExecution;
const PermissionModels = @import("permission_models.zig").PermissionModels;
const StackSetStatus = @import("stack_set_status.zig").StackSetStatus;

/// The structures that contain summary information about the specified
/// StackSet.
pub const StackSetSummary = struct {
    /// [Service-managed permissions] Describes whether StackSets automatically
    /// deploys to Organizations accounts that are added to a target organizational
    /// unit (OU).
    auto_deployment: ?AutoDeployment = null,

    /// A description of the StackSet that you specify when the StackSet is created
    /// or
    /// updated.
    description: ?[]const u8 = null,

    /// Status of the StackSet's actual configuration compared to its expected
    /// template and
    /// parameter configuration.
    ///
    /// * `DRIFTED`: One or more of the stack instances belonging to the StackSet
    ///   differs
    /// from the expected template and parameter configuration. A stack instance is
    /// considered to have
    /// drifted if one or more of the resources in the associated stack have
    /// drifted.
    ///
    /// * `NOT_CHECKED`: CloudFormation hasn't checked the StackSet for drift.
    ///
    /// * `IN_SYNC`: All the stack instances belonging to the StackSet match the
    ///   expected
    /// template and parameter configuration.
    ///
    /// * `UNKNOWN`: This value is reserved for future use.
    drift_status: ?StackDriftStatus = null,

    /// Most recent time when CloudFormation performed a drift detection operation
    /// on the StackSet. This
    /// value will be `NULL` for any StackSet that drift detection hasn't yet been
    /// performed
    /// on.
    last_drift_check_timestamp: ?i64 = null,

    /// Describes whether StackSets performs non-conflicting operations concurrently
    /// and queues
    /// conflicting operations.
    managed_execution: ?ManagedExecution = null,

    /// Describes how the IAM roles required for StackSet operations are created.
    ///
    /// * With `self-managed` permissions, you must create the administrator and
    /// execution roles required to deploy to target accounts. For more information,
    /// see [Grant
    /// self-managed
    /// permissions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs-self-managed.html).
    ///
    /// * With `service-managed` permissions, StackSets automatically creates the
    ///   IAM
    /// roles required to deploy to accounts managed by Organizations. For more
    /// information,
    /// see [Activate
    /// trusted access for StackSets with
    /// Organizations](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-activate-trusted-access.html).
    permission_model: ?PermissionModels = null,

    /// The ID of the StackSet.
    stack_set_id: ?[]const u8 = null,

    /// The name of the StackSet.
    stack_set_name: ?[]const u8 = null,

    /// The status of the StackSet.
    status: ?StackSetStatus = null,
};

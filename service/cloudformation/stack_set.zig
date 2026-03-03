const AutoDeployment = @import("auto_deployment.zig").AutoDeployment;
const Capability = @import("capability.zig").Capability;
const ManagedExecution = @import("managed_execution.zig").ManagedExecution;
const Parameter = @import("parameter.zig").Parameter;
const PermissionModels = @import("permission_models.zig").PermissionModels;
const StackSetDriftDetectionDetails = @import("stack_set_drift_detection_details.zig").StackSetDriftDetectionDetails;
const StackSetStatus = @import("stack_set_status.zig").StackSetStatus;
const Tag = @import("tag.zig").Tag;

/// A structure that contains information about a StackSet. With StackSets, you
/// can provision
/// stacks across Amazon Web Services accounts and Regions from a single
/// CloudFormation template. Each stack is based
/// on the same CloudFormation template, but you can customize individual stacks
/// using parameters.
pub const StackSet = struct {
    /// The Amazon Resource Name (ARN) of the IAM role used to create or update the
    /// stack
    /// set.
    ///
    /// Use customized administrator roles to control which users or groups can
    /// manage specific
    /// StackSets within the same administrator account. For more information, see
    /// [Prerequisites for using CloudFormation
    /// StackSets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs.html) in the
    /// *CloudFormation User Guide*.
    administration_role_arn: ?[]const u8 = null,

    /// Describes whether StackSets automatically deploys to Organizations accounts
    /// that are
    /// added to a target organization or organizational unit (OU). Valid only if
    /// the StackSet uses
    /// service-managed permissions.
    auto_deployment: ?AutoDeployment = null,

    /// The capabilities that are allowed in the StackSet. Some StackSet templates
    /// might include
    /// resources that can affect permissions in your Amazon Web Services
    /// account—for example, by creating new
    /// Identity and Access Management (IAM) users. For more information, see
    /// [Acknowledging IAM resources in CloudFormation
    /// templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/control-access-with-iam.html#using-iam-capabilities).
    capabilities: ?[]const Capability = null,

    /// A description of the StackSet that you specify when the StackSet is created
    /// or
    /// updated.
    description: ?[]const u8 = null,

    /// The name of the IAM execution role used to create or update the StackSet.
    ///
    /// Use customized execution roles to control which stack resources users and
    /// groups can include
    /// in their StackSets.
    execution_role_name: ?[]const u8 = null,

    /// Describes whether StackSets performs non-conflicting operations concurrently
    /// and queues
    /// conflicting operations.
    managed_execution: ?ManagedExecution = null,

    /// [Service-managed permissions] The organization root ID or organizational
    /// unit (OU) IDs that
    /// you specified for
    /// [DeploymentTargets](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DeploymentTargets.html).
    organizational_unit_ids: ?[]const []const u8 = null,

    /// A list of input parameters for a StackSet.
    parameters: ?[]const Parameter = null,

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

    /// Returns a list of all Amazon Web Services Regions the given StackSet has
    /// stack instances deployed in. The
    /// Amazon Web Services Regions list output is in no particular order.
    regions: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the StackSet.
    stack_set_arn: ?[]const u8 = null,

    /// Detailed information about the drift status of the StackSet.
    ///
    /// For StackSets, contains information about the last *completed* drift
    /// operation performed on the StackSet. Information about drift operations
    /// currently in progress
    /// isn't included.
    stack_set_drift_detection_details: ?StackSetDriftDetectionDetails = null,

    /// The ID of the StackSet.
    stack_set_id: ?[]const u8 = null,

    /// The name that's associated with the StackSet.
    stack_set_name: ?[]const u8 = null,

    /// The status of the StackSet.
    status: ?StackSetStatus = null,

    /// A list of tags that specify information about the StackSet. A maximum number
    /// of 50 tags can
    /// be specified.
    tags: ?[]const Tag = null,

    /// The structure that contains the body of the template that was used to create
    /// or update the
    /// StackSet.
    template_body: ?[]const u8 = null,
};

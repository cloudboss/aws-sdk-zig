const LaunchTemplateSpecificationOverride = @import("launch_template_specification_override.zig").LaunchTemplateSpecificationOverride;
const UserdataType = @import("userdata_type.zig").UserdataType;

/// An object that represents a launch template that's associated with a compute
/// resource. You
/// must specify either the launch template ID or launch template name in the
/// request, but not
/// both.
///
/// If security groups are specified using both the `securityGroupIds` parameter
/// of
/// `CreateComputeEnvironment` and the launch template, the values in the
/// `securityGroupIds` parameter of `CreateComputeEnvironment` will be
/// used.
///
/// This object isn't applicable to jobs that are running on Fargate resources.
pub const LaunchTemplateSpecification = struct {
    /// The ID of the launch template.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template.
    launch_template_name: ?[]const u8 = null,

    /// A launch template to use in place of the default launch template. You must
    /// specify either the launch template ID or launch template name in the
    /// request, but not both.
    ///
    /// You can specify up to ten (10) launch template overrides that are associated
    /// to unique instance types or families for each compute environment.
    ///
    /// To unset all override templates for a compute environment, you can pass an
    /// empty array to the
    /// [UpdateComputeEnvironment.overrides](https://docs.aws.amazon.com/batch/latest/APIReference/API_UpdateComputeEnvironment.html) parameter, or not include the `overrides` parameter when submitting the `UpdateComputeEnvironment` API operation.
    overrides: ?[]const LaunchTemplateSpecificationOverride = null,

    /// The EKS node initialization process to use. You only need to specify this
    /// value if you are
    /// using a custom AMI. The default value is `EKS_BOOTSTRAP_SH`. If
    /// *imageType* is a custom AMI based on EKS_AL2023 or EKS_AL2023_NVIDIA then
    /// you
    /// must choose `EKS_NODEADM`.
    userdata_type: ?UserdataType = null,

    /// The version number of the launch template,
    /// `$Default`, or `$Latest`.
    ///
    /// If the value is `$Default`, the default version of the launch template is
    /// used. If the value is `$Latest`, the latest version of the launch template
    /// is used.
    ///
    /// If the AMI ID that's used in a compute environment is from the launch
    /// template, the AMI
    /// isn't changed when the compute environment is updated. It's only changed if
    /// the
    /// `updateToLatestImageVersion` parameter for the compute environment is set to
    /// `true`. During an infrastructure update, if either `$Default` or
    /// `$Latest` is specified, Batch re-evaluates the launch template version, and
    /// it
    /// might use a different version of the launch template. This is the case even
    /// if the launch
    /// template isn't specified in the update. When updating a compute environment,
    /// changing the launch
    /// template requires an infrastructure update of the compute environment. For
    /// more information, see
    /// [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the *Batch User Guide*.
    ///
    /// Default: `$Default`
    ///
    /// Latest: `$Latest`
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .launch_template_id = "launchTemplateId",
        .launch_template_name = "launchTemplateName",
        .overrides = "overrides",
        .userdata_type = "userdataType",
        .version = "version",
    };
};

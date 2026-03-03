/// An object representing a node group launch template specification. The
/// launch template
/// can't include [
/// `SubnetId`
/// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateNetworkInterface.html), [
/// `IamInstanceProfile`
/// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_IamInstanceProfile.html), [
/// `RequestSpotInstances`
/// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RequestSpotInstances.html), [
/// `HibernationOptions`
/// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_HibernationOptionsRequest.html), or [
/// `TerminateInstances`
/// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TerminateInstances.html), or the node group deployment or
/// update will fail. For more information about launch templates, see [
/// `CreateLaunchTemplate`
/// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateLaunchTemplate.html) in the Amazon EC2 API Reference.
/// For more information about using launch templates with Amazon EKS, see
/// [Customizing managed nodes with launch
/// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
///
/// You must specify either the launch template ID or the launch template name
/// in the
/// request, but not both.
pub const LaunchTemplateSpecification = struct {
    /// The ID of the launch template.
    ///
    /// You must specify either the launch template ID or the launch template name
    /// in the
    /// request, but not both. After node group creation, you cannot use a different
    /// ID.
    id: ?[]const u8 = null,

    /// The name of the launch template.
    ///
    /// You must specify either the launch template name or the launch template ID
    /// in the
    /// request, but not both. After node group creation, you cannot use a different
    /// name.
    name: ?[]const u8 = null,

    /// The version number of the launch template to use. If no version is
    /// specified, then the
    /// template's default version is used. You can use a different version for node
    /// group
    /// updates.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .version = "version",
    };
};

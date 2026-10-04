/// Describes the configuration for a launch permission. The launch permission
/// modification request is sent to the [Amazon EC2
/// ModifyImageAttribute](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyImageAttribute.html) API on behalf of the user for each Region they have
/// selected to distribute the AMI. To make an AMI public, set `userGroups`
/// to the value `all`. See the examples for making an AMI public at
/// [Amazon EC2
/// ModifyImageAttribute](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyImageAttribute.html).
pub const LaunchPermissionConfiguration = struct {
    /// The ARN for an Organizations organizational unit (OU) that you want to share
    /// your AMI with.
    /// For more information about key concepts for Organizations, see
    /// [Organizations
    /// terminology and
    /// concepts](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html).
    organizational_unit_arns: ?[]const []const u8 = null,

    /// The ARN for an Amazon Web Services Organization that you want to share your
    /// AMI with. For more
    /// information, see [What is
    /// Organizations?](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html).
    organization_arns: ?[]const []const u8 = null,

    /// The name of the group that you want to grant launch permission to. The only
    /// supported value is `all`, which makes the distributed AMI
    /// public.
    user_groups: ?[]const []const u8 = null,

    /// The Amazon Web Services account IDs to grant launch permission to. Each
    /// listed account can
    /// use the distributed AMI to launch instances.
    user_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .organizational_unit_arns = "organizationalUnitArns",
        .organization_arns = "organizationArns",
        .user_groups = "userGroups",
        .user_ids = "userIds",
    };
};

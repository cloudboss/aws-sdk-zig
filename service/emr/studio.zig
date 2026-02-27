const AuthMode = @import("auth_mode.zig").AuthMode;
const IdcUserAssignment = @import("idc_user_assignment.zig").IdcUserAssignment;
const Tag = @import("tag.zig").Tag;

/// Details for an Amazon EMR Studio including ID, creation time, name, and so
/// on.
pub const Studio = struct {
    /// Specifies whether the Amazon EMR Studio authenticates users with IAM or IAM
    /// Identity Center.
    auth_mode: ?AuthMode,

    /// The time the Amazon EMR Studio was created.
    creation_time: ?i64,

    /// The Amazon S3 location to back up Amazon EMR Studio Workspaces and
    /// notebook files.
    default_s3_location: ?[]const u8,

    /// The detailed description of the Amazon EMR Studio.
    description: ?[]const u8,

    /// The KMS key identifier (ARN) used to encrypt Amazon EMR Studio workspace and
    /// notebook files when backed up to Amazon S3.
    encryption_key_arn: ?[]const u8,

    /// The ID of the Engine security group associated with the Amazon EMR Studio.
    /// The
    /// Engine security group allows inbound network traffic from resources in the
    /// Workspace
    /// security group.
    engine_security_group_id: ?[]const u8,

    /// The ARN of the IAM Identity Center instance the Studio application belongs
    /// to.
    idc_instance_arn: ?[]const u8,

    /// Indicates whether the Studio has `REQUIRED` or `OPTIONAL` IAM Identity
    /// Center user assignment. If the value is set to `REQUIRED`, users must be
    /// explicitly assigned to the Studio application to access the Studio.
    idc_user_assignment: ?IdcUserAssignment,

    /// Your identity provider's authentication endpoint. Amazon EMR Studio
    /// redirects
    /// federated users to this endpoint for authentication when logging in to a
    /// Studio with the
    /// Studio URL.
    idp_auth_url: ?[]const u8,

    /// The name of your identity provider's `RelayState` parameter.
    idp_relay_state_parameter_name: ?[]const u8,

    /// The name of the Amazon EMR Studio.
    name: ?[]const u8,

    /// The name of the IAM role assumed by the Amazon EMR Studio.
    service_role: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon EMR Studio.
    studio_arn: ?[]const u8,

    /// The ID of the Amazon EMR Studio.
    studio_id: ?[]const u8,

    /// The list of IDs of the subnets associated with the Amazon EMR Studio.
    subnet_ids: ?[]const []const u8,

    /// A list of tags associated with the Amazon EMR Studio.
    tags: ?[]const Tag,

    /// Indicates whether the Studio has Trusted identity propagation enabled. The
    /// default value is `false`.
    trusted_identity_propagation_enabled: ?bool,

    /// The unique access URL of the Amazon EMR Studio.
    url: ?[]const u8,

    /// The name of the IAM role assumed by users logged in to the Amazon EMR
    /// Studio. A Studio only requires a `UserRole` when you use IAM authentication.
    user_role: ?[]const u8,

    /// The ID of the VPC associated with the Amazon EMR Studio.
    vpc_id: ?[]const u8,

    /// The ID of the Workspace security group associated with the Amazon EMR
    /// Studio.
    /// The Workspace security group allows outbound network traffic to resources in
    /// the Engine
    /// security group and to the internet.
    workspace_security_group_id: ?[]const u8,

    pub const json_field_names = .{
        .auth_mode = "AuthMode",
        .creation_time = "CreationTime",
        .default_s3_location = "DefaultS3Location",
        .description = "Description",
        .encryption_key_arn = "EncryptionKeyArn",
        .engine_security_group_id = "EngineSecurityGroupId",
        .idc_instance_arn = "IdcInstanceArn",
        .idc_user_assignment = "IdcUserAssignment",
        .idp_auth_url = "IdpAuthUrl",
        .idp_relay_state_parameter_name = "IdpRelayStateParameterName",
        .name = "Name",
        .service_role = "ServiceRole",
        .studio_arn = "StudioArn",
        .studio_id = "StudioId",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .trusted_identity_propagation_enabled = "TrustedIdentityPropagationEnabled",
        .url = "Url",
        .user_role = "UserRole",
        .vpc_id = "VpcId",
        .workspace_security_group_id = "WorkspaceSecurityGroupId",
    };
};

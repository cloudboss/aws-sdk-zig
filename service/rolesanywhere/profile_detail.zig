const AttributeMapping = @import("attribute_mapping.zig").AttributeMapping;

/// The state of the profile after a read or write operation.
pub const ProfileDetail = struct {
    /// Used to determine if a custom role session name will be accepted in a
    /// temporary credential request.
    accept_role_session_name: ?bool = null,

    /// A mapping applied to the authenticating end-entity certificate.
    attribute_mappings: ?[]const AttributeMapping = null,

    /// The ISO-8601 timestamp when the profile was created.
    created_at: ?i64 = null,

    /// The Amazon Web Services account that created the profile.
    created_by: ?[]const u8 = null,

    /// Used to determine how long sessions vended using this profile are valid for.
    /// See the `Expiration` section of the [CreateSession API
    /// documentation](https://docs.aws.amazon.com/rolesanywhere/latest/userguide/authentication-create-session.html#credentials-object) page for more details. In requests, if this value is not provided, the default value will be 3600.
    duration_seconds: ?i32 = null,

    /// Indicates whether the profile is enabled.
    enabled: ?bool = null,

    /// A list of managed policy ARNs that apply to the vended session credentials.
    managed_policy_arns: ?[]const []const u8 = null,

    /// The name of the profile.
    name: ?[]const u8 = null,

    /// The ARN of the profile.
    profile_arn: ?[]const u8 = null,

    /// The unique identifier of the profile.
    profile_id: ?[]const u8 = null,

    /// Unused, saved for future use. Will likely specify whether instance
    /// properties are required in temporary credential requests with this profile.
    require_instance_properties: ?bool = null,

    /// A list of IAM roles that this profile can assume in a temporary credential
    /// request.
    role_arns: ?[]const []const u8 = null,

    /// A session policy that applies to the trust boundary of the vended session
    /// credentials.
    session_policy: ?[]const u8 = null,

    /// The ISO-8601 timestamp when the profile was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .accept_role_session_name = "acceptRoleSessionName",
        .attribute_mappings = "attributeMappings",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .duration_seconds = "durationSeconds",
        .enabled = "enabled",
        .managed_policy_arns = "managedPolicyArns",
        .name = "name",
        .profile_arn = "profileArn",
        .profile_id = "profileId",
        .require_instance_properties = "requireInstanceProperties",
        .role_arns = "roleArns",
        .session_policy = "sessionPolicy",
        .updated_at = "updatedAt",
    };
};

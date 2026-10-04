const InlinePolicy = @import("inline_policy.zig").InlinePolicy;
const managedByTypeType = @import("managed_by_type_type.zig").managedByTypeType;
const ParameterDefinition = @import("parameter_definition.zig").ParameterDefinition;
const TagTemplate = @import("tag_template.zig").TagTemplate;

/// Contains information about a version of an IAM role template, including the
/// configuration that is used to create roles with
/// [AcquireRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_AcquireRole.html). This structure
/// is returned as a response element by the
/// [GetRoleTemplateVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetRoleTemplateVersion.html) operation.
pub const RoleTemplateVersion = struct {
    /// The trust policy template that grants an entity permission to assume roles
    /// that you
    /// create from this template.
    assume_role_policy_document_template: ?[]const u8 = null,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the role template version was
    /// created.
    create_timestamp: ?i64 = null,

    /// The minor version that the service uses by default when you create a role
    /// from this template
    /// without specifying a minor version.
    default_minor_version: ?i32 = null,

    /// The description of the role template.
    description: ?[]const u8 = null,

    /// Specifies whether the role template is enabled. When a template is disabled,
    /// you cannot
    /// create roles from it.
    enabled: bool = false,

    /// A list of inline policy templates that the service embeds in roles that you
    /// create from
    /// this template.
    inline_policy_templates: ?[]const InlinePolicy = null,

    /// The major version number of the role template.
    major_version: ?i32 = null,

    /// Indicates that the role template is managed by an Amazon Web Services
    /// service.
    managed_by_type: ?managedByTypeType = null,

    /// The identifier of the Amazon Web Services service that manages the role
    /// template.
    managed_by_value: ?[]const u8 = null,

    /// A list of the ARNs of the managed policies that the service attaches to
    /// roles that you
    /// create from this template.
    managed_policy_arns: ?[]const []const u8 = null,

    /// The maximum session duration (in seconds) for roles that are created from
    /// this
    /// template.
    max_session_duration: ?i32 = null,

    /// The minor version number of this role template version.
    minor_version: ?i32 = null,

    /// A list of the parameters that are defined for this role template version.
    /// You supply
    /// values for these parameters when you create a role with
    /// [AcquireRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_AcquireRole.html).
    parameters_definition: ?[]const ParameterDefinition = null,

    /// The ARN of the policy that sets the permissions boundary for roles that you
    /// create from
    /// this template.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    permission_boundary_arn: ?[]const u8 = null,

    /// The pattern that is used to generate the description of a role that is
    /// created from this
    /// template.
    role_description_pattern: ?[]const u8 = null,

    /// The pattern that is used to generate the name of a role that is created from
    /// this
    /// template. The pattern can include `@{parameter}` placeholders that are
    /// replaced
    /// with the values you supply in the `ReplacementValues` parameter of
    /// [AcquireRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_AcquireRole.html).
    role_name_pattern: ?[]const u8 = null,

    /// The pattern that is used to generate the path of a role that is created from
    /// this
    /// template.
    role_path_pattern: ?[]const u8 = null,

    /// A list of tag templates that are applied to roles that are created from this
    /// template.
    role_tags_template: ?[]const TagTemplate = null,

    /// The Amazon Resource Name (ARN) that identifies the role template.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    template_arn: ?[]const u8 = null,

    /// The friendly name that identifies the role template.
    template_name: ?[]const u8 = null,

    /// The identifier of the role template version.
    template_version_id: ?[]const u8 = null,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the role template version was
    /// last updated.
    update_timestamp: ?i64 = null,

    /// Specifies whether this specific minor version of the role template is
    /// enabled.
    version_enabled: bool = false,
};

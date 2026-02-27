const PolicyTemplateName = @import("policy_template_name.zig").PolicyTemplateName;

/// Parameters to define a mitigation action that adds a blank policy to
/// restrict permissions.
pub const ReplaceDefaultPolicyVersionParams = struct {
    /// The name of the template to be applied. The only supported value is
    /// `BLANK_POLICY`.
    template_name: PolicyTemplateName,

    pub const json_field_names = .{
        .template_name = "templateName",
    };
};

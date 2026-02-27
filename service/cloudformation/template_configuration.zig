const GeneratedTemplateDeletionPolicy = @import("generated_template_deletion_policy.zig").GeneratedTemplateDeletionPolicy;
const GeneratedTemplateUpdateReplacePolicy = @import("generated_template_update_replace_policy.zig").GeneratedTemplateUpdateReplacePolicy;

/// The configuration details of a generated template.
pub const TemplateConfiguration = struct {
    /// The `DeletionPolicy` assigned to resources in the generated template.
    /// Supported
    /// values are:
    ///
    /// * `DELETE` - delete all resources when the stack is deleted.
    ///
    /// * `RETAIN` - retain all resources when the stack is deleted.
    ///
    /// For more information, see [DeletionPolicy
    /// attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-deletionpolicy.html) in the *CloudFormation User Guide*.
    deletion_policy: ?GeneratedTemplateDeletionPolicy,

    /// The `UpdateReplacePolicy` assigned to resources in the generated template.
    /// Supported values are:
    ///
    /// * `DELETE` - delete all resources when the resource is replaced during an
    ///   update
    /// operation.
    ///
    /// * `RETAIN` - retain all resources when the resource is replaced during an
    ///   update
    /// operation.
    ///
    /// For more information, see [UpdateReplacePolicy
    /// attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatereplacepolicy.html) in the *CloudFormation User Guide*.
    update_replace_policy: ?GeneratedTemplateUpdateReplacePolicy,
};

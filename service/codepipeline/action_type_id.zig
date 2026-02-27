const ActionCategory = @import("action_category.zig").ActionCategory;
const ActionOwner = @import("action_owner.zig").ActionOwner;

/// Represents information about an action type.
pub const ActionTypeId = struct {
    /// A category defines what kind of action can be taken in the stage, and
    /// constrains
    /// the provider type for the action. Valid categories are limited to one of the
    /// following
    /// values.
    ///
    /// * Source
    ///
    /// * Build
    ///
    /// * Test
    ///
    /// * Deploy
    ///
    /// * Invoke
    ///
    /// * Approval
    ///
    /// * Compute
    category: ActionCategory,

    /// The creator of the action being called. There are three valid values for the
    /// `Owner` field in the action category section within your pipeline
    /// structure: `AWS`, `ThirdParty`, and `Custom`. For more
    /// information, see [Valid Action Types and Providers in
    /// CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html#actions-valid-providers).
    owner: ActionOwner,

    /// The provider of the service being called by the action. Valid providers are
    /// determined by the action category. For example, an action in the Deploy
    /// category type
    /// might have a provider of CodeDeploy, which would be specified as
    /// `CodeDeploy`. For more information, see [Valid Action Types and Providers in
    /// CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html#actions-valid-providers).
    provider: []const u8,

    /// A string that describes the action version.
    version: []const u8,

    pub const json_field_names = .{
        .category = "category",
        .owner = "owner",
        .provider = "provider",
        .version = "version",
    };
};

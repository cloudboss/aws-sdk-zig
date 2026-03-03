/// Information about how to render the content.
pub const RenderingConfiguration = struct {
    /// A URI template containing exactly one variable in `${variableName} `format.
    /// This can only be set for `EXTERNAL` knowledge bases. For Salesforce,
    /// ServiceNow,
    /// and Zendesk, the variable must be one of the following:
    ///
    /// * Salesforce: `Id`, `ArticleNumber`, `VersionNumber`,
    /// `Title`, `PublishStatus`, or `IsDeleted`
    ///
    /// * ServiceNow: `number`, `short_description`,
    /// `sys_mod_count`, `workflow_state`, or `active`
    ///
    /// * Zendesk: `id`, `title`, `updated_at`, or
    /// `draft`
    ///
    /// The variable is replaced with the actual value for a piece of content when
    /// calling
    /// [GetContent](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_GetContent.html).
    template_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .template_uri = "templateUri",
    };
};

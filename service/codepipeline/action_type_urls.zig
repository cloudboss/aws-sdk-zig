/// Returns information about URLs for web pages that display to customers as
/// links on the
/// pipeline view, such as an external configuration page for the action type.
pub const ActionTypeUrls = struct {
    /// The URL returned to the CodePipeline console that contains a link to the
    /// page
    /// where customers can configure the external action.
    configuration_url: ?[]const u8 = null,

    /// The URL returned to the CodePipeline console that provides a deep link to
    /// the
    /// resources of the external system, such as a status page. This link is
    /// provided as part
    /// of the action display in the pipeline.
    entity_url_template: ?[]const u8 = null,

    /// The link to an execution page for the action type in progress. For example,
    /// for a
    /// CodeDeploy action, this link is shown on the pipeline view page in the
    /// CodePipeline console, and it links to a CodeDeploy status page.
    execution_url_template: ?[]const u8 = null,

    /// The URL returned to the CodePipeline console that contains a link to the
    /// page
    /// where customers can update or change the configuration of the external
    /// action.
    revision_url_template: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_url = "configurationUrl",
        .entity_url_template = "entityUrlTemplate",
        .execution_url_template = "executionUrlTemplate",
        .revision_url_template = "revisionUrlTemplate",
    };
};

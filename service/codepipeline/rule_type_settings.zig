/// Returns information about the settings for a rule type.
pub const RuleTypeSettings = struct {
    /// The URL returned to the CodePipeline console that provides a deep link to
    /// the
    /// resources of the external system, such as the configuration page for a
    /// CodeDeploy
    /// deployment group. This link is provided as part of the action display in the
    /// pipeline.
    entity_url_template: ?[]const u8 = null,

    /// The URL returned to the CodePipeline console that contains a link to the
    /// top-level landing page for the external system, such as the console page for
    /// CodeDeploy.
    /// This link is shown on the pipeline view page in the CodePipeline console and
    /// provides a link to the execution entity of the external action.
    execution_url_template: ?[]const u8 = null,

    /// The URL returned to the CodePipeline console that contains a link to the
    /// page
    /// where customers can update or change the configuration of the external
    /// action.
    revision_url_template: ?[]const u8 = null,

    /// The URL of a sign-up page where users can sign up for an external service
    /// and perform
    /// initial configuration of the action provided by that service.
    third_party_configuration_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity_url_template = "entityUrlTemplate",
        .execution_url_template = "executionUrlTemplate",
        .revision_url_template = "revisionUrlTemplate",
        .third_party_configuration_url = "thirdPartyConfigurationUrl",
    };
};

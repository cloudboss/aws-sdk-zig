const GitConfiguration = @import("git_configuration.zig").GitConfiguration;
const PipelineTriggerProviderType = @import("pipeline_trigger_provider_type.zig").PipelineTriggerProviderType;

/// Represents information about the specified trigger configuration, such as
/// the
/// filter criteria and the source stage for the action that contains the
/// trigger.
///
/// This is only supported for the `CodeStarSourceConnection` action
/// type.
///
/// When a trigger configuration is specified, default change detection for
/// repository and branch commits is disabled.
pub const PipelineTriggerDeclaration = struct {
    /// Provides the filter criteria and the source stage for the repository event
    /// that
    /// starts the pipeline, such as Git tags.
    git_configuration: GitConfiguration,

    /// The source provider for the event, such as connections configured for a
    /// repository
    /// with Git tags, for the specified trigger configuration.
    provider_type: PipelineTriggerProviderType,

    pub const json_field_names = .{
        .git_configuration = "gitConfiguration",
        .provider_type = "providerType",
    };
};

/// Container for information about an OpenSearch Ingestion blueprint.
pub const PipelineBlueprint = struct {
    /// The name of the blueprint.
    blueprint_name: ?[]const u8,

    /// A description of the blueprint.
    display_description: ?[]const u8,

    /// The display name of the blueprint.
    display_name: ?[]const u8,

    /// The YAML configuration of the blueprint.
    pipeline_configuration_body: ?[]const u8,

    /// The name of the service that the blueprint is associated with.
    service: ?[]const u8,

    /// The use case that the blueprint relates to.
    use_case: ?[]const u8,

    pub const json_field_names = .{
        .blueprint_name = "BlueprintName",
        .display_description = "DisplayDescription",
        .display_name = "DisplayName",
        .pipeline_configuration_body = "PipelineConfigurationBody",
        .service = "Service",
        .use_case = "UseCase",
    };
};

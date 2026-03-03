/// A summary of an OpenSearch Ingestion blueprint.
pub const PipelineBlueprintSummary = struct {
    /// The name of the blueprint.
    blueprint_name: ?[]const u8 = null,

    /// A description of the blueprint.
    display_description: ?[]const u8 = null,

    /// The display name of the blueprint.
    display_name: ?[]const u8 = null,

    /// The name of the service that the blueprint is associated with.
    service: ?[]const u8 = null,

    /// The use case that the blueprint relates to.
    use_case: ?[]const u8 = null,

    pub const json_field_names = .{
        .blueprint_name = "BlueprintName",
        .display_description = "DisplayDescription",
        .display_name = "DisplayName",
        .service = "Service",
        .use_case = "UseCase",
    };
};

const CompatibleEnvironmentTemplate = @import("compatible_environment_template.zig").CompatibleEnvironmentTemplate;
const TemplateVersionStatus = @import("template_version_status.zig").TemplateVersionStatus;
const ServiceTemplateSupportedComponentSourceType = @import("service_template_supported_component_source_type.zig").ServiceTemplateSupportedComponentSourceType;

/// Detailed data of an Proton service template version resource.
pub const ServiceTemplateVersion = struct {
    /// The Amazon Resource Name (ARN) of the version of a service template.
    arn: []const u8,

    /// An array of compatible environment template names for the major version of a
    /// service
    /// template.
    compatible_environment_templates: []const CompatibleEnvironmentTemplate,

    /// The time when the version of a service template was created.
    created_at: i64,

    /// A description of the version of a service template.
    description: ?[]const u8 = null,

    /// The time when the version of a service template was last modified.
    last_modified_at: i64,

    /// The latest major version that's associated with the version of a service
    /// template.
    major_version: []const u8,

    /// The minor version of a service template.
    minor_version: []const u8,

    /// The recommended minor version of the service template.
    recommended_minor_version: ?[]const u8 = null,

    /// The schema of the version of a service template.
    schema: ?[]const u8 = null,

    /// The service template version status.
    status: TemplateVersionStatus,

    /// A service template version status message.
    status_message: ?[]const u8 = null,

    /// An array of supported component sources. Components with supported sources
    /// can be attached
    /// to service instances based on this service template version.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    supported_component_sources: ?[]const ServiceTemplateSupportedComponentSourceType = null,

    /// The name of the version of a service template.
    template_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .compatible_environment_templates = "compatibleEnvironmentTemplates",
        .created_at = "createdAt",
        .description = "description",
        .last_modified_at = "lastModifiedAt",
        .major_version = "majorVersion",
        .minor_version = "minorVersion",
        .recommended_minor_version = "recommendedMinorVersion",
        .schema = "schema",
        .status = "status",
        .status_message = "statusMessage",
        .supported_component_sources = "supportedComponentSources",
        .template_name = "templateName",
    };
};

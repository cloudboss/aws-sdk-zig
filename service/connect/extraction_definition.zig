const aws = @import("aws");

const ExtractionDefinitionDisplay = @import("extraction_definition_display.zig").ExtractionDefinitionDisplay;
const ExtractionConfiguration = @import("extraction_configuration.zig").ExtractionConfiguration;

/// Information about an extraction definition.
pub const ExtractionDefinition = struct {
    /// The timestamp when the extraction definition was created.
    created_time: i64,

    /// The display settings for the extraction definition.
    display: ?ExtractionDefinitionDisplay = null,

    /// The configuration that defines how data is extracted.
    extraction_configuration: ExtractionConfiguration,

    /// The Amazon Resource Name (ARN) of the extraction definition.
    extraction_definition_arn: []const u8,

    /// The identifier of the extraction definition.
    extraction_definition_id: []const u8,

    /// The Amazon Resource Name (ARN) of the user who last updated the extraction
    /// definition.
    last_updated_by: []const u8,

    /// The timestamp when the extraction definition was last updated.
    last_updated_time: i64,

    /// The name of the extraction definition.
    name: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .display = "Display",
        .extraction_configuration = "ExtractionConfiguration",
        .extraction_definition_arn = "ExtractionDefinitionArn",
        .extraction_definition_id = "ExtractionDefinitionId",
        .last_updated_by = "LastUpdatedBy",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .tags = "Tags",
    };
};

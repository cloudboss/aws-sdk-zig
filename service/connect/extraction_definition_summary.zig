/// Summary information about an extraction definition.
pub const ExtractionDefinitionSummary = struct {
    /// The timestamp when the extraction definition was created.
    created_time: i64,

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

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .extraction_definition_arn = "ExtractionDefinitionArn",
        .extraction_definition_id = "ExtractionDefinitionId",
        .last_updated_by = "LastUpdatedBy",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
    };
};

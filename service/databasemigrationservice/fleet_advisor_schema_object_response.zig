/// Describes a schema object in a Fleet Advisor collector inventory.
pub const FleetAdvisorSchemaObjectResponse = struct {
    /// The number of lines of code in a schema object in a Fleet Advisor collector
    /// inventory.
    code_line_count: ?i64 = null,

    /// The size level of the code in a schema object in a Fleet Advisor collector
    /// inventory.
    code_size: ?i64 = null,

    /// The number of objects in a schema object in a Fleet Advisor collector
    /// inventory.
    number_of_objects: ?i64 = null,

    /// The type of the schema object, as reported by the database engine. Examples
    /// include
    /// the following:
    ///
    /// * `function`
    ///
    /// * `trigger`
    ///
    /// * `SYSTEM_TABLE`
    ///
    /// * `QUEUE`
    object_type: ?[]const u8 = null,

    /// The ID of a schema object in a Fleet Advisor collector inventory.
    schema_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_line_count = "CodeLineCount",
        .code_size = "CodeSize",
        .number_of_objects = "NumberOfObjects",
        .object_type = "ObjectType",
        .schema_id = "SchemaId",
    };
};

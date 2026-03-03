/// Describes an individual setting that controls some aspect of MemoryDB
/// behavior across multiple regions.
pub const MultiRegionParameter = struct {
    /// The valid range of values for the parameter.
    allowed_values: ?[]const u8 = null,

    /// The valid data type for the parameter.
    data_type: ?[]const u8 = null,

    /// A description of the parameter.
    description: ?[]const u8 = null,

    /// The earliest engine version to which the parameter can apply.
    minimum_engine_version: ?[]const u8 = null,

    /// The name of the parameter.
    name: ?[]const u8 = null,

    /// Indicates the source of the parameter value. Valid values: user | system |
    /// engine-default
    source: ?[]const u8 = null,

    /// The value of the parameter.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .data_type = "DataType",
        .description = "Description",
        .minimum_engine_version = "MinimumEngineVersion",
        .name = "Name",
        .source = "Source",
        .value = "Value",
    };
};

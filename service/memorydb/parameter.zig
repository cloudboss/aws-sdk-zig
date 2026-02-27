/// Describes an individual setting that controls some aspect of MemoryDB
/// behavior.
pub const Parameter = struct {
    /// The valid range of values for the parameter.
    allowed_values: ?[]const u8,

    /// The parameter's data type
    data_type: ?[]const u8,

    /// A description of the parameter
    description: ?[]const u8,

    /// The earliest engine version to which the parameter can apply.
    minimum_engine_version: ?[]const u8,

    /// The name of the parameter
    name: ?[]const u8,

    /// The value of the parameter
    value: ?[]const u8,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .data_type = "DataType",
        .description = "Description",
        .minimum_engine_version = "MinimumEngineVersion",
        .name = "Name",
        .value = "Value",
    };
};

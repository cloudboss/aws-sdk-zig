/// Represents the output of a CreateParameterGroup operation. A parameter group
/// represents a combination of specific values for the parameters that are
/// passed to the engine software during startup.
pub const ParameterGroup = struct {
    /// The Amazon Resource Name (ARN) of the parameter group
    arn: ?[]const u8 = null,

    /// A description of the parameter group
    description: ?[]const u8 = null,

    /// The name of the parameter group family that this parameter group is
    /// compatible with.
    family: ?[]const u8 = null,

    /// The name of the parameter group
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .description = "Description",
        .family = "Family",
        .name = "Name",
    };
};

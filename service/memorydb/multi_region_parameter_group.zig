/// Represents the output of a CreateMultiRegionParameterGroup operation. A
/// multi-region parameter group represents a collection of parameters that can
/// be applied to clusters across multiple regions.
pub const MultiRegionParameterGroup = struct {
    /// The Amazon Resource Name (ARN) of the multi-region parameter group.
    arn: ?[]const u8 = null,

    /// A description of the multi-region parameter group.
    description: ?[]const u8 = null,

    /// The name of the parameter group family that this multi-region parameter
    /// group is compatible with.
    family: ?[]const u8 = null,

    /// The name of the multi-region parameter group.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .description = "Description",
        .family = "Family",
        .name = "Name",
    };
};

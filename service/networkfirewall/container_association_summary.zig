/// The metadata for a container association returned by
/// `ListContainerAssociations`. Contains the ARN
/// and name that you use to identify the container association in other
/// operations.
pub const ContainerAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the container association.
    arn: ?[]const u8 = null,

    /// The descriptive name of the container association.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};

/// The data type used to describe the relationship between different sources.
pub const AssociationInfo = struct {
    /// The Amazon Resource Name (ARN) of the `AssociationInfo` destination.
    destination_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the `AssociationInfo` source.
    source_arn: []const u8,

    pub const json_field_names = .{
        .destination_arn = "DestinationArn",
        .source_arn = "SourceArn",
    };
};

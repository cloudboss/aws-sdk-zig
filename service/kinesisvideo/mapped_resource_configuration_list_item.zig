/// A structure that encapsulates, or contains, the media storage configuration
/// properties.
pub const MappedResourceConfigurationListItem = struct {
    /// The Amazon Resource Name (ARN) of the Kinesis Video Stream resource,
    /// associated with the stream.
    arn: ?[]const u8,

    /// The type of the associated resource for the kinesis video stream.
    type: ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .type = "Type",
    };
};

/// A structure that contains information about one of this source account's
/// links to a monitoring account.
pub const ListLinksItem = struct {
    /// The ARN of the link.
    arn: ?[]const u8,

    /// The random ID string that Amazon Web Services generated as part of the link
    /// ARN.
    id: ?[]const u8,

    /// The label that was assigned to this link at creation, with the variables
    /// resolved to their actual values.
    label: ?[]const u8,

    /// The resource types supported by this link.
    resource_types: ?[]const []const u8,

    /// The ARN of the sink that this link is attached to.
    sink_arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .label = "Label",
        .resource_types = "ResourceTypes",
        .sink_arn = "SinkArn",
    };
};

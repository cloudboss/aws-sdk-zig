/// A structure that contains information about one link attached to this
/// monitoring account sink.
pub const ListAttachedLinksItem = struct {
    /// The label that was assigned to this link at creation, with the variables
    /// resolved to their actual values.
    label: ?[]const u8 = null,

    /// The ARN of the link.
    link_arn: ?[]const u8 = null,

    /// The resource types supported by this link.
    resource_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .label = "Label",
        .link_arn = "LinkArn",
        .resource_types = "ResourceTypes",
    };
};

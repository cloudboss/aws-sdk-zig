const aws = @import("aws");

/// Specifies the display name of an application and the tags to associate with
/// the application.
pub const CreateApplicationRequest = struct {
    /// The display name of the application. This name is displayed as the **Project
    /// name** on the Amazon Pinpoint console.
    name: []const u8,

    /// A string-to-string map of key-value pairs that defines the tags to associate
    /// with the application. Each tag consists of a required tag key and an
    /// associated tag value.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .name = "Name",
        .tags = "tags",
    };
};

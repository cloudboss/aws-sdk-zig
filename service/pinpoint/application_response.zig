const aws = @import("aws");

/// Provides information about an application.
pub const ApplicationResponse = struct {
    /// The Amazon Resource Name (ARN) of the application.
    arn: []const u8,

    /// The date and time when the Application was created.
    creation_date: ?[]const u8 = null,

    /// The unique identifier for the application. This identifier is displayed as
    /// the **Project ID** on the Amazon Pinpoint console.
    id: []const u8,

    /// The display name of the application. This name is displayed as the **Project
    /// name** on the Amazon Pinpoint console.
    name: []const u8,

    /// A string-to-string map of key-value pairs that identifies the tags that are
    /// associated with the application. Each tag consists of a required tag key and
    /// an associated tag value.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .id = "Id",
        .name = "Name",
        .tags = "tags",
    };
};

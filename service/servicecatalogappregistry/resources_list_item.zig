/// The resource in a list of resources.
pub const ResourcesListItem = struct {
    /// The message returned if the call fails.
    error_message: ?[]const u8,

    /// The Amazon resource name (ARN) of the resource.
    resource_arn: ?[]const u8,

    /// Provides information about the AppRegistry resource type.
    resource_type: ?[]const u8,

    /// The status of the list item.
    status: ?[]const u8,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .resource_arn = "resourceArn",
        .resource_type = "resourceType",
        .status = "status",
    };
};

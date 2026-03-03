const ApplicationTagStatus = @import("application_tag_status.zig").ApplicationTagStatus;
const ResourcesListItem = @import("resources_list_item.zig").ResourcesListItem;

/// The result of the application tag that's applied to a resource.
pub const ApplicationTagResult = struct {
    /// The application tag is in the process of being applied to a resource, was
    /// successfully applied to a resource, or failed to apply to a resource.
    application_tag_status: ?ApplicationTagStatus = null,

    /// The message returned if the call fails.
    error_message: ?[]const u8 = null,

    /// A unique pagination token for each page of results. Make the call again with
    /// the returned token to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The resources associated with an application
    resources: ?[]const ResourcesListItem = null,

    pub const json_field_names = .{
        .application_tag_status = "applicationTagStatus",
        .error_message = "errorMessage",
        .next_token = "nextToken",
        .resources = "resources",
    };
};

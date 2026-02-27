const ResourceDataContainer = @import("resource_data_container.zig").ResourceDataContainer;

/// Information about a resource.
pub const Resource = struct {
    /// The resource ID, used to refer to a resource in the Lambda function
    /// configuration. Max length is 128 characters with pattern
    /// ''[a-zA-Z0-9:_-]+''. This must be unique within a Greengrass group.
    id: []const u8,

    /// The descriptive resource name, which is displayed on the AWS IoT Greengrass
    /// console. Max length 128 characters with pattern ''[a-zA-Z0-9:_-]+''. This
    /// must be unique within a Greengrass group.
    name: []const u8,

    /// A container of data for all resource types.
    resource_data_container: ResourceDataContainer,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .resource_data_container = "ResourceDataContainer",
    };
};

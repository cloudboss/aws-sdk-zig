const aws = @import("aws");

const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Information about a related resource.
pub const RelatedResource = struct {
    /// Other information about the resource.
    additional_info: ?[]const aws.map.StringMapEntry = null,

    /// Information that identifies the resource.
    resource_identifier: ?ResourceIdentifier = null,

    /// The type of resource.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .additional_info = "additionalInfo",
        .resource_identifier = "resourceIdentifier",
        .resource_type = "resourceType",
    };
};

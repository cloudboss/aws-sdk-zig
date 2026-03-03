const aws = @import("aws");

const ResourceDetails = @import("resource_details.zig").ResourceDetails;

/// Details about the resource involved in a finding.
pub const Resource = struct {
    /// An object that contains details about the resource involved in a finding.
    details: ?ResourceDetails = null,

    /// The ID of the resource.
    id: ?[]const u8 = null,

    /// The tags attached to the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of resource.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .details = "details",
        .id = "id",
        .tags = "tags",
        .@"type" = "type",
    };
};

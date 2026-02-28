const aws = @import("aws");

const ResourceDetails = @import("resource_details.zig").ResourceDetails;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Details about the resource involved in a finding.
pub const Resource = struct {
    /// An object that contains details about the resource involved in a finding.
    details: ?ResourceDetails,

    /// The ID of the resource.
    id: []const u8,

    /// The partition of the resource.
    partition: ?[]const u8,

    /// The Amazon Web Services Region the impacted resource is located in.
    region: ?[]const u8,

    /// The tags attached to the resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// The type of resource.
    @"type": ResourceType,

    pub const json_field_names = .{
        .details = "details",
        .id = "id",
        .partition = "partition",
        .region = "region",
        .tags = "tags",
        .@"type" = "type",
    };
};

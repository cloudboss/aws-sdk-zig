const ResourceData = @import("resource_data.zig").ResourceData;
const FindingResourceType = @import("finding_resource_type.zig").FindingResourceType;
const Tag = @import("tag.zig").Tag;

/// Contains information about the Amazon Web Services resource that is
/// associated with the GuardDuty finding.
pub const ResourceV2 = struct {
    /// The Amazon Web Services account ID to which the resource belongs.
    account_id: ?[]const u8,

    /// The cloud partition within the Amazon Web Services Region to which the
    /// resource belongs.
    cloud_partition: ?[]const u8,

    /// Contains information about the Amazon Web Services resource associated with
    /// the activity that prompted
    /// GuardDuty to generate a finding.
    data: ?ResourceData,

    /// The name of the resource.
    name: ?[]const u8,

    /// The Amazon Web Services Region where the resource belongs.
    region: ?[]const u8,

    /// The type of the Amazon Web Services resource.
    resource_type: FindingResourceType,

    /// The Amazon Web Services service of the resource.
    service: ?[]const u8,

    /// Contains information about the tags associated with the resource.
    tags: ?[]const Tag,

    /// The unique identifier of the resource.
    uid: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .cloud_partition = "CloudPartition",
        .data = "Data",
        .name = "Name",
        .region = "Region",
        .resource_type = "ResourceType",
        .service = "Service",
        .tags = "Tags",
        .uid = "Uid",
    };
};

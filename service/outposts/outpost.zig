const aws = @import("aws");

const SupportedHardwareType = @import("supported_hardware_type.zig").SupportedHardwareType;

/// Information about an Outpost.
pub const Outpost = struct {
    availability_zone: ?[]const u8,

    availability_zone_id: ?[]const u8,

    description: ?[]const u8,

    life_cycle_status: ?[]const u8,

    name: ?[]const u8,

    outpost_arn: ?[]const u8,

    /// The ID of the Outpost.
    outpost_id: ?[]const u8,

    owner_id: ?[]const u8,

    site_arn: ?[]const u8,

    site_id: ?[]const u8,

    /// The hardware type.
    supported_hardware_type: ?SupportedHardwareType,

    /// The Outpost tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .availability_zone_id = "AvailabilityZoneId",
        .description = "Description",
        .life_cycle_status = "LifeCycleStatus",
        .name = "Name",
        .outpost_arn = "OutpostArn",
        .outpost_id = "OutpostId",
        .owner_id = "OwnerId",
        .site_arn = "SiteArn",
        .site_id = "SiteId",
        .supported_hardware_type = "SupportedHardwareType",
        .tags = "Tags",
    };
};

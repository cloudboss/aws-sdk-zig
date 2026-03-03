const aws = @import("aws");

const SupportedHardwareType = @import("supported_hardware_type.zig").SupportedHardwareType;

/// Information about an Outpost.
pub const Outpost = struct {
    availability_zone: ?[]const u8 = null,

    availability_zone_id: ?[]const u8 = null,

    description: ?[]const u8 = null,

    life_cycle_status: ?[]const u8 = null,

    name: ?[]const u8 = null,

    outpost_arn: ?[]const u8 = null,

    /// The ID of the Outpost.
    outpost_id: ?[]const u8 = null,

    owner_id: ?[]const u8 = null,

    site_arn: ?[]const u8 = null,

    site_id: ?[]const u8 = null,

    /// The hardware type.
    supported_hardware_type: ?SupportedHardwareType = null,

    /// The Outpost tags.
    tags: ?[]const aws.map.StringMapEntry = null,

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

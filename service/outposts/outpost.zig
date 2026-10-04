const aws = @import("aws");

const OutpostGeneration = @import("outpost_generation.zig").OutpostGeneration;
const RackScalingType = @import("rack_scaling_type.zig").RackScalingType;
const SupportedHardwareType = @import("supported_hardware_type.zig").SupportedHardwareType;

/// Information about an Outpost.
pub const Outpost = struct {
    availability_zone: ?[]const u8 = null,

    availability_zone_id: ?[]const u8 = null,

    description: ?[]const u8 = null,

    /// The Outpost generation. Valid values are `GENERATION_1` for first-generation
    /// rack deployments and `GENERATION_2` for second-generation rack deployments.
    generation: ?OutpostGeneration = null,

    life_cycle_status: ?[]const u8 = null,

    name: ?[]const u8 = null,

    outpost_arn: ?[]const u8 = null,

    /// The ID of the Outpost.
    outpost_id: ?[]const u8 = null,

    owner_id: ?[]const u8 = null,

    /// The rack scaling type. Valid values are `SINGLE_RACK` for single-rack
    /// Outposts and `MULTI_RACK` for multi-rack Outposts that can expand across
    /// multiple racks.
    rack_scaling_type: ?RackScalingType = null,

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
        .generation = "Generation",
        .life_cycle_status = "LifeCycleStatus",
        .name = "Name",
        .outpost_arn = "OutpostArn",
        .outpost_id = "OutpostId",
        .owner_id = "OwnerId",
        .rack_scaling_type = "RackScalingType",
        .site_arn = "SiteArn",
        .site_id = "SiteId",
        .supported_hardware_type = "SupportedHardwareType",
        .tags = "Tags",
    };
};

const RegionName = @import("region_name.zig").RegionName;

/// Describes the resource location.
pub const ResourceLocation = struct {
    /// The Availability Zone. Follows the format `us-east-2a` (case-sensitive).
    availability_zone: ?[]const u8,

    /// The Amazon Web Services Region name.
    region_name: ?RegionName,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .region_name = "regionName",
    };
};

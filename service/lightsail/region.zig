const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const RegionName = @import("region_name.zig").RegionName;

/// Describes the Amazon Web Services Region.
pub const Region = struct {
    /// The Availability Zones. Follows the format `us-east-2a`
    /// (case-sensitive).
    availability_zones: ?[]const AvailabilityZone = null,

    /// The continent code (`NA`, meaning North America).
    continent_code: ?[]const u8 = null,

    /// The description of the Amazon Web Services Region (`This region is
    /// recommended to
    /// serve users in the eastern United States and eastern Canada`).
    description: ?[]const u8 = null,

    /// The display name (`Ohio`).
    display_name: ?[]const u8 = null,

    /// The region name (`us-east-2`).
    name: ?RegionName = null,

    /// The Availability Zones for databases. Follows the format `us-east-2a`
    /// (case-sensitive).
    relational_database_availability_zones: ?[]const AvailabilityZone = null,

    pub const json_field_names = .{
        .availability_zones = "availabilityZones",
        .continent_code = "continentCode",
        .description = "description",
        .display_name = "displayName",
        .name = "name",
        .relational_database_availability_zones = "relationalDatabaseAvailabilityZones",
    };
};

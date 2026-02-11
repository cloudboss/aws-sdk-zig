/// Represents the properties of a replica.
pub const Replica = struct {
    /// The Region where the replica needs to be created.
    region_name: ?[]const u8,

    pub const json_field_names = .{
        .region_name = "RegionName",
    };
};

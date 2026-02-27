/// The Amazon Web Services Region.
pub const Region = union(enum) {
    /// The Amazon Web Services Region name.
    region_name: ?[]const u8,
    /// The region name path.
    region_name_path: ?[]const u8,

    pub const json_field_names = .{
        .region_name = "regionName",
        .region_name_path = "regionNamePath",
    };
};

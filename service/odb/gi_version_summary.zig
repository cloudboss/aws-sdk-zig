/// Information about a specific version of Oracle Grid Infrastructure (GI)
/// software that can be installed on a VM cluster.
pub const GiVersionSummary = struct {
    /// The GI software version.
    version: ?[]const u8,

    pub const json_field_names = .{
        .version = "version",
    };
};

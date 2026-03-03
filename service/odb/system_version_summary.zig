/// Information about the compatible system versions that can be used with a
/// specific Exadata shape and Grid Infrastructure (GI) version.
pub const SystemVersionSummary = struct {
    /// The version of GI software.
    gi_version: ?[]const u8 = null,

    /// The Exadata hardware model.
    shape: ?[]const u8 = null,

    /// The Exadata system versions that are compatible with the specified Exadata
    /// shape and GI version.
    system_versions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .gi_version = "giVersion",
        .shape = "shape",
        .system_versions = "systemVersions",
    };
};

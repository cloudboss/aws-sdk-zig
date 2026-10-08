/// Source code file supporting a threat.
pub const ThreatEvidenceShape = struct {
    /// The package identifier containing the evidence file.
    package_id: ?[]const u8 = null,

    /// The file path of the evidence.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .package_id = "packageId",
        .path = "path",
    };
};

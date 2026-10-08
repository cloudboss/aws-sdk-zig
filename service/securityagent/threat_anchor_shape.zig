/// DFD element that a threat is anchored to.
pub const ThreatAnchorShape = struct {
    /// The identifier of the DFD element.
    id: ?[]const u8 = null,

    /// The kind of DFD element.
    kind: ?[]const u8 = null,

    /// The package identifier containing the DFD element.
    package_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .kind = "kind",
        .package_id = "packageId",
    };
};

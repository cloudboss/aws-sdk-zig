/// Specifies the domain unit(s) whose projects can use this asset type while
/// creating asset or asset revisions.
pub const UseAssetTypePolicyGrantDetail = struct {
    /// The ID of the domain unit.
    domain_unit_id: ?[]const u8,

    pub const json_field_names = .{
        .domain_unit_id = "domainUnitId",
    };
};

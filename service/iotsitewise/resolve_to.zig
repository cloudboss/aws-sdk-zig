/// The detailed resource this execution summary resolves to.
pub const ResolveTo = struct {
    /// The ID of the asset that the resource resolves to.
    asset_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
    };
};

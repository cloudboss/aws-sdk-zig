const NielsenCBET = @import("nielsen_cbet.zig").NielsenCBET;
const NielsenWatermarksDistributionTypes = @import("nielsen_watermarks_distribution_types.zig").NielsenWatermarksDistributionTypes;
const NielsenNaesIiNw = @import("nielsen_naes_ii_nw.zig").NielsenNaesIiNw;
const NielsenNwOnly = @import("nielsen_nw_only.zig").NielsenNwOnly;

/// Nielsen Watermarks Settings
pub const NielsenWatermarksSettings = struct {
    /// Complete these fields only if you want to insert watermarks of type Nielsen
    /// CBET
    nielsen_cbet_settings: ?NielsenCBET = null,

    /// Choose the distribution types that you want to assign to the watermarks:
    /// - PROGRAM_CONTENT
    /// - FINAL_DISTRIBUTOR
    nielsen_distribution_type: ?NielsenWatermarksDistributionTypes = null,

    /// Complete these fields only if you want to insert watermarks of type Nielsen
    /// NAES II (N2) and Nielsen NAES VI (NW).
    nielsen_naes_ii_nw_settings: ?NielsenNaesIiNw = null,

    /// Complete these fields only if you want to insert watermarks of type Nielsen
    /// NAES VI (NW) only,
    /// without inserting NAES II (N2) watermarks.
    nielsen_nw_only_settings: ?NielsenNwOnly = null,

    pub const json_field_names = .{
        .nielsen_cbet_settings = "NielsenCbetSettings",
        .nielsen_distribution_type = "NielsenDistributionType",
        .nielsen_naes_ii_nw_settings = "NielsenNaesIiNwSettings",
        .nielsen_nw_only_settings = "NielsenNwOnlySettings",
    };
};

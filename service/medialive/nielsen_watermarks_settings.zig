const NielsenCBET = @import("nielsen_cbet.zig").NielsenCBET;
const NielsenWatermarksDistributionTypes = @import("nielsen_watermarks_distribution_types.zig").NielsenWatermarksDistributionTypes;
const NielsenNaesIiNw = @import("nielsen_naes_ii_nw.zig").NielsenNaesIiNw;

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

    pub const json_field_names = .{
        .nielsen_cbet_settings = "NielsenCbetSettings",
        .nielsen_distribution_type = "NielsenDistributionType",
        .nielsen_naes_ii_nw_settings = "NielsenNaesIiNwSettings",
    };
};

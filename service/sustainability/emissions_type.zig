const std = @import("std");

/// Specifies the types of carbon emissions calculations available.
pub const EmissionsType = enum {
    /// Total direct, indirect, and value chain emissions, calculated using GHG
    /// Protocol's Location-based method (LBM).
    total_lbm_carbon_emissions,
    /// Total direct, indirect, and value chain emissions, calculated using GHG
    /// Protocol's Market-based method (MBM).
    total_mbm_carbon_emissions,
    /// Total direct emissions from Amazon Web Services owned or controlled sources.
    total_scope_1_carbon_emissions,
    /// Total indirect emissions from the production of purchased energy, calculated
    /// using GHG Protocol's Location-based method (LBM).
    total_scope_2_lbm_carbon_emissions,
    /// Total indirect emissions from the production of purchased energy, calculated
    /// using GHG Protocol's Market-based method (MBM).
    total_scope_2_mbm_carbon_emissions,
    /// Total value chain emissions, calculated using GHG Protocol's Location-based
    /// method (LBM).
    total_scope_3_lbm_carbon_emissions,
    /// Total value chain emissions, calculated using GHG Protocol's Market-based
    /// method (MBM).
    total_scope_3_mbm_carbon_emissions,

    pub const json_field_names = .{
        .total_lbm_carbon_emissions = "TOTAL_LBM_CARBON_EMISSIONS",
        .total_mbm_carbon_emissions = "TOTAL_MBM_CARBON_EMISSIONS",
        .total_scope_1_carbon_emissions = "TOTAL_SCOPE_1_CARBON_EMISSIONS",
        .total_scope_2_lbm_carbon_emissions = "TOTAL_SCOPE_2_LBM_CARBON_EMISSIONS",
        .total_scope_2_mbm_carbon_emissions = "TOTAL_SCOPE_2_MBM_CARBON_EMISSIONS",
        .total_scope_3_lbm_carbon_emissions = "TOTAL_SCOPE_3_LBM_CARBON_EMISSIONS",
        .total_scope_3_mbm_carbon_emissions = "TOTAL_SCOPE_3_MBM_CARBON_EMISSIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .total_lbm_carbon_emissions => "TOTAL_LBM_CARBON_EMISSIONS",
            .total_mbm_carbon_emissions => "TOTAL_MBM_CARBON_EMISSIONS",
            .total_scope_1_carbon_emissions => "TOTAL_SCOPE_1_CARBON_EMISSIONS",
            .total_scope_2_lbm_carbon_emissions => "TOTAL_SCOPE_2_LBM_CARBON_EMISSIONS",
            .total_scope_2_mbm_carbon_emissions => "TOTAL_SCOPE_2_MBM_CARBON_EMISSIONS",
            .total_scope_3_lbm_carbon_emissions => "TOTAL_SCOPE_3_LBM_CARBON_EMISSIONS",
            .total_scope_3_mbm_carbon_emissions => "TOTAL_SCOPE_3_MBM_CARBON_EMISSIONS",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

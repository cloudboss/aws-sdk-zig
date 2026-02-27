const LteCellDetails = @import("lte_cell_details.zig").LteCellDetails;

/// The cellular network communication infrastructure that the device uses.
pub const CellSignals = struct {
    /// Information about the Long-Term Evolution (LTE) network the device is
    /// connected to.
    lte_cell_details: []const LteCellDetails,

    pub const json_field_names = .{
        .lte_cell_details = "LteCellDetails",
    };
};

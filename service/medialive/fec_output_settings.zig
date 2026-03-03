const FecOutputIncludeFec = @import("fec_output_include_fec.zig").FecOutputIncludeFec;

/// Fec Output Settings
pub const FecOutputSettings = struct {
    /// Parameter D from SMPTE 2022-1. The height of the FEC protection matrix. The
    /// number of transport stream packets per column error correction packet. Must
    /// be between 4 and 20, inclusive.
    column_depth: ?i32 = null,

    /// Enables column only or column and row based FEC
    include_fec: ?FecOutputIncludeFec = null,

    /// Parameter L from SMPTE 2022-1. The width of the FEC protection matrix. Must
    /// be between 1 and 20, inclusive. If only Column FEC is used, then larger
    /// values increase robustness. If Row FEC is used, then this is the number of
    /// transport stream packets per row error correction packet, and the value must
    /// be between 4 and 20, inclusive, if includeFec is columnAndRow. If includeFec
    /// is column, this value must be 1 to 20, inclusive.
    row_length: ?i32 = null,

    pub const json_field_names = .{
        .column_depth = "ColumnDepth",
        .include_fec = "IncludeFec",
        .row_length = "RowLength",
    };
};

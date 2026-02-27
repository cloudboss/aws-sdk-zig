const NielsenWatermarksCbetStepaside = @import("nielsen_watermarks_cbet_stepaside.zig").NielsenWatermarksCbetStepaside;

/// Nielsen CBET
pub const NielsenCBET = struct {
    /// Enter the CBET check digits to use in the watermark.
    cbet_check_digit_string: []const u8,

    /// Determines the method of CBET insertion mode when prior encoding is detected
    /// on the same layer.
    cbet_stepaside: NielsenWatermarksCbetStepaside,

    /// Enter the CBET Source ID (CSID) to use in the watermark
    csid: []const u8,

    pub const json_field_names = .{
        .cbet_check_digit_string = "CbetCheckDigitString",
        .cbet_stepaside = "CbetStepaside",
        .csid = "Csid",
    };
};

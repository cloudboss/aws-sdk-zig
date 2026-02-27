const F4vMoovPlacement = @import("f4_v_moov_placement.zig").F4vMoovPlacement;

/// Settings for F4v container
pub const F4vSettings = struct {
    /// To place the MOOV atom at the beginning of your output, which is useful for
    /// progressive downloading: Leave blank or choose Progressive download. To
    /// place the MOOV at the end of your output: Choose Normal.
    moov_placement: ?F4vMoovPlacement,

    pub const json_field_names = .{
        .moov_placement = "MoovPlacement",
    };
};

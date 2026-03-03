const Frequency = @import("frequency.zig").Frequency;
const Polarization = @import("polarization.zig").Polarization;

/// Information about the uplink spectral `Config`.
pub const UplinkSpectrumConfig = struct {
    /// Center frequency of an uplink spectral `Config`. Valid values are between
    /// 2025 to 2120 MHz.
    center_frequency: Frequency,

    /// Polarization of an uplink spectral `Config`. Capturing both `"RIGHT_HAND"`
    /// and `"LEFT_HAND"` polarization requires two separate configs.
    polarization: ?Polarization = null,

    pub const json_field_names = .{
        .center_frequency = "centerFrequency",
        .polarization = "polarization",
    };
};

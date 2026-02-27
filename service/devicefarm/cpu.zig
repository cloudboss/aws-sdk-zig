/// Represents the amount of CPU that an app is using on a physical device. Does
/// not represent system-wide
/// CPU usage.
pub const CPU = struct {
    /// The CPU's architecture (for example, x86 or ARM).
    architecture: ?[]const u8,

    /// The clock speed of the device's CPU, expressed in hertz (Hz). For example, a
    /// 1.2
    /// GHz CPU is expressed as 1200000000.
    clock: ?f64,

    /// The CPU's frequency.
    frequency: ?[]const u8,

    pub const json_field_names = .{
        .architecture = "architecture",
        .clock = "clock",
        .frequency = "frequency",
    };
};

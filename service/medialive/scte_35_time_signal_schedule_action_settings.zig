const Scte35Descriptor = @import("scte_35_descriptor.zig").Scte35Descriptor;

/// Settings for a SCTE-35 time_signal.
pub const Scte35TimeSignalScheduleActionSettings = struct {
    /// The list of SCTE-35 descriptors accompanying the SCTE-35 time_signal.
    scte_35_descriptors: []const Scte35Descriptor,

    pub const json_field_names = .{
        .scte_35_descriptors = "Scte35Descriptors",
    };
};

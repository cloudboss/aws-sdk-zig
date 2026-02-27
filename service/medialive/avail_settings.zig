const Esam = @import("esam.zig").Esam;
const Scte35SpliceInsert = @import("scte_35_splice_insert.zig").Scte35SpliceInsert;
const Scte35TimeSignalApos = @import("scte_35_time_signal_apos.zig").Scte35TimeSignalApos;

/// Avail Settings
pub const AvailSettings = struct {
    esam: ?Esam,

    scte_35_splice_insert: ?Scte35SpliceInsert,

    scte_35_time_signal_apos: ?Scte35TimeSignalApos,

    pub const json_field_names = .{
        .esam = "Esam",
        .scte_35_splice_insert = "Scte35SpliceInsert",
        .scte_35_time_signal_apos = "Scte35TimeSignalApos",
    };
};

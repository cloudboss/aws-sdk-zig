const ScteFilter = @import("scte_filter.zig").ScteFilter;
const ScteInSegments = @import("scte_in_segments.zig").ScteInSegments;

/// The SCTE configuration.
pub const Scte = struct {
    /// The SCTE-35 message types that you want to be treated as ad markers in the
    /// output.
    scte_filter: ?[]const ScteFilter,

    /// Controls whether SCTE-35 messages are included in segment files.
    ///
    /// * None – SCTE-35 messages are not included in segments (default)
    /// * All – SCTE-35 messages are embedded in segment data
    ///
    /// For DASH manifests, when set to `All`, an `InbandEventStream` tag signals
    /// that SCTE messages are present in segments. This setting works independently
    /// of manifest ad markers.
    scte_in_segments: ?ScteInSegments,

    pub const json_field_names = .{
        .scte_filter = "ScteFilter",
        .scte_in_segments = "ScteInSegments",
    };
};

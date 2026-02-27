/// Cmaf Ingest Segment Length Units
pub const CmafIngestSegmentLengthUnits = enum {
    milliseconds,
    seconds,

    pub const json_field_names = .{
        .milliseconds = "MILLISECONDS",
        .seconds = "SECONDS",
    };
};

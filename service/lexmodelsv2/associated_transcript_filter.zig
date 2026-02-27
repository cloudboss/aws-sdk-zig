const AssociatedTranscriptFilterName = @import("associated_transcript_filter_name.zig").AssociatedTranscriptFilterName;

/// Filters to search for the associated transcript.
pub const AssociatedTranscriptFilter = struct {
    /// The name of the field to use for filtering. The allowed names are
    /// IntentId and SlotTypeId.
    name: AssociatedTranscriptFilterName,

    /// The values to use to filter the transcript.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};

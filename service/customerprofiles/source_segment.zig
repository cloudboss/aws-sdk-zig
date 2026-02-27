/// The source segments to build off of.
pub const SourceSegment = struct {
    /// The unique name of the segment definition.
    segment_definition_name: ?[]const u8,

    pub const json_field_names = .{
        .segment_definition_name = "SegmentDefinitionName",
    };
};

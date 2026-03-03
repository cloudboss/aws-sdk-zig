const aws = @import("aws");

const SegmentType = @import("segment_type.zig").SegmentType;

/// Object holding the segment definition fields.
pub const SegmentDefinitionItem = struct {
    /// When the segment definition was created.
    created_at: ?i64 = null,

    /// The description of the segment definition.
    description: ?[]const u8 = null,

    /// Display name of the segment definition.
    display_name: ?[]const u8 = null,

    /// The arn of the segment definition.
    segment_definition_arn: ?[]const u8 = null,

    /// Name of the segment definition.
    segment_definition_name: ?[]const u8 = null,

    /// The segment type.
    ///
    /// Classic : Segments created using traditional SegmentGroup structure
    ///
    /// Enhanced : Segments created using SQL queries
    segment_type: ?SegmentType = null,

    /// The tags belonging to the segment definition.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .display_name = "DisplayName",
        .segment_definition_arn = "SegmentDefinitionArn",
        .segment_definition_name = "SegmentDefinitionName",
        .segment_type = "SegmentType",
        .tags = "Tags",
    };
};

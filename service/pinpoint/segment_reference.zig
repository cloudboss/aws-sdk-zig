/// Specifies the segment identifier and version of a segment.
pub const SegmentReference = struct {
    /// The unique identifier for the segment.
    id: []const u8,

    /// The version number of the segment.
    version: ?i32,

    pub const json_field_names = .{
        .id = "Id",
        .version = "Version",
    };
};

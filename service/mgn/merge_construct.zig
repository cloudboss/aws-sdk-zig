/// A construct reference specifying the source segment and construct to merge.
pub const MergeConstruct = struct {
    /// The construct ID to merge.
    construct_id: ?[]const u8 = null,

    /// The segment ID of the construct to merge.
    segment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .construct_id = "constructID",
        .segment_id = "segmentID",
    };
};

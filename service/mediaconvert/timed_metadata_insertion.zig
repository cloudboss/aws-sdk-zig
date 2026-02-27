const Id3Insertion = @import("id_3_insertion.zig").Id3Insertion;

/// Insert user-defined custom ID3 metadata at timecodes that you specify. In
/// each output that you want to include this metadata, you must set ID3
/// metadata to Passthrough.
pub const TimedMetadataInsertion = struct {
    /// Id3Insertions contains the array of Id3Insertion instances.
    id_3_insertions: ?[]const Id3Insertion,

    pub const json_field_names = .{
        .id_3_insertions = "Id3Insertions",
    };
};

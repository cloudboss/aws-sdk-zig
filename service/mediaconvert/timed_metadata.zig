/// Set ID3 metadata to Passthrough to include ID3 metadata in this output. This
/// includes ID3 metadata from the following features: ID3 timestamp period, and
/// Custom ID3 metadata inserter. To exclude this ID3 metadata in this output:
/// set ID3 metadata to None or leave blank.
pub const TimedMetadata = enum {
    passthrough,
    none,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .none = "NONE",
    };
};

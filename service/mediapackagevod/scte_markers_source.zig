pub const ScteMarkersSource = enum {
    segments,
    manifest,

    pub const json_field_names = .{
        .segments = "SEGMENTS",
        .manifest = "MANIFEST",
    };
};

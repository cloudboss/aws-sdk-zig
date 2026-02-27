pub const TapeStorageClass = enum {
    deep_archive,
    glacier,

    pub const json_field_names = .{
        .deep_archive = "DEEP_ARCHIVE",
        .glacier = "GLACIER",
    };
};

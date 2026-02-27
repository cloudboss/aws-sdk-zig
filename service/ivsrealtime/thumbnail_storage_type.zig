pub const ThumbnailStorageType = enum {
    sequential,
    latest,

    pub const json_field_names = .{
        .sequential = "SEQUENTIAL",
        .latest = "LATEST",
    };
};

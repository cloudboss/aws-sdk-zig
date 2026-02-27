/// The storage configuration used for recommendations.
pub const StorageConfiguration = struct {
    /// The storage volume.
    size_in_gb: ?f64,

    /// The storage type.
    type: ?[]const u8,

    pub const json_field_names = .{
        .size_in_gb = "sizeInGb",
        .type = "type",
    };
};

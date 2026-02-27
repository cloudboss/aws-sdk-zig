/// The Amazon S3 object that is the asset.
pub const S3SnapshotAsset = struct {
    /// The size of the Amazon S3 object that is the object.
    size: f64 = 0,

    pub const json_field_names = .{
        .size = "Size",
    };
};

/// Options for enabling S3 vectors engine features on the specified domain.
pub const S3VectorsEngine = struct {
    /// Enables S3 vectors engine features.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};

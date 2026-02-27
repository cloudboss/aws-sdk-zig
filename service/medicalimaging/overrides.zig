/// Specifies the overrides used in image set modification calls to
/// `CopyImageSet` and `UpdateImageSetMetadata`.
pub const Overrides = struct {
    /// Providing this parameter will force completion of the `CopyImageSet` and
    /// `UpdateImageSetMetadata` actions, even if metadata is inconsistent at the
    /// Patient, Study, and/or Series levels.
    forced: ?bool,

    pub const json_field_names = .{
        .forced = "forced",
    };
};

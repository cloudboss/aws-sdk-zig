/// Describes the ID format for a resource.
pub const IdFormat = struct {
    /// The date in UTC at which you are permanently switched over to using longer
    /// IDs. If a deadline is not yet available for this resource type, this field
    /// is not returned.
    deadline: ?i64,

    /// The type of resource.
    resource: ?[]const u8,

    /// Indicates whether longer IDs (17-character IDs) are enabled for the
    /// resource.
    use_long_ids: ?bool,
};

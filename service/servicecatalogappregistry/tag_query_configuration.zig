/// The
/// definition
/// of `tagQuery`.
/// Specifies which resources are associated with an
/// application.
pub const TagQueryConfiguration = struct {
    /// Condition
    /// in the IAM policy
    /// that associates resources
    /// to an application.
    tag_key: ?[]const u8,

    pub const json_field_names = .{
        .tag_key = "tagKey",
    };
};

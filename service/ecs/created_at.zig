/// The optional filter to narrow the `ListServiceDeployment` results.
///
/// If you do not specify a value, service deployments that were created before
/// the
/// current time are included in the result.
pub const CreatedAt = struct {
    /// Include service deployments in the result that were created after this time.
    /// The
    /// format is yyyy-MM-dd HH:mm:ss.SSSSSS.
    after: ?i64,

    /// Include service deployments in the result that were created before this
    /// time. The
    /// format is yyyy-MM-dd HH:mm:ss.SSSSSS.
    before: ?i64,

    pub const json_field_names = .{
        .after = "after",
        .before = "before",
    };
};

/// Information about parameters for artifacts associated with the action type,
/// such as
/// the minimum and maximum artifacts allowed.
pub const ActionTypeArtifactDetails = struct {
    /// The maximum number of artifacts that can be used with the actiontype. For
    /// example, you
    /// should specify a minimum and maximum of zero input artifacts for an action
    /// type with a
    /// category of `source`.
    maximum_count: i32 = 0,

    /// The minimum number of artifacts that can be used with the action type. For
    /// example,
    /// you should specify a minimum and maximum of zero input artifacts for an
    /// action type with
    /// a category of `source`.
    minimum_count: i32 = 0,

    pub const json_field_names = .{
        .maximum_count = "maximumCount",
        .minimum_count = "minimumCount",
    };
};

/// Summary counts of each Proton resource types.
pub const ResourceCountsSummary = struct {
    /// The number of resources of this type in the Amazon Web Services account that
    /// need a major template version update.
    behind_major: ?i32,

    /// The number of resources of this type in the Amazon Web Services account that
    /// need a minor template version update.
    behind_minor: ?i32,

    /// The number of resources of this type in the Amazon Web Services account that
    /// failed to deploy.
    failed: ?i32,

    /// The total number of resources of this type in the Amazon Web Services
    /// account.
    total: i32,

    /// The number of resources of this type in the Amazon Web Services account that
    /// are up-to-date with their template.
    up_to_date: ?i32,

    pub const json_field_names = .{
        .behind_major = "behindMajor",
        .behind_minor = "behindMinor",
        .failed = "failed",
        .total = "total",
        .up_to_date = "upToDate",
    };
};

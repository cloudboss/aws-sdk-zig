/// The number of Amazon Web Services resources or Config rules responsible for
/// the current compliance of the item, up to a maximum
/// number.
pub const ComplianceContributorCount = struct {
    /// Indicates whether the maximum count is reached.
    cap_exceeded: bool = false,

    /// The number of Amazon Web Services resources or Config rules responsible for
    /// the current compliance of the item.
    capped_count: i32 = 0,

    pub const json_field_names = .{
        .cap_exceeded = "CapExceeded",
        .capped_count = "CappedCount",
    };
};

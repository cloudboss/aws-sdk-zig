/// Contains counts of resources for trend analysis.
pub const ResourcesCount = struct {
    /// The total count of all resources for the given time interval.
    all_resources: i64,

    pub const json_field_names = .{
        .all_resources = "AllResources",
    };
};

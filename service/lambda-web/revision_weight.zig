/// Specifies a revision and its traffic weight for an endpoint. Up to two
/// revisions can be assigned weights to split traffic for canary or blue-green
/// deployments.
pub const RevisionWeight = struct {
    /// The identifier of the revision.
    revision_id: []const u8,

    /// The percentage of traffic to route to this revision. Minimum value of 1,
    /// maximum value of 100.
    weight: i32,

    pub const json_field_names = .{
        .revision_id = "revisionId",
        .weight = "weight",
    };
};

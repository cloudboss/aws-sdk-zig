/// Returns information about the details of an artifact.
pub const ArtifactDetails = struct {
    /// The maximum number of artifacts allowed for the action type.
    maximum_count: i32 = 0,

    /// The minimum number of artifacts allowed for the action type.
    minimum_count: i32 = 0,

    pub const json_field_names = .{
        .maximum_count = "maximumCount",
        .minimum_count = "minimumCount",
    };
};

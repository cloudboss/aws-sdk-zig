/// The filter criteria to be used.
pub const ClusterForImageFilterCriteria = struct {
    /// The resource Id to be used in the filter criteria.
    resource_id: []const u8,

    pub const json_field_names = .{
        .resource_id = "resourceId",
    };
};

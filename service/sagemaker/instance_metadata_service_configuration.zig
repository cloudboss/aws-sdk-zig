/// Information on the IMDS configuration of the notebook instance
pub const InstanceMetadataServiceConfiguration = struct {
    /// Indicates the minimum IMDS version that the notebook instance supports. When
    /// passed as part of `CreateNotebookInstance`, if no value is selected, then it
    /// defaults to IMDSv1. This means that both IMDSv1 and IMDSv2 are supported. If
    /// passed as part of `UpdateNotebookInstance`, there is no default.
    minimum_instance_metadata_service_version: []const u8,

    pub const json_field_names = .{
        .minimum_instance_metadata_service_version = "MinimumInstanceMetadataServiceVersion",
    };
};

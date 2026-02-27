/// Information on the instance metadata service (IMDS) configuration of the
/// notebook instance.
pub const AwsSageMakerNotebookInstanceMetadataServiceConfigurationDetails = struct {
    /// Indicates the minimum IMDS version that the notebook instance supports.
    minimum_instance_metadata_service_version: ?[]const u8,

    pub const json_field_names = .{
        .minimum_instance_metadata_service_version = "MinimumInstanceMetadataServiceVersion",
    };
};

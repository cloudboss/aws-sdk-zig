/// A dependency that is defined for container startup and shutdown.
pub const AwsEcsTaskDefinitionContainerDefinitionsDependsOnDetails = struct {
    /// The dependency condition of the dependent container. Indicates the required
    /// status of the dependent container before the current container can start.
    /// Valid values are as follows:
    ///
    /// * `COMPLETE`
    ///
    /// * `HEALTHY`
    ///
    /// * `SUCCESS`
    ///
    /// * `START`
    condition: ?[]const u8 = null,

    /// The name of the dependent container.
    container_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .condition = "Condition",
        .container_name = "ContainerName",
    };
};

/// Summary information about a service network.
pub const ServiceNetworkSummary = struct {
    /// The Amazon Resource Name (ARN) of the service network.
    arn: ?[]const u8 = null,

    /// The date and time that the service network was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The ID of the service network.
    id: ?[]const u8 = null,

    /// The date and time that the service network was last updated, in ISO-8601
    /// format.
    last_updated_at: ?i64 = null,

    /// The name of the service network.
    name: ?[]const u8 = null,

    /// The number of resource configurations associated with a service network.
    number_of_associated_resource_configurations: ?i64 = null,

    /// The number of services associated with the service network.
    number_of_associated_services: ?i64 = null,

    /// The number of VPCs associated with the service network.
    number_of_associated_vp_cs: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .number_of_associated_resource_configurations = "numberOfAssociatedResourceConfigurations",
        .number_of_associated_services = "numberOfAssociatedServices",
        .number_of_associated_vp_cs = "numberOfAssociatedVPCs",
    };
};

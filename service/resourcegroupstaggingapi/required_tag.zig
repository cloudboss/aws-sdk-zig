/// Information that describes the required tags for a given resource type.
pub const RequiredTag = struct {
    /// Describes the CloudFormation resource type assigned the required tag keys.
    cloud_formation_resource_types: ?[]const []const u8 = null,

    /// These tag keys are marked as `required` in the `report_required_tag_for`
    /// block of the effective tag policy.
    reporting_tag_keys: ?[]const []const u8 = null,

    /// Describes the resource type for the required tag keys.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_formation_resource_types = "CloudFormationResourceTypes",
        .reporting_tag_keys = "ReportingTagKeys",
        .resource_type = "ResourceType",
    };
};

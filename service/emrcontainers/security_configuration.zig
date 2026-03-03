const aws = @import("aws");

const SecurityConfigurationData = @import("security_configuration_data.zig").SecurityConfigurationData;

/// Inputs related to the security configuration. Security configurations in
/// Amazon EMR on EKS are templates for different security setups. You can use
/// security
/// configurations to configure the Lake Formation integration setup. You can
/// also
/// create a security configuration to re-use a security setup each time you
/// create a virtual
/// cluster.
pub const SecurityConfiguration = struct {
    /// The ARN (Amazon Resource Name) of the security configuration.
    arn: ?[]const u8 = null,

    /// The date and time that the job run was created.
    created_at: ?i64 = null,

    /// The user who created the job run.
    created_by: ?[]const u8 = null,

    /// The ID of the security configuration.
    id: ?[]const u8 = null,

    /// The name of the security configuration.
    name: ?[]const u8 = null,

    /// Security configuration inputs for the request.
    security_configuration_data: ?SecurityConfigurationData = null,

    /// The tags to assign to the security configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .id = "id",
        .name = "name",
        .security_configuration_data = "securityConfigurationData",
        .tags = "tags",
    };
};

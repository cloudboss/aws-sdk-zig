const PrivateConnectivityStatus = @import("private_connectivity_status.zig").PrivateConnectivityStatus;
const VpcInformation = @import("vpc_information.zig").VpcInformation;

/// Information about the private connectivity configuration for an Outpost.
pub const PrivateConnectivityConfig = struct {
    /// The status of private connectivity for the Outpost. Valid values are
    /// `ENABLED`
    /// and `DISABLED`.
    private_connectivity_status: ?PrivateConnectivityStatus = null,

    /// The Amazon Resource Name (ARN) of the provisioning role in your account that
    /// Amazon Web Services Outposts uses
    /// to establish the service link connection during Outpost installation. This
    /// field is present
    /// only when VPC endpoint-based provisioning is configured.
    provisioning_role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service-linked role that Amazon Web
    /// Services Outposts creates and uses to
    /// provision and attach the network interfaces for private connectivity in your
    /// VPC. The role's
    /// permissions are scoped to the specific Outpost and VPC.
    role_arn: ?[]const u8 = null,

    /// Information about the VPC used for private connectivity.
    vpc_information_list: ?[]const VpcInformation = null,

    pub const json_field_names = .{
        .private_connectivity_status = "PrivateConnectivityStatus",
        .provisioning_role_arn = "ProvisioningRoleArn",
        .role_arn = "RoleArn",
        .vpc_information_list = "VpcInformationList",
    };
};

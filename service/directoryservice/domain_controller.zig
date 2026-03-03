const DomainControllerStatus = @import("domain_controller_status.zig").DomainControllerStatus;

/// Contains information about the domain controllers for a specified directory.
pub const DomainController = struct {
    /// The Availability Zone where the domain controller is located.
    availability_zone: ?[]const u8 = null,

    /// Identifier of the directory where the domain controller resides.
    directory_id: ?[]const u8 = null,

    /// The IP address of the domain controller.
    dns_ip_addr: ?[]const u8 = null,

    /// The IPv6 address of the domain controller.
    dns_ipv_6_addr: ?[]const u8 = null,

    /// Identifies a specific domain controller in the directory.
    domain_controller_id: ?[]const u8 = null,

    /// Specifies when the domain controller was created.
    launch_time: ?i64 = null,

    /// The status of the domain controller.
    status: ?DomainControllerStatus = null,

    /// The date and time that the status was last updated.
    status_last_updated_date_time: ?i64 = null,

    /// A description of the domain controller state.
    status_reason: ?[]const u8 = null,

    /// Identifier of the subnet in the VPC that contains the domain controller.
    subnet_id: ?[]const u8 = null,

    /// The identifier of the VPC that contains the domain controller.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .directory_id = "DirectoryId",
        .dns_ip_addr = "DnsIpAddr",
        .dns_ipv_6_addr = "DnsIpv6Addr",
        .domain_controller_id = "DomainControllerId",
        .launch_time = "LaunchTime",
        .status = "Status",
        .status_last_updated_date_time = "StatusLastUpdatedDateTime",
        .status_reason = "StatusReason",
        .subnet_id = "SubnetId",
        .vpc_id = "VpcId",
    };
};

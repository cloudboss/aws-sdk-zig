const EntryViolation = @import("entry_violation.zig").EntryViolation;

/// Violation detail for the entries in a network ACL resource.
pub const InvalidNetworkAclEntriesViolation = struct {
    /// The network ACL containing the entry violations.
    current_associated_network_acl: ?[]const u8 = null,

    /// Detailed information about the entry violations in the network ACL.
    entry_violations: ?[]const EntryViolation = null,

    /// The subnet that's associated with the network ACL.
    subnet: ?[]const u8 = null,

    /// The Availability Zone where the network ACL is in use.
    subnet_availability_zone: ?[]const u8 = null,

    /// The VPC where the violation was found.
    vpc: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_associated_network_acl = "CurrentAssociatedNetworkAcl",
        .entry_violations = "EntryViolations",
        .subnet = "Subnet",
        .subnet_availability_zone = "SubnetAvailabilityZone",
        .vpc = "Vpc",
    };
};

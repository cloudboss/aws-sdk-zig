const InstanceType = @import("instance_type.zig").InstanceType;

/// Information about ESX versions offered for each EC2 instance type.
pub const InstanceTypeEsxVersionsInfo = struct {
    /// The list of ESX versions offered for this instance type.
    esx_versions: []const []const u8,

    /// The EC2 instance type.
    instance_type: InstanceType,

    pub const json_field_names = .{
        .esx_versions = "esxVersions",
        .instance_type = "instanceType",
    };
};

/// Information about an instance type.
pub const InstanceTypeItem = struct {
    instance_type: ?[]const u8,

    /// The number of default VCPUs in an instance type.
    vcp_us: ?i32,

    pub const json_field_names = .{
        .instance_type = "InstanceType",
        .vcp_us = "VCPUs",
    };
};

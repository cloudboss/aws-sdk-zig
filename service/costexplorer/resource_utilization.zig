const EC2ResourceUtilization = @import("ec2_resource_utilization.zig").EC2ResourceUtilization;

/// Resource utilization of current resource.
pub const ResourceUtilization = struct {
    /// The utilization of current Amazon EC2 instance.
    ec2_resource_utilization: ?EC2ResourceUtilization = null,

    pub const json_field_names = .{
        .ec2_resource_utilization = "EC2ResourceUtilization",
    };
};

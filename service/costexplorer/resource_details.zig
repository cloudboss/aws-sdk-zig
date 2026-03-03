const EC2ResourceDetails = @import("ec2_resource_details.zig").EC2ResourceDetails;

/// Details for the resource.
pub const ResourceDetails = struct {
    /// Details for the Amazon EC2 resource.
    ec2_resource_details: ?EC2ResourceDetails = null,

    pub const json_field_names = .{
        .ec2_resource_details = "EC2ResourceDetails",
    };
};

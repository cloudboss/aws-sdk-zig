const Tag = @import("tag.zig").Tag;

/// Details about the EKS cluster involved in a Kubernetes finding.
pub const EksClusterDetails = struct {
    /// EKS cluster ARN.
    arn: ?[]const u8,

    /// The timestamp when the EKS cluster was created.
    created_at: ?i64,

    /// EKS cluster name.
    name: ?[]const u8,

    /// The EKS cluster status.
    status: ?[]const u8,

    /// The EKS cluster tags.
    tags: ?[]const Tag,

    /// The VPC ID to which the EKS cluster is attached.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .vpc_id = "VpcId",
    };
};

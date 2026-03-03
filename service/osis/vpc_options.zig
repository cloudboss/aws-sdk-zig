const VpcAttachmentOptions = @import("vpc_attachment_options.zig").VpcAttachmentOptions;
const VpcEndpointManagement = @import("vpc_endpoint_management.zig").VpcEndpointManagement;

/// Options that specify the subnets and security groups for an OpenSearch
/// Ingestion
/// VPC endpoint.
pub const VpcOptions = struct {
    /// A list of security groups associated with the VPC endpoint.
    security_group_ids: ?[]const []const u8 = null,

    /// A list of subnet IDs associated with the VPC endpoint.
    subnet_ids: []const []const u8,

    /// Options for attaching a VPC to a pipeline.
    vpc_attachment_options: ?VpcAttachmentOptions = null,

    /// Defines whether you or Amazon OpenSearch Ingestion service create and manage
    /// the VPC endpoint configured for the pipeline.
    vpc_endpoint_management: ?VpcEndpointManagement = null,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_attachment_options = "VpcAttachmentOptions",
        .vpc_endpoint_management = "VpcEndpointManagement",
    };
};

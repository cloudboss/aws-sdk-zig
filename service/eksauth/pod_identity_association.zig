/// Amazon EKS Pod Identity associations provide the ability to manage
/// credentials for your applications, similar to the way that Amazon EC2
/// instance profiles provide credentials to Amazon EC2 instances.
pub const PodIdentityAssociation = struct {
    /// The Amazon Resource Name (ARN) of the EKS Pod Identity association.
    association_arn: []const u8,

    /// The ID of the association.
    association_id: []const u8,

    pub const json_field_names = .{
        .association_arn = "associationArn",
        .association_id = "associationId",
    };
};

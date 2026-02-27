/// This structure specifies the VPC subnets and security groups for the stream,
/// and whether
/// a public IP address is to be used.
pub const SelfManagedKafkaAccessConfigurationVpc = struct {
    /// Specifies the security groups associated with the stream. These security
    /// groups must all
    /// be in the same VPC. You can specify as many as five security groups.
    security_group: ?[]const []const u8,

    /// Specifies the subnets associated with the stream. These subnets must all be
    /// in the same
    /// VPC. You can specify as many as 16 subnets.
    subnets: ?[]const []const u8,

    pub const json_field_names = .{
        .security_group = "SecurityGroup",
        .subnets = "Subnets",
    };
};

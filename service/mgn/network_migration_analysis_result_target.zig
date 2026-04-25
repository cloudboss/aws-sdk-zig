/// The target resource information for an analysis result.
pub const NetworkMigrationAnalysisResultTarget = struct {
    /// The subnet ID of the target resource.
    subnet_id: ?[]const u8 = null,

    /// The VPC ID of the target resource.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .subnet_id = "subnetID",
        .vpc_id = "vpcID",
    };
};

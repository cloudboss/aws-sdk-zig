const EksConfiguration = @import("eks_configuration.zig").EksConfiguration;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// The source of collected metrics for a scraper.
pub const Source = union(enum) {
    /// The Amazon EKS cluster from which a scraper collects metrics.
    eks_configuration: ?EksConfiguration,
    /// The Amazon VPC configuration for the Prometheus collector when connecting to
    /// Amazon MSK clusters. This configuration enables secure, private network
    /// connectivity between the collector and your Amazon MSK cluster within your
    /// Amazon VPC.
    vpc_configuration: ?VpcConfiguration,

    pub const json_field_names = .{
        .eks_configuration = "eksConfiguration",
        .vpc_configuration = "vpcConfiguration",
    };
};

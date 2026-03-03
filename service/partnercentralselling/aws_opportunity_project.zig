const AwsPartition = @import("aws_partition.zig").AwsPartition;
const ExpectedCustomerSpend = @import("expected_customer_spend.zig").ExpectedCustomerSpend;

/// Captures details about the project associated with the opportunity,
/// including objectives, scope, and customer requirements.
pub const AwsOpportunityProject = struct {
    /// AWS partition where the opportunity will be deployed. Possible values:
    /// `aws-eusc` for AWS European Sovereign Cloud, `null` for all other
    /// partitions.
    aws_partition: ?AwsPartition = null,

    /// Indicates the expected spending by the customer over the course of the
    /// project. This value helps partners and AWS estimate the financial impact of
    /// the opportunity. Use the [AWS Pricing Calculator](https://calculator.aws/#/)
    /// to create an estimate of the customer’s total spend. If only annual
    /// recurring revenue (ARR) is available, distribute it across 12 months to
    /// provide an average monthly value.
    expected_customer_spend: ?[]const ExpectedCustomerSpend = null,

    pub const json_field_names = .{
        .aws_partition = "AwsPartition",
        .expected_customer_spend = "ExpectedCustomerSpend",
    };
};

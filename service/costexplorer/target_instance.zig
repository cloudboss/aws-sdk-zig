const ResourceUtilization = @import("resource_utilization.zig").ResourceUtilization;
const PlatformDifference = @import("platform_difference.zig").PlatformDifference;
const ResourceDetails = @import("resource_details.zig").ResourceDetails;

/// Details on recommended instance.
pub const TargetInstance = struct {
    /// The currency code that Amazon Web Services used to calculate the costs for
    /// this
    /// instance.
    currency_code: ?[]const u8,

    /// Determines whether this recommendation is the defaulted Amazon Web Services
    /// recommendation.
    default_target_instance: bool = false,

    /// The expected cost to operate this instance type on a monthly basis.
    estimated_monthly_cost: ?[]const u8,

    /// The estimated savings that result from modification, on a monthly basis.
    estimated_monthly_savings: ?[]const u8,

    /// The expected utilization metrics for target instance type.
    expected_resource_utilization: ?ResourceUtilization,

    /// Explains the actions that you might need to take to successfully migrate
    /// your
    /// workloads from the current instance type to the recommended instance type.
    platform_differences: ?[]const PlatformDifference,

    /// Details on the target instance type.
    resource_details: ?ResourceDetails,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .default_target_instance = "DefaultTargetInstance",
        .estimated_monthly_cost = "EstimatedMonthlyCost",
        .estimated_monthly_savings = "EstimatedMonthlySavings",
        .expected_resource_utilization = "ExpectedResourceUtilization",
        .platform_differences = "PlatformDifferences",
        .resource_details = "ResourceDetails",
    };
};

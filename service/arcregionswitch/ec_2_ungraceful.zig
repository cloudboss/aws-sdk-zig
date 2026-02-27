/// Configuration for handling failures when performing operations on EC2
/// resources.
pub const Ec2Ungraceful = struct {
    /// The minimum success percentage that you specify for EC2 Auto Scaling groups.
    minimum_success_percentage: i32,

    pub const json_field_names = .{
        .minimum_success_percentage = "minimumSuccessPercentage",
    };
};

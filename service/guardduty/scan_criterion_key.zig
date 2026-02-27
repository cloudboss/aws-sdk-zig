/// An enum value representing possible resource properties to match with given
/// scan
/// condition.
pub const ScanCriterionKey = enum {
    ec2_instance_tag,

    pub const json_field_names = .{
        .ec2_instance_tag = "EC2_INSTANCE_TAG",
    };
};

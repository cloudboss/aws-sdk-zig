/// Describes an auto scaling process that has been suspended.
///
/// For more information, see [Types
/// of
/// processes](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html#process-types) in the *Amazon EC2 Auto Scaling User Guide*.
pub const SuspendedProcess = struct {
    /// The name of the suspended process.
    process_name: ?[]const u8 = null,

    /// The reason that the process was suspended.
    suspension_reason: ?[]const u8 = null,
};

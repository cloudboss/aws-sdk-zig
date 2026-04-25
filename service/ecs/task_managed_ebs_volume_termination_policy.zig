/// The termination policy for the Amazon EBS volume when the task exits. For
/// more information, see [Amazon ECS volume termination
/// policy](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ebs-volumes.html#ebs-volume-types).
pub const TaskManagedEBSVolumeTerminationPolicy = struct {
    /// Indicates whether the volume should be deleted on when the task stops. If a
    /// value of `true` is specified, Amazon ECS deletes the Amazon EBS volume on
    /// your behalf when the task goes into the `STOPPED` state. If no value is
    /// specified, the default value is `true` is used. When set to `false`, Amazon
    /// ECS leaves the volume in your account.
    delete_on_termination: bool,

    pub const json_field_names = .{
        .delete_on_termination = "deleteOnTermination",
    };
};

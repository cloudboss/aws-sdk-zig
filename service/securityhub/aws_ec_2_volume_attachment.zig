/// An attachment to an Amazon EC2 volume.
pub const AwsEc2VolumeAttachment = struct {
    /// The datetime when the attachment initiated.
    attach_time: ?[]const u8,

    /// Whether the EBS volume is deleted when the EC2 instance is terminated.
    delete_on_termination: ?bool,

    /// The identifier of the EC2 instance.
    instance_id: ?[]const u8,

    /// The attachment state of the volume. Valid values are as follows:
    ///
    /// * `attaching`
    ///
    /// * `attached`
    ///
    /// * `busy`
    ///
    /// * `detaching`
    ///
    /// * `detached`
    status: ?[]const u8,

    pub const json_field_names = .{
        .attach_time = "AttachTime",
        .delete_on_termination = "DeleteOnTermination",
        .instance_id = "InstanceId",
        .status = "Status",
    };
};

/// Information about the network interface attachment.
pub const AwsEc2NetworkInterfaceAttachment = struct {
    /// The identifier of the network interface attachment
    attachment_id: ?[]const u8,

    /// Indicates when the attachment initiated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    attach_time: ?[]const u8,

    /// Indicates whether the network interface is deleted when the instance is
    /// terminated.
    delete_on_termination: ?bool,

    /// The device index of the network interface attachment on the instance.
    device_index: ?i32,

    /// The ID of the instance.
    instance_id: ?[]const u8,

    /// The Amazon Web Services account ID of the owner of the instance.
    instance_owner_id: ?[]const u8,

    /// The attachment state.
    ///
    /// Valid values: `attaching` | `attached` | `detaching` |
    /// `detached`
    status: ?[]const u8,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .attach_time = "AttachTime",
        .delete_on_termination = "DeleteOnTermination",
        .device_index = "DeviceIndex",
        .instance_id = "InstanceId",
        .instance_owner_id = "InstanceOwnerId",
        .status = "Status",
    };
};

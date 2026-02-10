/// Describes information used to set up an EBS volume specified in a block
/// device
/// mapping.
pub const EbsInstanceBlockDeviceSpecification = struct {
    /// Indicates whether the volume is deleted on instance termination.
    delete_on_termination: ?bool,

    /// The ID of the EBS volume.
    volume_id: ?[]const u8,
};

/// Contains information about an MFA device.
///
/// This data type is used as a response element in the
/// [ListMFADevices](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListMFADevices.html)
/// operation.
pub const MFADevice = struct {
    /// The date when the MFA device was enabled for the user.
    enable_date: i64,

    /// The serial number that uniquely identifies the MFA device. For virtual MFA
    /// devices, the
    /// serial number is the device ARN.
    serial_number: []const u8,

    /// The user with whom the MFA device is associated.
    user_name: []const u8,
};

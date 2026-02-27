/// Information identifying the person picking up the device.
pub const PickupDetails = struct {
    /// The unique ID for a device that will be picked up.
    device_pickup_id: ?[]const u8,

    /// The email address of the person picking up the device.
    email: ?[]const u8,

    /// Expiration date of the credential identifying the person picking up the
    /// device.
    identification_expiration_date: ?i64,

    /// Organization that issued the credential identifying the person picking up
    /// the device.
    identification_issuing_org: ?[]const u8,

    /// The number on the credential identifying the person picking up the device.
    identification_number: ?[]const u8,

    /// The name of the person picking up the device.
    name: ?[]const u8,

    /// The phone number of the person picking up the device.
    phone_number: ?[]const u8,

    pub const json_field_names = .{
        .device_pickup_id = "DevicePickupId",
        .email = "Email",
        .identification_expiration_date = "IdentificationExpirationDate",
        .identification_issuing_org = "IdentificationIssuingOrg",
        .identification_number = "IdentificationNumber",
        .name = "Name",
        .phone_number = "PhoneNumber",
    };
};

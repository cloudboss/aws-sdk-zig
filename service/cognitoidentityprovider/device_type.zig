const AttributeType = @import("attribute_type.zig").AttributeType;

/// Information about a user's device that they've registered for device SRP
/// authentication in your application. For more information, see [Working with
/// user devices in your user
/// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
pub const DeviceType = struct {
    /// Metadata about a user's device, like name and last-access source IP.
    device_attributes: ?[]const AttributeType,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    device_create_date: ?i64,

    /// The device key, for example
    /// `us-west-2_EXAMPLE-a1b2c3d4-5678-90ab-cdef-EXAMPLE22222`.
    device_key: ?[]const u8,

    /// The date when the user last signed in with the device.
    device_last_authenticated_date: ?i64,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    device_last_modified_date: ?i64,

    pub const json_field_names = .{
        .device_attributes = "DeviceAttributes",
        .device_create_date = "DeviceCreateDate",
        .device_key = "DeviceKey",
        .device_last_authenticated_date = "DeviceLastAuthenticatedDate",
        .device_last_modified_date = "DeviceLastModifiedDate",
    };
};

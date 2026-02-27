const DeliveryMediumType = @import("delivery_medium_type.zig").DeliveryMediumType;

/// *This data type is no longer supported.* Applies only to SMS
/// multi-factor authentication (MFA) configurations. Does not apply to
/// time-based one-time
/// password (TOTP) software token MFA configurations.
pub const MFAOptionType = struct {
    /// The attribute name of the MFA option type. The only valid value is
    /// `phone_number`.
    attribute_name: ?[]const u8,

    /// The delivery medium to send the MFA code. You can use this parameter to set
    /// only the
    /// `SMS` delivery medium value.
    delivery_medium: ?DeliveryMediumType,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .delivery_medium = "DeliveryMedium",
    };
};

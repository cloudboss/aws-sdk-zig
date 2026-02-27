const DeliveryMediumType = @import("delivery_medium_type.zig").DeliveryMediumType;

/// The delivery details for an email or SMS message that Amazon Cognito sent
/// for authentication or
/// verification.
pub const CodeDeliveryDetailsType = struct {
    /// The name of the attribute that Amazon Cognito verifies with the code.
    attribute_name: ?[]const u8,

    /// The method that Amazon Cognito used to send the code.
    delivery_medium: ?DeliveryMediumType,

    /// The email address or phone number destination where Amazon Cognito sent the
    /// code.
    destination: ?[]const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .delivery_medium = "DeliveryMedium",
        .destination = "Destination",
    };
};

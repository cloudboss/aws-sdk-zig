const OrderedPhoneNumber = @import("ordered_phone_number.zig").OrderedPhoneNumber;
const PhoneNumberProductType = @import("phone_number_product_type.zig").PhoneNumberProductType;
const PhoneNumberOrderStatus = @import("phone_number_order_status.zig").PhoneNumberOrderStatus;

/// The details of a phone number order created for Amazon Chime.
pub const PhoneNumberOrder = struct {
    /// The phone number order creation time stamp, in ISO 8601 format.
    created_timestamp: ?i64,

    /// The ordered phone number details, such as the phone number in E.164 format
    /// and the phone
    /// number status.
    ordered_phone_numbers: ?[]const OrderedPhoneNumber,

    /// The phone number order ID.
    phone_number_order_id: ?[]const u8,

    /// The phone number order product type.
    product_type: ?PhoneNumberProductType,

    /// The status of the phone number order.
    status: ?PhoneNumberOrderStatus,

    /// The updated phone number order time stamp, in ISO 8601 format.
    updated_timestamp: ?i64,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .ordered_phone_numbers = "OrderedPhoneNumbers",
        .phone_number_order_id = "PhoneNumberOrderId",
        .product_type = "ProductType",
        .status = "Status",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

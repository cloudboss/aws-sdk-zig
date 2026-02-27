const OrderedPhoneNumber = @import("ordered_phone_number.zig").OrderedPhoneNumber;
const PhoneNumberOrderType = @import("phone_number_order_type.zig").PhoneNumberOrderType;
const PhoneNumberProductType = @import("phone_number_product_type.zig").PhoneNumberProductType;
const PhoneNumberOrderStatus = @import("phone_number_order_status.zig").PhoneNumberOrderStatus;

/// The details of an Amazon Chime SDK phone number order.
pub const PhoneNumberOrder = struct {
    /// The phone number order creation time stamp, in ISO 8601 format.
    created_timestamp: ?i64,

    /// The Firm Order Commitment (FOC) date for phone number porting orders. This
    /// field is null
    /// if a phone number order is not a porting order.
    foc_date: ?i64,

    /// The ordered phone number details, such as the phone number in E.164 format
    /// and the phone number status.
    ordered_phone_numbers: ?[]const OrderedPhoneNumber,

    /// The type of phone number being ordered, local or toll-free.
    order_type: ?PhoneNumberOrderType,

    /// The ID of the phone order.
    phone_number_order_id: ?[]const u8,

    /// The phone number order product type.
    product_type: ?PhoneNumberProductType,

    /// The status of the phone number order.
    status: ?PhoneNumberOrderStatus,

    /// The updated phone number order time stamp, in ISO 8601 format.
    updated_timestamp: ?i64,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .foc_date = "FocDate",
        .ordered_phone_numbers = "OrderedPhoneNumbers",
        .order_type = "OrderType",
        .phone_number_order_id = "PhoneNumberOrderId",
        .product_type = "ProductType",
        .status = "Status",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

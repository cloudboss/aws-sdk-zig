const PhoneNumberProductType = @import("phone_number_product_type.zig").PhoneNumberProductType;

/// The phone number ID, product type, or calling name fields to update,
/// used with the BatchUpdatePhoneNumber and UpdatePhoneNumber actions.
pub const UpdatePhoneNumberRequestItem = struct {
    /// The outbound calling name to update.
    calling_name: ?[]const u8 = null,

    /// The name of the phone number.
    name: ?[]const u8 = null,

    /// The phone number ID to update.
    phone_number_id: []const u8,

    /// The product type to update.
    product_type: ?PhoneNumberProductType = null,

    pub const json_field_names = .{
        .calling_name = "CallingName",
        .name = "Name",
        .phone_number_id = "PhoneNumberId",
        .product_type = "ProductType",
    };
};

const PhoneNumberAssociation = @import("phone_number_association.zig").PhoneNumberAssociation;
const CallingNameStatus = @import("calling_name_status.zig").CallingNameStatus;
const PhoneNumberCapabilities = @import("phone_number_capabilities.zig").PhoneNumberCapabilities;
const PhoneNumberProductType = @import("phone_number_product_type.zig").PhoneNumberProductType;
const PhoneNumberStatus = @import("phone_number_status.zig").PhoneNumberStatus;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;

/// A phone number used to call an Amazon
/// Chime SDK Voice Connector.
pub const PhoneNumber = struct {
    /// The phone number's associations.
    associations: ?[]const PhoneNumberAssociation = null,

    /// The outbound calling name associated with the phone number.
    calling_name: ?[]const u8 = null,

    /// The outbound calling name status.
    calling_name_status: ?CallingNameStatus = null,

    /// The phone number's capabilities.
    capabilities: ?PhoneNumberCapabilities = null,

    /// The phone number's country. Format: ISO 3166-1 alpha-2.
    country: ?[]const u8 = null,

    /// The phone number creation timestamp, in ISO 8601 format.
    created_timestamp: ?i64 = null,

    /// The deleted phone number timestamp, in ISO 8601 format.
    deletion_timestamp: ?i64 = null,

    /// The phone number, in E.164 format.
    e164_phone_number: ?[]const u8 = null,

    /// The name of the phone number.
    name: ?[]const u8 = null,

    /// The phone number's order ID.
    order_id: ?[]const u8 = null,

    /// The phone number's ID.
    phone_number_id: ?[]const u8 = null,

    /// The phone number's product type.
    product_type: ?PhoneNumberProductType = null,

    /// The phone number's status.
    status: ?PhoneNumberStatus = null,

    /// The phone number's type.
    @"type": ?PhoneNumberType = null,

    /// The updated phone number timestamp, in ISO 8601 format.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .associations = "Associations",
        .calling_name = "CallingName",
        .calling_name_status = "CallingNameStatus",
        .capabilities = "Capabilities",
        .country = "Country",
        .created_timestamp = "CreatedTimestamp",
        .deletion_timestamp = "DeletionTimestamp",
        .e164_phone_number = "E164PhoneNumber",
        .name = "Name",
        .order_id = "OrderId",
        .phone_number_id = "PhoneNumberId",
        .product_type = "ProductType",
        .status = "Status",
        .@"type" = "Type",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

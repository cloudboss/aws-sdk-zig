const PhoneNumberAssociation = @import("phone_number_association.zig").PhoneNumberAssociation;
const CallingNameStatus = @import("calling_name_status.zig").CallingNameStatus;
const PhoneNumberCapabilities = @import("phone_number_capabilities.zig").PhoneNumberCapabilities;
const PhoneNumberProductType = @import("phone_number_product_type.zig").PhoneNumberProductType;
const PhoneNumberStatus = @import("phone_number_status.zig").PhoneNumberStatus;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;

/// A phone number used for Amazon Chime Business Calling or an Amazon Chime
/// Voice
/// Connector.
pub const PhoneNumber = struct {
    /// The phone number associations.
    associations: ?[]const PhoneNumberAssociation,

    /// The outbound calling name associated with the phone number.
    calling_name: ?[]const u8,

    /// The outbound calling name status.
    calling_name_status: ?CallingNameStatus,

    /// The phone number capabilities.
    capabilities: ?PhoneNumberCapabilities,

    /// The phone number country. Format: ISO 3166-1 alpha-2.
    country: ?[]const u8,

    /// The phone number creation timestamp, in ISO 8601 format.
    created_timestamp: ?i64,

    /// The deleted phone number timestamp, in ISO 8601 format.
    deletion_timestamp: ?i64,

    /// The phone number, in E.164 format.
    e164_phone_number: ?[]const u8,

    /// The phone number ID.
    phone_number_id: ?[]const u8,

    /// The phone number product type.
    product_type: ?PhoneNumberProductType,

    /// The phone number status.
    status: ?PhoneNumberStatus,

    /// The phone number type.
    @"type": ?PhoneNumberType,

    /// The updated phone number timestamp, in ISO 8601 format.
    updated_timestamp: ?i64,

    pub const json_field_names = .{
        .associations = "Associations",
        .calling_name = "CallingName",
        .calling_name_status = "CallingNameStatus",
        .capabilities = "Capabilities",
        .country = "Country",
        .created_timestamp = "CreatedTimestamp",
        .deletion_timestamp = "DeletionTimestamp",
        .e164_phone_number = "E164PhoneNumber",
        .phone_number_id = "PhoneNumberId",
        .product_type = "ProductType",
        .status = "Status",
        .@"type" = "Type",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

const std = @import("std");

pub const ResaleAuthorizationSortBy = enum {
    entity_id,
    name,
    product_id,
    product_name,
    manufacturer_account_id,
    manufacturer_legal_name,
    reseller_account_id,
    reseller_legal_name,
    status,
    offer_extended_status,
    created_date,
    availability_end_date,
    last_modified_date,
    reseller_role,
    source_authorization,
    issuer_account_id,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .name = "Name",
        .product_id = "ProductId",
        .product_name = "ProductName",
        .manufacturer_account_id = "ManufacturerAccountId",
        .manufacturer_legal_name = "ManufacturerLegalName",
        .reseller_account_id = "ResellerAccountID",
        .reseller_legal_name = "ResellerLegalName",
        .status = "Status",
        .offer_extended_status = "OfferExtendedStatus",
        .created_date = "CreatedDate",
        .availability_end_date = "AvailabilityEndDate",
        .last_modified_date = "LastModifiedDate",
        .reseller_role = "ResellerRole",
        .source_authorization = "SourceAuthorization",
        .issuer_account_id = "IssuerAccountId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .entity_id => "EntityId",
            .name => "Name",
            .product_id => "ProductId",
            .product_name => "ProductName",
            .manufacturer_account_id => "ManufacturerAccountId",
            .manufacturer_legal_name => "ManufacturerLegalName",
            .reseller_account_id => "ResellerAccountID",
            .reseller_legal_name => "ResellerLegalName",
            .status => "Status",
            .offer_extended_status => "OfferExtendedStatus",
            .created_date => "CreatedDate",
            .availability_end_date => "AvailabilityEndDate",
            .last_modified_date => "LastModifiedDate",
            .reseller_role => "ResellerRole",
            .source_authorization => "SourceAuthorization",
            .issuer_account_id => "IssuerAccountId",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

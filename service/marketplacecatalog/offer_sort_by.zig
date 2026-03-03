const std = @import("std");

pub const OfferSortBy = enum {
    entity_id,
    name,
    product_id,
    resale_authorization_id,
    release_date,
    availability_end_date,
    buyer_accounts,
    state,
    targeting,
    last_modified_date,
    offer_set_id,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .name = "Name",
        .product_id = "ProductId",
        .resale_authorization_id = "ResaleAuthorizationId",
        .release_date = "ReleaseDate",
        .availability_end_date = "AvailabilityEndDate",
        .buyer_accounts = "BuyerAccounts",
        .state = "State",
        .targeting = "Targeting",
        .last_modified_date = "LastModifiedDate",
        .offer_set_id = "OfferSetId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .entity_id => "EntityId",
            .name => "Name",
            .product_id => "ProductId",
            .resale_authorization_id => "ResaleAuthorizationId",
            .release_date => "ReleaseDate",
            .availability_end_date => "AvailabilityEndDate",
            .buyer_accounts => "BuyerAccounts",
            .state => "State",
            .targeting => "Targeting",
            .last_modified_date => "LastModifiedDate",
            .offer_set_id => "OfferSetId",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

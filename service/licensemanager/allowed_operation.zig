const std = @import("std");

pub const AllowedOperation = enum {
    create_grant,
    checkout_license,
    checkout_borrow_license,
    check_in_license,
    extend_consumption_license,
    list_purchased_licenses,
    create_token,

    pub const json_field_names = .{
        .create_grant = "CreateGrant",
        .checkout_license = "CheckoutLicense",
        .checkout_borrow_license = "CheckoutBorrowLicense",
        .check_in_license = "CheckInLicense",
        .extend_consumption_license = "ExtendConsumptionLicense",
        .list_purchased_licenses = "ListPurchasedLicenses",
        .create_token = "CreateToken",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_grant => "CreateGrant",
            .checkout_license => "CheckoutLicense",
            .checkout_borrow_license => "CheckoutBorrowLicense",
            .check_in_license => "CheckInLicense",
            .extend_consumption_license => "ExtendConsumptionLicense",
            .list_purchased_licenses => "ListPurchasedLicenses",
            .create_token => "CreateToken",
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

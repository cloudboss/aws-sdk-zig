const OrderedPhoneNumberStatus = @import("ordered_phone_number_status.zig").OrderedPhoneNumberStatus;

/// A phone number for which an order has been placed.
pub const OrderedPhoneNumber = struct {
    /// The phone number, in E.164 format.
    e164_phone_number: ?[]const u8,

    /// The phone number status.
    status: ?OrderedPhoneNumberStatus,

    pub const json_field_names = .{
        .e164_phone_number = "E164PhoneNumber",
        .status = "Status",
    };
};

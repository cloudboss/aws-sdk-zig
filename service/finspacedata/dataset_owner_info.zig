/// A structure for Dataset owner info.
pub const DatasetOwnerInfo = struct {
    /// Email address for the Dataset owner.
    email: ?[]const u8,

    /// The name of the Dataset owner.
    name: ?[]const u8,

    /// Phone number for the Dataset owner.
    phone_number: ?[]const u8,

    pub const json_field_names = .{
        .email = "email",
        .name = "name",
        .phone_number = "phoneNumber",
    };
};

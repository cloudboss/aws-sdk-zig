/// Additional tax information in India.
pub const IndiaAdditionalInfo = struct {
    /// India pan information associated with the account.
    pan: ?[]const u8 = null,

    pub const json_field_names = .{
        .pan = "pan",
    };
};

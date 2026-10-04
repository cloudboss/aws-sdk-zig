/// The current calling permission state for a business phone number and a
/// specific WhatsApp end user.
pub const WhatsAppCallPermission = struct {
    /// The time when a temporary permission expires. This value is absent for
    /// permanent permissions and when there is no permission.
    expiration_time: ?i64 = null,

    /// The permission status for the end user.
    status: []const u8,

    pub const json_field_names = .{
        .expiration_time = "expirationTime",
        .status = "status",
    };
};

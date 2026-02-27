/// An object that contains information about the start of authority (SOA)
/// record
/// associated with the identity.
pub const SOARecord = struct {
    /// Administrative contact email from the SOA record.
    admin_email: ?[]const u8,

    /// Primary name server specified in the SOA record.
    primary_name_server: ?[]const u8,

    /// Serial number from the SOA record.
    serial_number: i64 = 0,

    pub const json_field_names = .{
        .admin_email = "AdminEmail",
        .primary_name_server = "PrimaryNameServer",
        .serial_number = "SerialNumber",
    };
};

/// An address list contains a list of emails and domains that are used in
/// MailManager Ingress endpoints and Rules for email management.
pub const AddressList = struct {
    /// The Amazon Resource Name (ARN) of the address list.
    address_list_arn: []const u8,

    /// The identifier of the address list.
    address_list_id: []const u8,

    /// The user-friendly name of the address list.
    address_list_name: []const u8,

    /// The timestamp of when the address list was created.
    created_timestamp: i64,

    /// The timestamp of when the address list was last updated.
    last_updated_timestamp: i64,

    pub const json_field_names = .{
        .address_list_arn = "AddressListArn",
        .address_list_id = "AddressListId",
        .address_list_name = "AddressListName",
        .created_timestamp = "CreatedTimestamp",
        .last_updated_timestamp = "LastUpdatedTimestamp",
    };
};

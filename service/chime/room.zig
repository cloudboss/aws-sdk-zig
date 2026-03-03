/// The Amazon Chime chat room details.
pub const Room = struct {
    /// The Amazon Chime account ID.
    account_id: ?[]const u8 = null,

    /// The identifier of the room creator.
    created_by: ?[]const u8 = null,

    /// The room creation timestamp, in ISO 8601 format.
    created_timestamp: ?i64 = null,

    /// The room name.
    name: ?[]const u8 = null,

    /// The room ID.
    room_id: ?[]const u8 = null,

    /// The room update timestamp, in ISO 8601 format.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .created_by = "CreatedBy",
        .created_timestamp = "CreatedTimestamp",
        .name = "Name",
        .room_id = "RoomId",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

/// The relay resource that can be used as a rule to relay receiving emails to
/// the destination relay server.
pub const Relay = struct {
    /// The timestamp of when the relay was last modified.
    last_modified_timestamp: ?i64 = null,

    /// The unique relay identifier.
    relay_id: ?[]const u8 = null,

    /// The unique relay name.
    relay_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_modified_timestamp = "LastModifiedTimestamp",
        .relay_id = "RelayId",
        .relay_name = "RelayName",
    };
};

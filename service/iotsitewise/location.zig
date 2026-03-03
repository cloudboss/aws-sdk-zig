/// Contains location information about the cited text and where it's stored.
pub const Location = struct {
    /// The URI of the location.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .uri = "uri",
    };
};

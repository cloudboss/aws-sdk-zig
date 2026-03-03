/// Describes the destination of a record.
pub const DestinationInfo = struct {
    /// The ID of the resource created at the destination.
    id: ?[]const u8 = null,

    /// The destination service of the record.
    service: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .service = "service",
    };
};

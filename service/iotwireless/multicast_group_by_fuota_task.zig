/// A multicast group that is associated with a FUOTA task.
pub const MulticastGroupByFuotaTask = struct {
    id: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

/// A list of EC2 instance IDs corresponding to the segments in a trace.
pub const InstanceIdDetail = struct {
    /// The ID of a corresponding EC2 instance.
    id: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

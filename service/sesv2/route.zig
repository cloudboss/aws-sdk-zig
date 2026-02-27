/// An object which contains an AWS-Region and routing status.
pub const Route = struct {
    /// The name of an AWS-Region.
    region: []const u8,

    pub const json_field_names = .{
        .region = "Region",
    };
};
